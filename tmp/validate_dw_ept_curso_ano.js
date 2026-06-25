const fs = require('fs');
const { Client } = require('pg');
const mcp = JSON.parse(fs.readFileSync('.mcp.json', 'utf8'));
const args = mcp?.mcpServers?.postgres?.args;
const connString = args[args.length - 1];
(async () => {
  const client = new Client({ connectionString: connString });
  await client.connect();
  const summary = await client.query(`
    SELECT
      COUNT(*) AS total,
      COUNT(*) FILTER (WHERE fonte_dados IS NULL) AS null_fonte_dados,
      COUNT(*) FILTER (WHERE tipo_curso IS NULL) AS null_tipo_curso,
      COUNT(*) FILTER (WHERE tipo_oferta IS NULL) AS null_tipo_oferta,
      COUNT(*) FILTER (WHERE modalidade_ensino IS NULL) AS null_modalidade_ensino
    FROM dw.dw_ept_curso_ano
  `);
  console.log(summary.rows[0]);
  await client.end();
})();
