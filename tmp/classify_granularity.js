const fs = require('fs');
const path = require('path');
const root = path.resolve(__dirname, '..');
const catPath = path.join(root, 'leiame_dw_catalogo.md');
const docPath = path.join(root, 'leiame_dw.md');
const classification = {
  'stg_nilo_curso_matricula_oferta': 'Curso/Ano',
  'stg_nilo_situacao_matricula': 'Campus',
  'stg_nilo_cassificacao_racial_renda_sexo': 'Instituição',
  'stg_nilo_dados_gerais': 'Curso/Ano',
  'stg_nilo_cargos_carreira': 'Instituição',
  'stg_nilo_eficiencia_academica': 'Campus',
  'stg_nilo_indice_verticalizacao': 'Campus',
  'stg_nilo_indicadores_gastos': 'Instituição',
  'stg_nilo_taxa_evasao': 'Curso/Período',
  'stg_nilo_taxa_ocupacao': 'Instituição',
  'stg_nilo_oferta_vagas_noturnas': 'Campus',
  'stg_nilo_panorama_orcamentario': 'Instituição',
  'stg_nilo_percentuais_legais': 'Campus',
  'stg_nilo_professores_por_instituicao': 'Instituição',
  'stg_nilo_relacao_aluno_professor_rap': 'Campus',
  'stg_nilo_relacao_inscritos_vagas': 'Campus',
  'stg_nilo_reserva_vagas': 'Campus',
  'stg_nilo_tecnicos_adm_nivel': 'Instituição',
  'stg_nilo_titulacao_docente': 'Instituição',
};

const catText = fs.readFileSync(catPath, 'utf8');
const lines = catText.split(/\r?\n/);
const out = [];
let section = null;
for (const line of lines) {
  out.push(line);
  if (line.startsWith('## ')) {
    section = line.slice(3).trim();
  } else if (section && line.startsWith('- Cobertura temporal:')) {
    const gran = classification[section];
    if (gran) {
      out.push(`- Granularidade: ${gran}`);
      section = null;
    }
  }
}
fs.writeFileSync(catPath, out.join('\n') + '\n', 'utf8');

const mdText = '# Documentação DW\n\n'
  + '## Fase 1 — Inventário\n\n'
  + 'Inventário de tabelas staging criado com base em `NILO.md`.\n\n'
  + '- Arquivo de inventário: `leiame_dw_catalogo.md`\n'
  + '- Fonte principal: metadados já existentes em `NILO.md`\n'
  + '- Não houve consulta direta ao conteúdo das tabelas\n\n'
  + '## Fase 2 — Período\n\n'
  + 'Para todas as tabelas `stg_nilo_*`, os metadados a seguir já estão registrados em `leiame_dw_catalogo.md`:\n'
  + '- `COUNT(*)`: disponível via `Linhas carregadas`\n'
  + '- `MIN(ano)`, `MAX(ano)`: inferidos da `Cobertura temporal`\n\n'
  + 'Resumo de cobertura temporal:\n'
  + '- `stg_nilo_curso_matricula_oferta`: 2017 – 2024\n'
  + '- `stg_nilo_situacao_matricula`: 2024 – 2024\n'
  + '- `stg_nilo_cassificacao_racial_renda_sexo`: 2017 – 2024\n'
  + '- `stg_nilo_dados_gerais`: 2017 – 2024\n'
  + '- `stg_nilo_cargos_carreira`: 2016 – 2023\n'
  + '- `stg_nilo_eficiencia_academica`: 2017 – 2024\n'
  + '- `stg_nilo_indice_verticalizacao`: 2017 – 2024\n'
  + '- `stg_nilo_indicadores_gastos`: 2017 – 2024\n'
  + '- `stg_nilo_taxa_evasao`: 2017 – 2024\n'
  + '- `stg_nilo_taxa_ocupacao`: 2017 – 2024\n'
  + '- `stg_nilo_oferta_vagas_noturnas`: 2017 – 2024\n'
  + '- `stg_nilo_panorama_orcamentario`: 2013 – 2025\n'
  + '- `stg_nilo_percentuais_legais`: 2017 – 2024\n'
  + '- `stg_nilo_professores_por_instituicao`: 2017 – 2024\n'
  + '- `stg_nilo_relacao_aluno_professor_rap`: 2017 – 2024\n'
  + '- `stg_nilo_relacao_inscritos_vagas`: 2017 – 2024\n'
  + '- `stg_nilo_reserva_vagas`: 2019 – 2024\n'
  + '- `stg_nilo_tecnicos_adm_nivel`: 2017 – 2024\n'
  + '- `stg_nilo_titulacao_docente`: 2017 – 2024\n\n'
  + '## Fase 3 — Granularidade\n\n'
  + 'Classificação de granularidade por tabela:\n'
  + '- `stg_nilo_curso_matricula_oferta`: Curso/Ano\n'
  + '- `stg_nilo_situacao_matricula`: Campus\n'
  + '- `stg_nilo_cassificacao_racial_renda_sexo`: Instituição\n'
  + '- `stg_nilo_dados_gerais`: Curso/Ano\n'
  + '- `stg_nilo_cargos_carreira`: Instituição\n'
  + '- `stg_nilo_eficiencia_academica`: Campus\n'
  + '- `stg_nilo_indice_verticalizacao`: Campus\n'
  + '- `stg_nilo_indicadores_gastos`: Instituição\n'
  + '- `stg_nilo_taxa_evasao`: Curso/Período\n'
  + '- `stg_nilo_taxa_ocupacao`: Instituição\n'
  + '- `stg_nilo_oferta_vagas_noturnas`: Campus\n'
  + '- `stg_nilo_panorama_orcamentario`: Instituição\n'
  + '- `stg_nilo_percentuais_legais`: Campus\n'
  + '- `stg_nilo_professores_por_instituicao`: Instituição\n'
  + '- `stg_nilo_relacao_aluno_professor_rap`: Campus\n'
  + '- `stg_nilo_relacao_inscritos_vagas`: Campus\n'
  + '- `stg_nilo_reserva_vagas`: Campus\n'
  + '- `stg_nilo_tecnicos_adm_nivel`: Instituição\n'
  + '- `stg_nilo_titulacao_docente`: Instituição\n\n'
  + 'Próxima fase: agrupar tabelas por granularidade e sugerir junções ou uniões.\n';
fs.writeFileSync(docPath, mdText, 'utf8');
console.log('Granularity classification applied.');
