const fs = require('fs');
const { Client } = require('pg');

const mcp = JSON.parse(fs.readFileSync('.mcp.json', 'utf8'));
const args = mcp?.mcpServers?.postgres?.args;
if (!args || args.length === 0) {
  console.error('No postgres args found');
  process.exit(1);
}
const connString = args[args.length - 1];

async function run() {
  const client = new Client({ connectionString: connString });
  await client.connect();

  // list dw tables in dw schema
  const resTables = await client.query(`
    SELECT table_schema, table_name
    FROM information_schema.tables
    WHERE table_schema = 'dw' AND table_name LIKE 'dw_%'
    ORDER BY table_name
  `);

  const tables = resTables.rows;
  const report = [];

  for (const t of tables) {
    const name = t.table_name;
    const schema = t.table_schema;
    // columns
    const colsRes = await client.query(`
      SELECT column_name, data_type, is_nullable, column_default
      FROM information_schema.columns
      WHERE table_schema=$1 AND table_name=$2
      ORDER BY ordinal_position
    `, [schema, name]);
    const columns = colsRes.rows;

    // constraints: primary, unique, foreign keys
    const pkRes = await client.query(`
      SELECT kcu.column_name
      FROM information_schema.table_constraints tc
      JOIN information_schema.key_column_usage kcu
        ON tc.constraint_name = kcu.constraint_name AND tc.table_schema = kcu.table_schema
      WHERE tc.table_schema=$1 AND tc.table_name=$2 AND tc.constraint_type='PRIMARY KEY'
      ORDER BY kcu.ordinal_position
    `, [schema, name]);
    const pkCols = pkRes.rows.map(r=>r.column_name);

    const uniqRes = await client.query(`
      SELECT tc.constraint_name, array_agg(kcu.column_name ORDER BY kcu.ordinal_position) AS cols
      FROM information_schema.table_constraints tc
      JOIN information_schema.key_column_usage kcu
        ON tc.constraint_name = kcu.constraint_name AND tc.table_schema = kcu.table_schema
      WHERE tc.table_schema=$1 AND tc.table_name=$2 AND tc.constraint_type='UNIQUE'
      GROUP BY tc.constraint_name
    `, [schema, name]);
    const uniques = uniqRes.rows.map(r=>{
      if (Array.isArray(r.cols)) return r.cols;
      if (typeof r.cols === 'string') return r.cols.replace(/^\{|\}$/g,'').split(',');
      return [];
    });

    // foreign keys
    const fkRes = await client.query(`
      SELECT
        rc.constraint_name,
        kcu.column_name AS fk_column,
        ccu.table_schema AS referenced_table_schema,
        ccu.table_name AS referenced_table,
        ccu.column_name AS referenced_column
      FROM information_schema.referential_constraints rc
      JOIN information_schema.key_column_usage kcu
        ON kcu.constraint_name = rc.constraint_name
      JOIN information_schema.constraint_column_usage ccu
        ON ccu.constraint_name = rc.unique_constraint_name
      WHERE kcu.table_schema=$1 AND kcu.table_name=$2
      ORDER BY rc.constraint_name, kcu.ordinal_position
    `, [schema, name]);

    // row count
    const countRes = await client.query(`SELECT COUNT(*) AS cnt FROM ${schema}."${name}"`);
    const rowCount = parseInt(countRes.rows[0].cnt,10);

    // critical null checks: consider NOT NULL columns and common key/metric names
    const criticalCols = columns.filter(c => c.is_nullable === 'NO' || /ano|institui|curso|unidade|matricul|concluente|vagas|inscritos|ingressantes|numero|num_/i.test(c.column_name));
    const nulls = {};
    for (const c of criticalCols) {
      const q = `SELECT COUNT(*) AS cnt FROM ${schema}."${name}" WHERE "${c.column_name}" IS NULL`;
      const rr = await client.query(q);
      nulls[c.column_name] = parseInt(rr.rows[0].cnt,10);
    }

    // fk orphan checks
    const fkGroups = {};
    for (const r of fkRes.rows) {
      const key = r.constraint_name;
      if (!fkGroups[key]) fkGroups[key] = { columns: [], ref_table: r.referenced_table, ref_schema: r.referenced_table_schema, ref_columns: [] };
      fkGroups[key].columns.push(r.fk_column);
      fkGroups[key].ref_columns.push(r.referenced_column);
    }

    const orphanCounts = [];
    for (const [ck, info] of Object.entries(fkGroups)) {
      const joinCond = info.columns.map((c,i)=>`t."${c}" = r."${info.ref_columns[i]}"`).join(' AND ');
      const sql = `SELECT COUNT(*) AS cnt FROM ${schema}."${name}" t LEFT JOIN ${info.ref_schema}."${info.ref_table}" r ON ${joinCond} WHERE (${info.columns.map(c=>`t."${c}" IS NOT NULL`).join(' OR ')}) AND r."${info.ref_columns[0]}" IS NULL`;
      try {
        const orr = await client.query(sql);
        orphanCounts.push({constraint: ck, ref_table: info.ref_table, count: parseInt(orr.rows[0].cnt,10)});
      } catch (e) {
        orphanCounts.push({constraint: ck, ref_table: info.ref_table, count: null, error: e.message});
      }
    }

    // compare with fato: heuristic mapping
    const possibleFato = name.replace(/^dw_ept_/, 'fato_');
    let fatoCount = null;
    let fatoTable = null;
    for (const schemaTry of ['staging','public']) {
      try {
        const r = await client.query(`SELECT COUNT(*) AS cnt FROM ${schemaTry}."${possibleFato}"`);
        fatoCount = parseInt(r.rows[0].cnt,10);
        fatoTable = `${schemaTry}.${possibleFato}`;
        break;
      } catch (e) {
        // ignore
      }
    }

    let volumeConsistency = 'N/A';
    if (fatoCount !== null) {
      const diff = Math.abs(rowCount - fatoCount) / Math.max(1, fatoCount);
      volumeConsistency = diff > 0.10 ? `Difference ${((rowCount - fatoCount)/Math.max(1,fatoCount)*100).toFixed(1)}%` : 'OK';
    }

    // co_esfera check
    let coEsferaIssue = null;
    const hasCo = columns.some(c=>c.column_name.toLowerCase().includes('co_esfera') || c.column_name.toLowerCase().includes('relacao_do_orgao') || c.column_name.toLowerCase().includes('orgao_uge'));
    if (hasCo) {
      const candidates = columns.filter(c=>/co_esfera|relacao_do_orgao|orgao_uge/i.test(c.column_name)).map(c=>c.column_name);
      for (const col of candidates) {
        const rr = await client.query(`SELECT COUNT(*) AS cnt FROM ${schema}."${name}" WHERE "${col}" IS NOT NULL AND "${col}" != 'UGE'`);
        const cnt = parseInt(rr.rows[0].cnt,10);
        if (cnt>0) {
          coEsferaIssue = {column: col, count: cnt};
        }
      }
    }

    // duplicates: use unique constraints if available
    let duplicateInfo = null;
    if (uniques.length>0) {
      const qCols = uniques[0].map(c=>`"${c}"`).join(',');
      const dupQ = `SELECT COUNT(*) AS dup_count FROM (SELECT ${qCols}, COUNT(*) AS c FROM ${schema}."${name}" GROUP BY ${qCols} HAVING COUNT(*)>1) x`;
      try {
        const dr = await client.query(dupQ);
        duplicateInfo = parseInt(dr.rows[0].dup_count,10);
      } catch (e) {
        duplicateInfo = null;
      }
    } else {
      duplicateInfo = 'no_unique_constraint';
    }

    report.push({
      schema,
      table: name,
      rowCount,
      columns,
      pkCols,
      uniques,
      nulls,
      orphanCounts,
      fatoTable,
      fatoCount,
      volumeConsistency,
      coEsferaIssue,
      duplicateInfo
    });
  }

  await client.end();
  console.log(JSON.stringify({generated_at: new Date().toISOString(), report}, null, 2));
}

run().catch(e=>{console.error(e); process.exit(1);});