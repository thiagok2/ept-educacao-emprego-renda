# Documentação DW

## Fase 1 — Inventário

Inventário de tabelas staging criado com base em `NILO.md`.

- Arquivo de inventário: `leiame_dw_catalogo.md`
- Fonte principal: metadados já existentes em `NILO.md`
- Não houve consulta direta ao conteúdo das tabelas

## Fase 2 — Período

Para todas as tabelas `stg_nilo_*`, os metadados a seguir já estão registrados em `leiame_dw_catalogo.md`:
- `COUNT(*)`: disponível via `Linhas carregadas`
- `MIN(ano)`, `MAX(ano)`: inferidos da `Cobertura temporal`

Resumo de cobertura temporal:
- `stg_nilo_curso_matricula_oferta`: 2017 – 2024
- `stg_nilo_situacao_matricula`: 2024 – 2024
- `stg_nilo_cassificacao_racial_renda_sexo`: 2017 – 2024
- `stg_nilo_dados_gerais`: 2017 – 2024
- `stg_nilo_cargos_carreira`: 2016 – 2023
- `stg_nilo_eficiencia_academica`: 2017 – 2024
- `stg_nilo_indice_verticalizacao`: 2017 – 2024
- `stg_nilo_indicadores_gastos`: 2017 – 2024
- `stg_nilo_taxa_evasao`: 2017 – 2024
- `stg_nilo_taxa_ocupacao`: 2017 – 2024
- `stg_nilo_oferta_vagas_noturnas`: 2017 – 2024
- `stg_nilo_panorama_orcamentario`: 2013 – 2025
- `stg_nilo_percentuais_legais`: 2017 – 2024
- `stg_nilo_professores_por_instituicao`: 2017 – 2024
- `stg_nilo_relacao_aluno_professor_rap`: 2017 – 2024
- `stg_nilo_relacao_inscritos_vagas`: 2017 – 2024
- `stg_nilo_reserva_vagas`: 2019 – 2024
- `stg_nilo_tecnicos_adm_nivel`: 2017 – 2024
- `stg_nilo_titulacao_docente`: 2017 – 2024

## Fase 3 — Granularidade

Classificação de granularidade por tabela:
- `stg_nilo_curso_matricula_oferta`: Curso/Ano
- `stg_nilo_situacao_matricula`: Campus
- `stg_nilo_cassificacao_racial_renda_sexo`: Instituição
- `stg_nilo_dados_gerais`: Curso/Ano
- `stg_nilo_cargos_carreira`: Instituição
- `stg_nilo_eficiencia_academica`: Campus
- `stg_nilo_indice_verticalizacao`: Campus
- `stg_nilo_indicadores_gastos`: Instituição
- `stg_nilo_taxa_evasao`: Curso/Período
- `stg_nilo_taxa_ocupacao`: Instituição
- `stg_nilo_oferta_vagas_noturnas`: Campus
- `stg_nilo_panorama_orcamentario`: Instituição
- `stg_nilo_percentuais_legais`: Campus
- `stg_nilo_professores_por_instituicao`: Instituição
- `stg_nilo_relacao_aluno_professor_rap`: Campus
- `stg_nilo_relacao_inscritos_vagas`: Campus
- `stg_nilo_reserva_vagas`: Campus
- `stg_nilo_tecnicos_adm_nivel`: Instituição
- `stg_nilo_titulacao_docente`: Instituição

## Fase 4 — Agrupamento

### Instituição
- `stg_nilo_cassificacao_racial_renda_sexo` — chave de junção: `(ano, instituicao)`
- `stg_nilo_cargos_carreira` — chave de junção: `(ano, instituicao)`
- `stg_nilo_indicadores_gastos` — chave de junção: `(ano, instituicao)`
- `stg_nilo_taxa_ocupacao` — chave de junção: `(ano, instituicao)`
- `stg_nilo_panorama_orcamentario` — chave de junção: `(ano, instituicao)`
- `stg_nilo_professores_por_instituicao` — chave de junção: `(ano, instituicao)`
- `stg_nilo_tecnicos_adm_nivel` — chave de junção: `(ano, instituicao)`
- `stg_nilo_titulacao_docente` — chave de junção: `(ano, instituicao)`
- Recomendações: JOIN nas tabelas de mesmo grão de Instituição, usando a chave `(ano, instituicao)` como base.

### Campus
- `stg_nilo_situacao_matricula` — chave de junção: `(ano, instituicao, nome_unidade_recente)`
- `stg_nilo_eficiencia_academica` — chave de junção: `(ano, instituicao, nome_unidade_recente)`
- `stg_nilo_indice_verticalizacao` — chave de junção: `(ano, instituicao, nome_unidade_recente)`
- `stg_nilo_oferta_vagas_noturnas` — chave de junção: `(ano, instituicao, nome_unidade_recente)`
- `stg_nilo_percentuais_legais` — chave de junção: `(ano, instituicao, nome_unidade_recente)`
- `stg_nilo_relacao_aluno_professor_rap` — chave de junção: `(ano, instituicao, nome_unidade_recente)`
- `stg_nilo_relacao_inscritos_vagas` — chave de junção: `(ano, instituicao, nome_unidade_recente)`
- `stg_nilo_reserva_vagas` — chave de junção: `(ano, instituicao, nome_unidade_recente)`
- Recomendações: JOIN nas tabelas de mesmo grão de Campus, usando `(ano, instituicao, nome_unidade_recente)` como base.

### Curso/Ano
- `stg_nilo_curso_matricula_oferta` — chave de junção: `(ano, instituicao, nome_id_curso)`
- `stg_nilo_dados_gerais` — chave de junção: `(ano, instituicao, nome_id_curso)`
- Recomendações: JOIN entre estas duas tabelas pelo curso e ano, já que compartilham o mesmo grão de Curso/Ano.

### Curso/Período
- `stg_nilo_taxa_evasao` — chave de junção óbvia: `(ano, instituicao, nome_curso, turno_curso, tipo_oferta)`
- Recomendações: sem grupo adicional nesta fase; tabela única em Curso/Período.

## Fase 5 — Modelagem

Proposta de modelagem conceitual disponível em `leiame_dw_modelagem.md`.

- Dimensões: `dim_tempo_ano`, `dim_instituicao`, `dim_unidade_academica`, `dim_curso`
- Fatos: `fato_instituicao_ano`, `fato_unidade_ano`, `fato_curso_ano`, `fato_curso_periodo`
- Indicadores: matrículas, concluintes, evasão, ocupação, gastos, eficiência, RAP, reserva de vagas, percentuais legais e titulação

Próxima fase: validação da modelagem proposta.
