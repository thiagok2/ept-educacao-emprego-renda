const fs = require('fs');
const { Client } = require('pg');
const mcp = JSON.parse(fs.readFileSync('.mcp.json', 'utf8'));
const args = mcp?.mcpServers?.postgres?.args;
const connString = args[args.length - 1];
(async () => {
  const client = new Client({ connectionString: connString });
  await client.connect();
  const res1 = await client.query("SELECT column_name, data_type FROM information_schema.columns WHERE table_schema='staging' AND table_name='fato_curso_matricula_oferta' ORDER BY ordinal_position");
  console.log('staging.fato_curso_matricula_oferta columns:');
  console.table(res1.rows);
  const res2 = await client.query("SELECT column_name, data_type FROM information_schema.columns WHERE table_schema='dw' AND table_name='dw_ept_curso_ano' ORDER BY ordinal_position");
  console.log('dw.dw_ept_curso_ano columns:');
  console.table(res2.rows);
  await client.end();
})();
