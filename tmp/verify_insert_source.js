const fs = require('fs');
const { Client } = require('pg');
const mcp = JSON.parse(fs.readFileSync('.mcp.json','utf8'));
const conn = mcp.mcpServers.postgres.args[mcp.mcpServers.postgres.args.length - 1];
(async () => {
  const client = new Client({ connectionString: conn });
  await client.connect();
  const res = await client.query("SELECT table_schema, table_name FROM information_schema.tables WHERE table_name IN ('dw_ept_curso_ano','fato_curso_matricula_oferta') ORDER BY table_schema, table_name");
  console.log('tables:', JSON.stringify(res.rows, null, 2));
  try {
    const count = await client.query('SELECT COUNT(*) AS cnt FROM staging.fato_curso_matricula_oferta');
    console.log('staging.fato_curso_matricula_oferta count:', count.rows[0].cnt);
  } catch (err) {
    console.error('staging count error:', err.message);
  }
  await client.end();
})();
