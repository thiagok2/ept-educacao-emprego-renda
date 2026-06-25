const fs = require('fs');
const path = require('path');
const raw = fs.readFileSync('tmp/dw_readiness_report.json','utf8');
const report = JSON.parse(raw.replace(/^\uFEFF/, ''));
const ddlFile = fs.readFileSync('tmp/dw_ept_restructure.sql','utf8');

function statusFor(entry){
  // rules
  if (entry.rowCount === 0) return '❌';
  if ((entry.orphanCounts||[]).some(o=>o.count>0)) return '❌';
  // not-null columns with nulls
  const notnullNulls = Object.entries(entry.nulls||{}).filter(([col,cnt])=> cnt>0 && (entry.columns.find(x=>x.column_name===col)?.is_nullable==='NO'));
  if (notnullNulls.length>0) return '❌';
  const criticalNulls = Object.entries(entry.nulls||{}).filter(([col,cnt])=> cnt>0 && /numero|num_|matricul|concluente|ingressante|vagas|inscritos|evadidos/i.test(col));
  if (criticalNulls.length>0) return '⚠️';
  if (entry.volumeConsistency && /^Difference/.test(entry.volumeConsistency)) return '⚠️';
  if (entry.coEsferaIssue) {
    // only treat as issue when column name contains co_esfera
    if (/co_esfera/i.test(entry.coEsferaIssue.column)) return '⚠️';
  }
  if (entry.duplicateInfo && entry.duplicateInfo !== 0 && entry.duplicateInfo !== 'no_unique_constraint') return '❌';
  return '✅';
}

const md = [];
md.push('# Relatório de prontidão das tabelas dw_*');
md.push('');
md.push('| Tabela | Linhas | Nulos críticos | Órfãos FK | Consistência c/ fato | Duplicatas | Status |');
md.push('|--------|--------|----------------|-----------|----------------------|------------|--------|');

const corrections = [];

for(const e of report.report){
  const table = `${e.schema}.${e.table}`;
  const rows = e.rowCount;
  const nullsCritical = Object.entries(e.nulls||{}).filter(([k,v])=> v>0).map(([k,v])=>`${k}:${v}`).join(', ') || '-';
  const orfaos = (e.orphanCounts||[]).map(o=>`${o.ref_table}:${o.count}`).join(', ') || '-';
  const vol = e.volumeConsistency || '-';
  const dups = e.duplicateInfo === 'no_unique_constraint' ? 'no_unique_constraint' : (e.duplicateInfo||0);
  const status = statusFor(e);
  md.push(`| ${e.table} | ${rows} | ${nullsCritical} | ${orfaos} | ${vol} | ${dups} | ${status} |`);

  // build corrections
  if (status === '❌' || status === '⚠️'){
    // priority
    if (e.rowCount===0) {
      // try to extract INSERT from ddl file
      const pattern = new RegExp(`INSERT INTO public\\.${e.table.replace(/^dw_ept_/,'dw_ept_')}([\s\S]*?)ON CONFLICT`, 'm');
      const match = ddlFile.match(new RegExp(`INSERT INTO public\\.${e.table.replace(/^dw_ept_/,'dw_ept_')}([\s\S]*?)ON CONFLICT`,`m`));
      if (match) {
        const insert = match[0].replace(/INSERT INTO public\./g, `INSERT INTO ${e.schema}.`).replace(/ON CONFLICT/g,'ON CONFLICT');
        corrections.push({priority:1, table:e.table, reason:'tabela vazia', sql: insert});
      } else {
        corrections.push({priority:1, table:e.table, reason:'tabela vazia', sql: `-- Inserir dados na tabela ${table}: revisar ETL e executar o INSERT correspondente (origem staging).`});
      }
    }
    // null numeric columns
    for(const [col,cnt] of Object.entries(e.nulls||{})){
      if (cnt>0){
        const colInfo = e.columns.find(c=>c.column_name===col);
        if (colInfo){
          if (/integer|numeric|bigint/.test(colInfo.data_type)){
            corrections.push({priority:2, table:e.table, reason:`${cnt} nulos em coluna numérica ${col}`, sql: `UPDATE ${e.schema}."${e.table}" SET "${col}" = 0 WHERE "${col}" IS NULL;`} );
            corrections.push({priority:2, table:e.table, reason:`validação ${col}`, sql: `SELECT COUNT(*) FROM ${e.schema}."${e.table}" WHERE "${col}" IS NULL;`} );
          } else if (/text/.test(colInfo.data_type)){
            corrections.push({priority:3, table:e.table, reason:`${cnt} nulos em coluna textual ${col}`, sql: `UPDATE ${e.schema}."${e.table}" SET "${col}" = '0' WHERE "${col}" IS NULL;`} );
            corrections.push({priority:3, table:e.table, reason:`validação ${col}`, sql: `SELECT COUNT(*) FROM ${e.schema}."${e.table}" WHERE "${col}" IS NULL;`} );
          }
        }
      }
    }

    // orphan fk
    for(const o of e.orphanCounts||[]){
      if (o.count>0){
        corrections.push({priority:1, table:e.table, reason:`${o.count} órfãos para ref ${o.ref_table}`, sql: `DELETE FROM ${e.schema}."${e.table}" t WHERE NOT EXISTS (SELECT 1 FROM ${o.ref_table} r WHERE r."${o.ref_table.split('.').pop()}" = t."${o.ref_table.split('.').pop()}" );`} );
      }
    }

    // coEsfera
    if (e.coEsferaIssue){
      // treat only if column likely co_esfera
      if (/co_esfera/i.test(e.coEsferaIssue.column)){
        corrections.push({priority:2, table:e.table, reason:`co_esfera diferente de 'UGE' em ${e.coEsferaIssue.count} linhas`, sql: `DELETE FROM ${e.schema}."${e.table}" WHERE "${e.coEsferaIssue.column}" IS NOT NULL AND "${e.coEsferaIssue.column}" != 'UGE';`} );
      } else {
        corrections.push({priority:4, table:e.table, reason:`coEsfera check não aplicável; coluna ${e.coEsferaIssue.column}`, sql: `-- Sem ação: coluna ${e.coEsferaIssue.column} não representa co_esfera (apenas informativo).`} );
      }
    }

    // duplicates
    if (e.duplicateInfo && typeof e.duplicateInfo === 'number' && e.duplicateInfo>0){
      // attempt to use first unique constraint columns as dedup key
      if (e.uniques && e.uniques.length>0){
        const cols = e.uniques[0];
        const pk = e.pkCols[0] || 'ctid';
        const colsList = cols.map(c=>`"${c}"`).join(',');
        corrections.push({priority:1, table:e.table, reason:`${e.duplicateInfo} duplicatas com base em ${cols.join(',')}`, sql: `DELETE FROM ${e.schema}."${e.table}" a USING (SELECT ${colsList}, max("${pk}") AS keep_pk FROM ${e.schema}."${e.table}" GROUP BY ${colsList} HAVING COUNT(*)>1) d WHERE ${cols.map(c=>`a."${c}" = d."${c}"`).join(' AND ')} AND a."${pk}" <> d.keep_pk;`} );
      }
    }

  }
}

// sort corrections by priority
corrections.sort((a,b)=>a.priority-b.priority);

// write outputs
fs.writeFileSync('tmp/dw_readiness_report.md', md.join('\n'));
fs.writeFileSync('tmp/dw_corrections.sql', corrections.map(c=>`-- ${c.table} | ${c.reason}\n${c.sql}\n`).join('\n\n'));
console.log('Generated tmp/dw_readiness_report.md and tmp/dw_corrections.sql');
