const fs = require('fs');
const { Client } = require('pg');

const mcp = JSON.parse(fs.readFileSync('.mcp.json', 'utf8'));
const args = mcp?.mcpServers?.postgres?.args;
if (!args || args.length === 0) {
  console.error('No postgres args found in .mcp.json');
  process.exit(1);
}
const connString = args[args.length - 1];
const sql = `
INSERT INTO dw.dw_ept_curso_ano (
  ano_referencia, instituicao, instituicao_nome, nome_id_curso,
  tipo_curso, tipo_oferta, modalidade_ensino,
  num_cursos, num_concluintes, num_ingressantes, num_inscritos, num_matriculas, num_vagas,
  numero_de_cursos, numero_de_concluintes, numero_de_ingressantes, numero_de_inscritos,
  numero_de_matriculas, numero_de_vagas, matricula_equivalente_geral,
  fonte_dados, data_carga, lote_carga
)
SELECT
  cmo.ano AS ano_referencia,
  cmo.instituicao,
  cmo.instituicao_nome,
  cmo.nome_id_curso,
  MAX(cmo.tipo_curso) AS tipo_curso,
  MAX(cmo.tipo_oferta) AS tipo_oferta,
  MAX(cmo.modalidade_ensino) AS modalidade_ensino,
  SUM(COALESCE(cmo.num_cursos, 0)) AS num_cursos,
  SUM(COALESCE(cmo.num_concluintes, 0)) AS num_concluintes,
  SUM(COALESCE(cmo.num_ingressantes, 0)) AS num_ingressantes,
  SUM(COALESCE(cmo.num_inscritos, 0)) AS num_inscritos,
  SUM(COALESCE(cmo.num_matriculas, 0)) AS num_matriculas,
  SUM(COALESCE(cmo.num_vagas, 0)) AS num_vagas,
  MAX(dg.numero_de_cursos) AS numero_de_cursos,
  MAX(dg.numero_de_concluintes) AS numero_de_concluintes,
  MAX(dg.numero_de_ingressantes) AS numero_de_ingressantes,
  MAX(dg.numero_de_inscritos) AS numero_de_inscritos,
  MAX(dg.numero_de_matriculas) AS numero_de_matriculas,
  MAX(dg.numero_de_vagas) AS numero_de_vagas,
  MAX(cmo.matricula_equivalente_geral) AS matricula_equivalente_geral,
  'Plataforma Nilo Peçanha' AS fonte_dados,
  now() AS data_carga,
  to_char(now(), 'YYYYMMDDHH24MISS') AS lote_carga
FROM staging.fato_curso_matricula_oferta cmo
LEFT JOIN (
  SELECT
    ano,
    instituicao,
    nome_id_curso,
    tipo_oferta,
    MAX(numero_de_cursos) AS numero_de_cursos,
    MAX(numero_de_concluintes) AS numero_de_concluintes,
    MAX(numero_de_ingressantes) AS numero_de_ingressantes,
    MAX(numero_de_inscritos) AS numero_de_inscritos,
    MAX(numero_de_matriculas) AS numero_de_matriculas,
    MAX(numero_de_vagas) AS numero_de_vagas
  FROM staging.stg_nilo_dados_gerais
  GROUP BY ano, instituicao, nome_id_curso, tipo_oferta
) dg ON cmo.ano = dg.ano
  AND cmo.instituicao = dg.instituicao
  AND cmo.nome_id_curso = dg.nome_id_curso
  AND cmo.tipo_oferta = dg.tipo_oferta
GROUP BY cmo.ano, cmo.instituicao, cmo.instituicao_nome, cmo.nome_id_curso, cmo.tipo_oferta, cmo.modalidade_ensino
ON CONFLICT (ano_referencia, instituicao, nome_id_curso, tipo_oferta, modalidade_ensino) DO UPDATE SET
  instituicao_nome = EXCLUDED.instituicao_nome,
  tipo_curso = EXCLUDED.tipo_curso,
  tipo_oferta = EXCLUDED.tipo_oferta,
  modalidade_ensino = EXCLUDED.modalidade_ensino,
  num_cursos = EXCLUDED.num_cursos,
  num_concluintes = EXCLUDED.num_concluintes,
  num_ingressantes = EXCLUDED.num_ingressantes,
  num_inscritos = EXCLUDED.num_inscritos,
  num_matriculas = EXCLUDED.num_matriculas,
  num_vagas = EXCLUDED.num_vagas,
  numero_de_cursos = EXCLUDED.numero_de_cursos,
  numero_de_concluintes = EXCLUDED.numero_de_concluintes,
  numero_de_ingressantes = EXCLUDED.numero_de_ingressantes,
  numero_de_inscritos = EXCLUDED.numero_de_inscritos,
  numero_de_matriculas = EXCLUDED.numero_de_matriculas,
  numero_de_vagas = EXCLUDED.numero_de_vagas,
  matricula_equivalente_geral = EXCLUDED.matricula_equivalente_geral,
  fonte_dados = EXCLUDED.fonte_dados,
  data_carga = EXCLUDED.data_carga,
  lote_carga = EXCLUDED.lote_carga
`;

(async () => {
  const client = new Client({ connectionString: connString });
  try {
    await client.connect();
    const before = await client.query('SELECT COUNT(*) AS cnt FROM dw.dw_ept_curso_ano');
    console.log('Before count:', before.rows[0].cnt);
    const res = await client.query(sql);
    console.log('Insert executed:', res.command, 'rowCount:', res.rowCount);
    const after = await client.query('SELECT COUNT(*) AS cnt FROM dw.dw_ept_curso_ano');
    console.log('After count:', after.rows[0].cnt);
  } catch (err) {
    console.error('Error loading dw_ept_curso_ano:', err.message);
    process.exit(1);
  } finally {
    await client.end();
  }
})();
