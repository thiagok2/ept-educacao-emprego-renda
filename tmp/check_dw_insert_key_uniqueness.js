const fs = require('fs');
const { Client } = require('pg');
const config = JSON.parse(fs.readFileSync('.mcp.json', 'utf8'));
const conn = config.mcpServers.postgres.args[config.mcpServers.postgres.args.length - 1];
const client = new Client({ connectionString: conn });
const queries = [
  {
    name: 'dw_ept_instituicao_ano',
    sql: `SELECT COUNT(*) AS total, COUNT(DISTINCT ano, instituicao) AS unique_keys FROM staging.fato_instituicao_servidores`
  },
  {
    name: 'dw_ept_orcamentario_uge_ano',
    sql: `SELECT COUNT(*) AS total, COUNT(DISTINCT ano, instituicao, relacao_do_orgao) AS unique_keys FROM staging.fato_instituicao_orcamentario WHERE relacao_do_orgao = 'Órgão da UGE'`
  },
  {
    name: 'dw_ept_instituicao_demografia',
    sql: `SELECT COUNT(*) AS total, COUNT(DISTINCT ano, instituicao, coalesce(cor_raca,'~'), coalesce(renda_familiar,'~'), coalesce(faixa_etaria,'~'), coalesce(sexo,'~')) AS unique_keys FROM staging.fato_instituicao_demografia`
  },
  {
    name: 'dw_ept_unidade_ano',
    sql: `SELECT COUNT(*) AS total, COUNT(DISTINCT ano, instituicao, nome_unidade_recente) AS unique_keys FROM staging.fato_unidade_indicadores`
  },
  {
    name: 'dw_ept_curso_ano',
    sql: `SELECT COUNT(*) AS total, COUNT(DISTINCT ano, instituicao, nome_id_curso, tipo_oferta, modalidade_ensino) AS unique_keys FROM staging.fato_curso_matricula_oferta`
  },
  {
    name: 'dw_ept_curso_periodo',
    sql: `SELECT COUNT(*) AS total, COUNT(DISTINCT ano, instituicao, nome_unidade_recente, nome_curso, tipo_oferta, turno_curso) AS unique_keys FROM staging.fato_curso_taxa_evasao`
  }
];
(async () => {
  try {
    await client.connect();
    for (const q of queries) {
      const res = await client.query(q.sql);
      console.log(`${q.name}:`, res.rows[0]);
    }
    await client.end();
  } catch (err) {
    console.error(err);
    await client.end();
    process.exit(1);
  }
})();
