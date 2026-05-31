const fs = require('fs');
const path = require('path');
const { Client } = require('pg');
const copyFrom = require('pg-copy-streams').from;

const repoRoot = path.resolve(__dirname, '..');
const envPath = path.join(repoRoot, '.env.local');
const csvPath = path.join(repoRoot, 'dados-fonte', 'nilo', 'TaxaEvasao.csv');
const sqlPath = path.join(repoRoot, 'tmp', 'stg_nilo_taxa_evasao.sql');
const tableName = 'stg_nilo_taxa_evasao';

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
  nome_curso TEXT,
  tipo_curso TEXT,
  tipo_eixo_tecnologico TEXT,
  subeixo_tecnologico TEXT,
  tipo_oferta TEXT,
  turno_curso TEXT,
  modalidade_ensino TEXT,
  nome_fonte_financiamento TEXT,
  numero_de_matriculas INTEGER,
  matriculas_numero_de_evadidos INTEGER,
  matriculas_taxa_de_evasao_percentual TEXT,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.${tableName} IS 'Tabela staging para Taxa de Evasão da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.${tableName}.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.${tableName}.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.${tableName}.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.${tableName}.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.${tableName}.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.${tableName}.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.${tableName}.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.${tableName}.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.${tableName}.nome_unidade_recente IS 'Nome da unidade de ensino, conforme edição mais recente';
COMMENT ON COLUMN staging.${tableName}.nome_curso IS 'Nome do curso';
COMMENT ON COLUMN staging.${tableName}.tipo_curso IS 'Tipo do curso';
COMMENT ON COLUMN staging.${tableName}.tipo_eixo_tecnologico IS 'Tipo de eixo tecnológico';
COMMENT ON COLUMN staging.${tableName}.subeixo_tecnologico IS 'Subeixo tecnológico';
COMMENT ON COLUMN staging.${tableName}.tipo_oferta IS 'Tipo de oferta';
COMMENT ON COLUMN staging.${tableName}.turno_curso IS 'Turno do curso';
COMMENT ON COLUMN staging.${tableName}.modalidade_ensino IS 'Modalidade de ensino';
COMMENT ON COLUMN staging.${tableName}.nome_fonte_financiamento IS 'Nome da fonte de financiamento';
COMMENT ON COLUMN staging.${tableName}.numero_de_matriculas IS 'Número de matrículas';
COMMENT ON COLUMN staging.${tableName}.matriculas_numero_de_evadidos IS 'Número de alunos evadidos';
COMMENT ON COLUMN staging.${tableName}.matriculas_taxa_de_evasao_percentual IS 'Taxa de evasão percentual. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.carregado_em IS 'Data e hora da carga do CSV';
`;

fs.writeFileSync(sqlPath, ddl, 'utf8');
console.log(`SQL artifact written to ${sqlPath}`);

async function main() {
  await client.connect();
  try {
    console.log('Executing DDL...');
    await client.query(ddl);

    const copySql = `COPY staging.${tableName} (ano, regiao, uf, estado, organizacao_academica_pnp, instituicao, instituicao_nome, nome_unidade_recente, nome_curso, tipo_curso, tipo_eixo_tecnologico, subeixo_tecnologico, tipo_oferta, turno_curso, modalidade_ensino, nome_fonte_financiamento, numero_de_matriculas, matriculas_numero_de_evadidos, matriculas_taxa_de_evasao_percentual) FROM STDIN WITH CSV HEADER DELIMITER ';' ENCODING 'UTF8' NULL ''`;
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
