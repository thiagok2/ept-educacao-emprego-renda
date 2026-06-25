const fs = require('fs');
const { Client } = require('pg');
const mcp = JSON.parse(fs.readFileSync('.mcp.json', 'utf8'));
const args = mcp?.mcpServers?.postgres?.args;
const connString = args[args.length - 1];
(async () => {
  const client = new Client({ connectionString: connString });
  await client.connect();
  const quantityRes = await client.query(`
    SELECT
      COUNT(*) AS total,
      COUNT(*) FILTER (WHERE dg.ano IS NOT NULL) AS matched
    FROM staging.fato_curso_matricula_oferta cmo
    LEFT JOIN staging.stg_nilo_dados_gerais dg
      ON cmo.ano = dg.ano
     AND cmo.instituicao = dg.instituicao
     AND cmo.nome_id_curso = dg.nome_id_curso
     AND cmo.tipo_oferta = dg.tipo_oferta
  `);
  console.log(quantityRes.rows[0]);
  const sampleRes = await client.query(`
    SELECT
      cmo.ano,
      cmo.instituicao,
      cmo.nome_id_curso,
      cmo.tipo_oferta,
      cmo.num_concluintes,
      dg.numero_de_concluintes,
      cmo.num_inscritos,
      dg.numero_de_inscritos,
      cmo.num_matriculas,
      dg.numero_de_matriculas
    FROM staging.fato_curso_matricula_oferta cmo
    LEFT JOIN staging.stg_nilo_dados_gerais dg
      ON cmo.ano = dg.ano
     AND cmo.instituicao = dg.instituicao
     AND cmo.nome_id_curso = dg.nome_id_curso
     AND cmo.tipo_oferta = dg.tipo_oferta
    LIMIT 10
  `);
  console.table(sampleRes.rows);
  await client.end();
})();
