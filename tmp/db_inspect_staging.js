const fs = require('fs');
const { Client } = require('pg');

const mcp = JSON.parse(fs.readFileSync('.mcp.json', 'utf8'));
const args = mcp?.mcpServers?.postgres?.args;
if (!args || args.length === 0) {
  console.error('No postgres args found');
  process.exit(1);
}
const connString = args[args.length - 1];
const client = new Client({ connectionString: connString });

async function run() {
  await client.connect();
  const tablesRes = await client.query(`
    SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = 'staging'
      AND table_type = 'BASE TABLE'
    ORDER BY table_name;
  `);

  const tables = tablesRes.rows.map(r => r.table_name);
  console.log('STAGING TABLES:', tables.length);
  console.log(tables.join('\n'));

  const counts = [];
  for (const table of tables) {
    const res = await client.query(`SELECT COUNT(*) AS cnt FROM staging.${table}`);
    counts.push({ table, count: Number(res.rows[0].cnt) });
  }
  console.log('\nCOUNTS:');
  for (const row of counts) {
    console.log(`${row.table}: ${row.count}`);
  }

  console.log('\nCOLUMN METADATA FOR stg_nilo_%:');
  const colRes = await client.query(`
    SELECT table_name, column_name, data_type, is_nullable
    FROM information_schema.columns
    WHERE table_schema = 'staging'
      AND table_name LIKE 'stg_nilo_%'
    ORDER BY table_name, ordinal_position;
  `);

  let current = null;
  for (const col of colRes.rows) {
    if (col.table_name !== current) {
      current = col.table_name;
      console.log('\n' + current + ':');
    }
    console.log(`  ${col.column_name} | ${col.data_type} | ${col.is_nullable}`);
  }

  await client.end();
}

run().catch(err => {
  console.error(err);
  process.exit(1);
});
