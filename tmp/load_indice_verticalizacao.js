const fs = require('fs');
const path = require('path');
const { Client } = require('pg');
const copyFrom = require('pg-copy-streams').from;

const repoRoot = path.resolve(__dirname, '..');
const envPath = path.join(repoRoot, '.env.local');
const csvPath = path.join(repoRoot, 'dados-fonte', 'nilo', 'IndiceVerticalizacao.csv');
const sqlPath = path.join(repoRoot, 'tmp', 'stg_nilo_indice_verticalizacao.sql');
const tableName = 'stg_nilo_indice_verticalizacao';

const env = fs.readFileSync(envPath, 'utf8')
  .split(/\r?\n/)
  .filter(Boolean)
  .reduce((acc, line) => {
    const match = line.match(/^([^=]+)=(.*)$/);
    if (match) acc[match[1].trim()] = match[2].trim();
    return acc;
  }, {});

const client = new Client({
  host: env.host,
  port: Number(env.port || 5432),
  database: env.database,
  user: env.user,
  password: env.password,
});

const ddl = `DROP TABLE IF EXISTS staging.${tableName};

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.${tableName} (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao VARCHAR(50),
  instituicao_nome TEXT,
  nome_unidade_recente TEXT,
  indice_verticalizacao_vagas_cg INTEGER,
  indice_verticalizacao_vagas_ct INTEGER,
  indice_verticalizacao_vagas_pg INTEGER,
  indice_verticalizacao_vagas_qp INTEGER,
  indice_verticalizacao_eixo_tecnologico TEXT,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.${tableName} IS 'Tabela staging para Índice de Verticalização da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.${tableName}.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.${tableName}.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.${tableName}.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.${tableName}.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.${tableName}.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.${tableName}.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.${tableName}.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.${tableName}.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.${tableName}.nome_unidade_recente IS 'Nome da unidade de ensino, conforme edição mais recente';
COMMENT ON COLUMN staging.${tableName}.indice_verticalizacao_vagas_cg IS 'Número de vagas na categoria CG';
COMMENT ON COLUMN staging.${tableName}.indice_verticalizacao_vagas_ct IS 'Número de vagas na categoria CT';
COMMENT ON COLUMN staging.${tableName}.indice_verticalizacao_vagas_pg IS 'Número de vagas na categoria PG';
COMMENT ON COLUMN staging.${tableName}.indice_verticalizacao_vagas_qp IS 'Número de vagas na categoria QP';
COMMENT ON COLUMN staging.${tableName}.indice_verticalizacao_eixo_tecnologico IS 'Índice de verticalização do eixo tecnológico. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.carregado_em IS 'Data e hora da carga do CSV';
`;

fs.writeFileSync(sqlPath, ddl, 'utf8');
console.log(`SQL artifact written to ${sqlPath}`);

async function main() {
  await client.connect();
  try {
    console.log('Executing DDL...');
    await client.query(ddl);

    const copySql = `COPY staging.${tableName} (ano, regiao, uf, estado, organizacao_academica_pnp, instituicao, instituicao_nome, nome_unidade_recente, indice_verticalizacao_vagas_cg, indice_verticalizacao_vagas_ct, indice_verticalizacao_vagas_pg, indice_verticalizacao_vagas_qp, indice_verticalizacao_eixo_tecnologico) FROM STDIN WITH CSV HEADER DELIMITER ';' ENCODING 'UTF8' NULL ''`;
    const stream = client.query(copyFrom(copySql));
    const fileStream = fs.createReadStream(csvPath, { encoding: 'utf8' });

    await new Promise((resolve, reject) => {
      fileStream.on('error', reject);
      stream.on('error', reject);
      fileStream.pipe(stream).on('finish', resolve).on('error', reject);
    });

    const countRes = await client.query(`SELECT COUNT(*) AS n FROM staging.${tableName}`);
    const rows = Number(countRes.rows[0].n);
    const yearRes = await client.query(`SELECT MIN(ano) AS min_year, MAX(ano) AS max_year FROM staging.${tableName}`);
    const minYear = yearRes.rows[0].min_year;
    const maxYear = yearRes.rows[0].max_year;
    console.log(`Loaded ${rows} rows; coverage ${minYear}-${maxYear}`);
  } finally {
    await client.end();
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
