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
  const queries = [
    `SELECT categoria_situacao, count(*) FROM staging.fato_unidade_situacao_matricula GROUP BY categoria_situacao ORDER BY count DESC;`,
    `SELECT nome_situacao, count(*) FROM staging.fato_unidade_situacao_matricula GROUP BY nome_situacao ORDER BY count DESC LIMIT 100;`,
    `SELECT fluxo_retido, count(*) FROM staging.fato_unidade_situacao_matricula GROUP BY fluxo_retido ORDER BY count DESC;`
  ];
  for (const q of queries) {
    const res = await client.query(q);
    console.log('QUERY:', q);
    console.log(JSON.stringify(res.rows, null, 2));
  }
  await client.end();
}

run().catch(err => {
  console.error(err);
  process.exit(1);
});
