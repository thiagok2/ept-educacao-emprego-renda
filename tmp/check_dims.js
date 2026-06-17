const fs = require('fs');
const { Client } = require('pg');
const mcp = JSON.parse(fs.readFileSync('.mcp.json','utf8'));
const args = mcp?.mcpServers?.postgres?.args;
if (!args || args.length === 0) {
  console.error('No postgres args found');
  process.exit(1);
}
const connString = args[args.length - 1];
const client = new Client({ connectionString: connString });

async function run() {
  await client.connect();
  const res = await client.query(`
    SELECT table_schema, table_name
    FROM information_schema.tables
    WHERE table_name IN ('dim_curso','dim_unidade_academica','dim_instituicao','dim_tempo_ano')
    ORDER BY table_schema, table_name;
  `);
  console.log(JSON.stringify(res.rows, null, 2));
  await client.end();
}

run().catch(err => {
  console.error(err);
  process.exit(1);
});
