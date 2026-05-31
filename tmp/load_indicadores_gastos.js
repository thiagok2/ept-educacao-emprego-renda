const fs = require('fs');
const path = require('path');
const { Client } = require('pg');
const copyFrom = require('pg-copy-streams').from;

const repoRoot = path.resolve(__dirname, '..');
const envPath = path.join(repoRoot, '.env.local');
const csvPath = path.join(repoRoot, 'dados-fonte', 'nilo', 'IndicadoresGastos.csv');
const sqlPath = path.join(repoRoot, 'tmp', 'stg_nilo_indicadores_gastos.sql');
const tableName = 'stg_nilo_indicadores_gastos';

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
  gastos_correntes_por_matricula_equivalente TEXT,
  gastos_correntes_gastos_totais TEXT,
  gastos_correntes_gastos_correntes TEXT,
  gastos_correntes_inativos_e_pensionistas TEXT,
  gastos_correntes_investimentos_e_inversoes_financeiras TEXT,
  gastos_correntes_precatorios TEXT,
  gastos_correntes_outros_custeios TEXT,
  gastos_correntes_pessoal TEXT,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.${tableName} IS 'Tabela staging para Indicadores de Gastos da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.${tableName}.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.${tableName}.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.${tableName}.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.${tableName}.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.${tableName}.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.${tableName}.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.${tableName}.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.${tableName}.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.${tableName}.gastos_correntes_por_matricula_equivalente IS 'Gastos Correntes por matrícula equivalente. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.gastos_correntes_gastos_totais IS 'Gastos Totais. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.gastos_correntes_gastos_correntes IS 'Gastos Correntes. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.gastos_correntes_inativos_e_pensionistas IS 'Gastos com inativos e pensionistas. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.gastos_correntes_investimentos_e_inversoes_financeiras IS 'Gastos com investimentos e inversões financeiras. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.gastos_correntes_precatorios IS 'Gastos com precatórios. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.gastos_correntes_outros_custeios IS 'Outros custeios. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.gastos_correntes_pessoal IS 'Gastos com pessoal. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.carregado_em IS 'Data e hora da carga do CSV';
`;

fs.writeFileSync(sqlPath, ddl, 'utf8');
console.log(`SQL artifact written to ${sqlPath}`);

async function main() {
  await client.connect();
  try {
    console.log('Executing DDL...');
    await client.query(ddl);

    const copySql = `COPY staging.${tableName} (ano, regiao, uf, estado, organizacao_academica_pnp, instituicao, instituicao_nome, gastos_correntes_por_matricula_equivalente, gastos_correntes_gastos_totais, gastos_correntes_gastos_correntes, gastos_correntes_inativos_e_pensionistas, gastos_correntes_investimentos_e_inversoes_financeiras, gastos_correntes_precatorios, gastos_correntes_outros_custeios, gastos_correntes_pessoal) FROM STDIN WITH CSV HEADER DELIMITER ';' ENCODING 'UTF8' NULL ''`;
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
