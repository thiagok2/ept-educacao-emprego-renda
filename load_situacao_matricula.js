const { Client } = require('pg');
const copyFrom = require('pg-copy-streams').from;
const fs = require('fs');
const path = require('path');

const connectionString = 'postgresql://postgres.prdkdgexijsyglczfvma:y8h%2FF.A%2B.%406W%2BB_@aws-1-us-east-1.pooler.supabase.com:5432/postgres';
const csvPath = path.join(__dirname, 'dados-fonte', 'nilo', 'SituacaoMatricula.csv');

const ddl = `
CREATE SCHEMA IF NOT EXISTS staging;
DROP TABLE IF EXISTS staging.stg_nilo_situacao_matricula;
CREATE TABLE staging.stg_nilo_situacao_matricula (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao TEXT,
  instituicao_nome TEXT,
  nome_unidade_recente TEXT,
  categoria_situacao TEXT,
  nome_situacao TEXT,
  fluxo_retido TEXT,
  numero_de_matriculas INTEGER,
  carregado_em TIMESTAMP DEFAULT NOW()
);
COMMENT ON TABLE staging.stg_nilo_situacao_matricula IS 'Carga de situação de matrícula da Plataforma Nilo Peçanha.';
COMMENT ON COLUMN staging.stg_nilo_situacao_matricula.ano IS 'Ano de referência.';
COMMENT ON COLUMN staging.stg_nilo_situacao_matricula.regiao IS 'Região do Brasil.';
COMMENT ON COLUMN staging.stg_nilo_situacao_matricula.uf IS 'Unidade Federativa.';
COMMENT ON COLUMN staging.stg_nilo_situacao_matricula.estado IS 'Estado do Brasil.';
COMMENT ON COLUMN staging.stg_nilo_situacao_matricula.organizacao_academica_pnp IS 'Organização acadêmica conforme PNP.';
COMMENT ON COLUMN staging.stg_nilo_situacao_matricula.instituicao IS 'Sigla da instituição.';
COMMENT ON COLUMN staging.stg_nilo_situacao_matricula.instituicao_nome IS 'Nome completo da instituição.';
COMMENT ON COLUMN staging.stg_nilo_situacao_matricula.nome_unidade_recente IS 'Nome da unidade recente.';
COMMENT ON COLUMN staging.stg_nilo_situacao_matricula.categoria_situacao IS 'Categoria da situação do aluno.';
COMMENT ON COLUMN staging.stg_nilo_situacao_matricula.nome_situacao IS 'Descrição da situação de matrícula.';
COMMENT ON COLUMN staging.stg_nilo_situacao_matricula.fluxo_retido IS 'Fluxo retido associado à situação.';
COMMENT ON COLUMN staging.stg_nilo_situacao_matricula.numero_de_matriculas IS 'Número de matrículas para a combinação de situação.';
COMMENT ON COLUMN staging.stg_nilo_situacao_matricula.carregado_em IS 'Data e hora da carga do CSV.';
`;

async function main() {
  const client = new Client({ connectionString });
  await client.connect();

  try {
    await client.query('BEGIN');
    await client.query(ddl);

    const stream = client.query(copyFrom(
      "COPY staging.stg_nilo_situacao_matricula (ano, regiao, uf, estado, organizacao_academica_pnp, instituicao, instituicao_nome, nome_unidade_recente, categoria_situacao, nome_situacao, fluxo_retido, numero_de_matriculas) FROM STDIN WITH CSV HEADER DELIMITER ';'"
    ));

    const fileStream = fs.createReadStream(csvPath);
    fileStream.on('error', (err) => stream.destroy(err));
    stream.on('error', (err) => {
      console.error('COPY error:', err);
      process.exit(1);
    });

    await new Promise((resolve, reject) => {
      stream.on('finish', resolve);
      stream.on('error', reject);
      fileStream.pipe(stream);
    });

    await client.query('COMMIT');
    const res = await client.query('SELECT COUNT(*) AS count FROM staging.stg_nilo_situacao_matricula');
    console.log('ROW_COUNT=' + res.rows[0].count);
  } catch (err) {
    await client.query('ROLLBACK');
    console.error('ERROR:', err);
    process.exit(1);
  } finally {
    await client.end();
  }
}

main().catch((err) => {
  console.error('UNCAUGHT ERROR:', err);
  process.exit(1);
});
