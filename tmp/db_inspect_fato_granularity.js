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

const analyses = [
  {
    table: 'fato_curso_matricula_oferta',
    keys: [
      ['ano', 'instituicao', 'nome_unidade_recente', 'nome_id_curso', 'tipo_oferta', 'modalidade_ensino'],
      ['ano', 'instituicao', 'nome_id_curso', 'tipo_oferta', 'modalidade_ensino']
    ]
  },
  {
    table: 'fato_curso_taxa_evasao',
    keys: [
      ['ano', 'instituicao', 'nome_unidade_recente', 'nome_curso', 'tipo_oferta', 'turno_curso'],
      ['ano', 'instituicao', 'nome_curso', 'tipo_oferta', 'turno_curso']
    ]
  },
  {
    table: 'fato_instituicao_demografia',
    keys: [
      ['ano', 'instituicao', 'cor_raca', 'renda_familiar', 'faixa_etaria', 'sexo']
    ]
  },
  {
    table: 'fato_instituicao_orcamentario',
    keys: [
      ['ano', 'instituicao', 'relacao_do_orgao']
    ]
  },
  {
    table: 'fato_instituicao_servidores',
    keys: [
      ['ano', 'instituicao']
    ]
  },
  {
    table: 'fato_unidade_indicadores',
    keys: [
      ['ano', 'instituicao', 'nome_unidade_recente']
    ]
  },
  {
    table: 'fato_unidade_situacao_matricula',
    keys: [
      ['ano', 'instituicao', 'nome_unidade_recente', 'categoria_situacao', 'nome_situacao', 'fluxo_retido']
    ]
  }
];

async function run() {
  await client.connect();
  for (const analysis of analyses) {
    const countRes = await client.query(`SELECT COUNT(*) AS cnt FROM staging.${analysis.table}`);
    console.log(`\nTABLE: ${analysis.table}`);
    console.log(`TOTAL ROWS: ${countRes.rows[0].cnt}`);
    for (const key of analysis.keys) {
      const columns = key.join(', ');
      const query = `SELECT COUNT(DISTINCT (${columns})) AS uniq FROM staging.${analysis.table}`;
      try {
        const res = await client.query(query);
        console.log(`  DISTINCT(${columns}): ${res.rows[0].uniq}`);
      } catch (err) {
        console.error(`  ERROR DISTINCT(${columns}): ${err.message}`);
      }
    }
    if (analysis.table === 'fato_instituicao_orcamentario') {
      const relRes = await client.query(`
        SELECT relacao_do_orgao, COUNT(*) AS cnt
        FROM staging.fato_instituicao_orcamentario
        GROUP BY relacao_do_orgao
        ORDER BY cnt DESC
        LIMIT 20;
      `);
      console.log('  SAMPLE relacao_do_orgao values:');
      relRes.rows.forEach(r => console.log(`    ${r.relacao_do_orgao} (${r.cnt})`));
    }
  }

  console.log('\n--- PNP SOURCE DUPLICATION CHECKS ---');
  const checkQueries = [
    {
      name: 'stg_nilo_panorama_orcamentario duplicates by year/instituicao/relacao_do_orgao',
      query: `
        SELECT COUNT(*) AS rows, COUNT(DISTINCT ROW(ano, instituicao, relacao_do_orgao)) AS uniq
        FROM staging.stg_nilo_panorama_orcamentario;
      `
    },
    {
      name: 'stg_nilo_panorama_orcamentario relacao_do_orgao distinct',
      query: `
        SELECT relacao_do_orgao, COUNT(*) AS cnt
        FROM staging.stg_nilo_panorama_orcamentario
        GROUP BY relacao_do_orgao
        ORDER BY cnt DESC
        LIMIT 20;
      `
    }
  ];
  for (const q of checkQueries) {
    console.log(`\nCHECK: ${q.name}`);
    const res = await client.query(q.query);
    if (res.rows.length === 1) {
      console.log(JSON.stringify(res.rows[0]));
    } else {
      res.rows.forEach(r => console.log(JSON.stringify(r)));
    }
  }

  await client.end();
}

run().catch(err => {
  console.error(err);
  process.exit(1);
});
