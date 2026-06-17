const fs = require('fs');
const { Client } = require('pg');

const mcp = JSON.parse(fs.readFileSync('.mcp.json', 'utf8'));
const args = mcp?.mcpServers?.postgres?.args;
if (!args || args.length === 0) {
  console.error('No postgres args found');
  process.exit(1);
}
const connString = args[args.length - 1];
const client = new Client({ connectionString: connString });

const tables = [
  'fato_curso_matricula_oferta',
  'fato_curso_taxa_evasao',
  'fato_instituicao_demografia',
  'fato_instituicao_orcamentario',
  'fato_instituicao_servidores',
  'fato_unidade_indicadores',
  'fato_unidade_situacao_matricula',
  'stg_nilo_curso_matricula_oferta',
  'stg_nilo_dados_gerais',
  'stg_nilo_cassificacao_racial_renda_sexo',
  'stg_nilo_eficiencia_academica',
  'stg_nilo_indice_verticalizacao',
  'stg_nilo_oferta_vagas_noturnas',
  'stg_nilo_panorama_orcamentario',
  'stg_nilo_percentuais_legais',
  'stg_nilo_relacao_aluno_professor_rap',
  'stg_nilo_relacao_inscritos_vagas',
  'stg_nilo_reserva_vagas',
  'stg_nilo_situacao_matricula',
  'stg_nilo_taxa_evasao',
  'stg_nilo_taxa_ocupacao',
  'stg_nilo_cargos_carreira',
  'stg_nilo_tecnicos_adm_nivel',
  'stg_nilo_titulacao_docente',
  'stg_nilo_professores_por_instituicao'
];

async function run() {
  await client.connect();
  console.log('--- COUNTS ---');
  for (const table of tables) {
    try {
      const res = await client.query(`SELECT COUNT(*) AS cnt FROM staging.${table}`);
      console.log(`${table}: ${res.rows[0].cnt}`);
    } catch (err) {
      console.error(`${table}: ERROR ${err.message}`);
    }
  }

  console.log('\n--- COLUMN METADATA ---');
  for (const table of tables) {
    console.log(`\n${table}`);
    const res = await client.query(`
      SELECT column_name, data_type, is_nullable
      FROM information_schema.columns
      WHERE table_schema = 'staging' AND table_name = $1
      ORDER BY ordinal_position;
    `, [table]);
    for (const row of res.rows) {
      console.log(`  ${row.column_name} | ${row.data_type} | ${row.is_nullable}`);
    }
  }

  await client.end();
}

run().catch(err => {
  console.error(err);
  process.exit(1);
});
