const fs = require('fs');
const path = require('path');
const { Client } = require('pg');
const copyFrom = require('pg-copy-streams').from;

const repoRoot = path.resolve(__dirname, '..');
const envPath = path.join(repoRoot, '.env.local');
const csvPath = path.join(repoRoot, 'dados-fonte', 'nilo', 'PanoramaOrcamentario.csv');
const sqlPath = path.join(repoRoot, 'tmp', 'stg_nilo_panorama_orcamentario.sql');
const tableName = 'stg_nilo_panorama_orcamentario';

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
  relacao_do_orgao TEXT,
  resultado_primario_cidada TEXT,
  dotacao_atualizada TEXT,
  despesa_empenhada TEXT,
  despesa_liquidada TEXT,
  despesa_paga TEXT,
  despesa_liq_rp TEXT,
  despesa_empenhada_a_liquidar TEXT,
  credito_disponivel TEXT,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.${tableName} IS 'Tabela staging para Panorama Orçamentário da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.${tableName}.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.${tableName}.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.${tableName}.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.${tableName}.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.${tableName}.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.${tableName}.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.${tableName}.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.${tableName}.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.${tableName}.relacao_do_orgao IS 'Relação do órgão dentro da estrutura administrativa';
COMMENT ON COLUMN staging.${tableName}.resultado_primario_cidada IS 'Resultado primário discriminado para o cidadão';
COMMENT ON COLUMN staging.${tableName}.dotacao_atualizada IS 'Dotação atualizada. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.despesa_empenhada IS 'Despesa empenhada. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.despesa_liquidada IS 'Despesa liquidada. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.despesa_paga IS 'Despesa paga. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.despesa_liq_rp IS 'Despesa liq&RP. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.despesa_empenhada_a_liquidar IS 'Despesa empenhada a liquidar. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.credito_disponivel IS 'Crédito disponível. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.${tableName}.carregado_em IS 'Data e hora da carga do CSV';
`;

fs.writeFileSync(sqlPath, ddl, 'utf8');
console.log(`SQL artifact written to ${sqlPath}`);

async function main() {
  await client.connect();
  try {
    console.log('Executing DDL...');
    await client.query(ddl);

    const copySql = `COPY staging.${tableName} (ano, regiao, uf, estado, organizacao_academica_pnp, instituicao, instituicao_nome, relacao_do_orgao, resultado_primario_cidada, dotacao_atualizada, despesa_empenhada, despesa_liquidada, despesa_paga, despesa_liq_rp, despesa_empenhada_a_liquidar, credito_disponivel) FROM STDIN WITH CSV HEADER DELIMITER ';' ENCODING 'UTF8' NULL ''`;
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
