const fs = require('fs');
const path = require('path');
const root = path.resolve(__dirname, '..');
const catPath = path.join(root, 'leiame_dw_catalogo.md');
const docPath = path.join(root, 'leiame_dw.md');
const coverage = {
  'stg_nilo_curso_matricula_oferta': '2017 – 2024',
  'stg_nilo_situacao_matricula': '2024 – 2024',
  'stg_nilo_cassificacao_racial_renda_sexo': '2017 – 2024',
  'stg_nilo_dados_gerais': '2017 – 2024',
  'stg_nilo_cargos_carreira': '2016 – 2023',
  'stg_nilo_eficiencia_academica': '2017 – 2024',
  'stg_nilo_indice_verticalizacao': '2017 – 2024',
  'stg_nilo_indicadores_gastos': '2017 – 2024',
  'stg_nilo_taxa_evasao': '2017 – 2024',
  'stg_nilo_taxa_ocupacao': '2017 – 2024',
  'stg_nilo_oferta_vagas_noturnas': '2017 – 2024',
  'stg_nilo_panorama_orcamentario': '2013 – 2025',
  'stg_nilo_percentuais_legais': '2017 – 2024',
  'stg_nilo_professores_por_instituicao': '2017 – 2024',
  'stg_nilo_relacao_aluno_professor_rap': '2017 – 2024',
  'stg_nilo_relacao_inscritos_vagas': '2017 – 2024',
  'stg_nilo_reserva_vagas': '2019 – 2024',
  'stg_nilo_tecnicos_adm_nivel': '2017 – 2024',
  'stg_nilo_titulacao_docente': '2017 – 2024',
};
const catText = fs.readFileSync(catPath, 'utf8');
const lines = catText.split(/\r?\n/);
const out = [];
let section = null;
for (const line of lines) {
  out.push(line);
  if (line.startsWith('## ')) {
    section = line.slice(3).trim();
  }
  if (section && line.startsWith('- Linhas carregadas:')) {
    const cov = coverage[section];
    if (cov) {
      out.push(`- Cobertura temporal: ${cov}`);
      section = null;
    }
  }
}
fs.writeFileSync(catPath, out.join('\n') + '\n', 'utf8');

const mdText = `# Documentação DW

## Fase 1 — Inventário

Inventário de tabelas staging criado com base em \`NILO.md\`.

- Arquivo de inventário: \`leiame_dw_catalogo.md\`
- Fonte principal: metadados já existentes em \`NILO.md\`
- Não houve consulta direta ao conteúdo das tabelas

## Fase 2 — Período

Para todas as tabelas \`stg_nilo_*\`, os metadados a seguir já estão registrados em \`leiame_dw_catalogo.md\`:
- \`COUNT(*)\`: disponível via \`Linhas carregadas\`
- \`MIN(ano)\`, \`MAX(ano)\`: inferidos da \`Cobertura temporal\`

Resumo de cobertura temporal:
- \`stg_nilo_curso_matricula_oferta\`: 2017 – 2024
- \`stg_nilo_situacao_matricula\`: 2024 – 2024
- \`stg_nilo_cassificacao_racial_renda_sexo\`: 2017 – 2024
- \`stg_nilo_dados_gerais\`: 2017 – 2024
- \`stg_nilo_cargos_carreira\`: 2016 – 2023
- \`stg_nilo_eficiencia_academica\`: 2017 – 2024
- \`stg_nilo_indice_verticalizacao\`: 2017 – 2024
- \`stg_nilo_indicadores_gastos\`: 2017 – 2024
- \`stg_nilo_taxa_evasao\`: 2017 – 2024
- \`stg_nilo_taxa_ocupacao\`: 2017 – 2024
- \`stg_nilo_oferta_vagas_noturnas\`: 2017 – 2024
- \`stg_nilo_panorama_orcamentario\`: 2013 – 2025
- \`stg_nilo_percentuais_legais\`: 2017 – 2024
- \`stg_nilo_professores_por_instituicao\`: 2017 – 2024
- \`stg_nilo_relacao_aluno_professor_rap\`: 2017 – 2024
- \`stg_nilo_relacao_inscritos_vagas\`: 2017 – 2024
- \`stg_nilo_reserva_vagas\`: 2019 – 2024
- \`stg_nilo_tecnicos_adm_nivel\`: 2017 – 2024
- \`stg_nilo_titulacao_docente\`: 2017 – 2024

Próxima fase: classificação de granularidade por tabela.
`;
fs.writeFileSync(docPath, mdText, 'utf8');
console.log('DW documents updated successfully.');
