# Plataforma Nilo Peçanha — Tabelas Staging

Documentação das tabelas `stg_nilo_*` carregadas no Supabase a partir dos arquivos CSV da [Plataforma Nilo Peçanha (PNP)](https://www.plataformanilopeçanha.mec.gov.br/).

Cada tabela é criada pela skill `/nilo-loader` no schema `staging` e representa um arquivo CSV da PNP em sua forma bruta, sem transformações, com os tipos e comentários derivados da documentação oficial (PDF homônimo ao CSV).

---

<!-- As seções abaixo são geradas automaticamente pela skill /nilo-loader. Não edite manualmente. -->

## stg_nilo_curso_matricula_oferta

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `CursoMatriculaOferta.csv`
**Documentação:** `dados-fonte/nilo/CursoMatriculaOferta.pdf` (presente)
**Linhas carregadas:** 74.620
**Cobertura temporal:** 2017 – 2024
**Última carga:** 2026-05-25

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica: IF, Cefet, ETV ou Colégio Pedro II (CPII) |
| instituicao_nome | TEXT | Nome da Instituição de Ensino Superior |
| instituicao | VARCHAR(50) | Sigla da instituição de ensino |
| nome_unidade_recente | TEXT | Nome da unidade de ensino, conforme última edição disponível |
| nome_id_curso | TEXT | Nome e identificador do curso oferecido pela instituição |
| tipo_curso | TEXT | Tipo do curso: Bacharelado, Técnico, Licenciatura, FIC, Especialização, etc. |
| tipo_oferta | TEXT | Forma de oferta: Integrado, Subsequente, Concomitante, PROEJA |
| modalidade_ensino | TEXT | Modo de desenvolvimento: presencial ou a distância |
| num_cursos | INTEGER | Somatório dos cursos pertencentes às instituições da Rede Federal de EPCT |
| num_concluintes | INTEGER | Somatório dos alunos formados e integralizados em fase escolar no ano de referência |
| num_ingressantes | INTEGER | Somatório dos alunos que ingressaram em um curso no ano de referência |
| num_inscritos | INTEGER | Candidatos que concorreram às vagas disponibilizadas para a fase inicial do curso |
| num_matriculas | INTEGER | Alunos com matrícula ativa em pelo menos um dia no ano de referência |
| num_vagas | INTEGER | Vagas disponibilizadas para a fase inicial via processo seletivo, SISU, etc. |
| matricula_equivalente_geral | TEXT | Matrícula ponderada pelos fatores de equiparação de carga horária e esforço de curso. TEXT pois usa vírgula como decimal na fonte |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_situacao_matricula

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `SituacaoMatricula.csv`
**Documentação:** `dados-fonte/nilo/SituacaoMatricula.pdf` (presente)
**Linhas carregadas:** 36.237
**Cobertura temporal:** 2024 – 2024
**Última carga:** 2026-05-27

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Região do Brasil |
| uf | VARCHAR(2) | Unidade Federativa |
| estado | TEXT | Estado do Brasil |
| organizacao_academica_pnp | TEXT | Organização acadêmica conforme PNP |
| instituicao | TEXT | Sigla da instituição |
| instituicao_nome | TEXT | Nome completo da instituição |
| nome_unidade_recente | TEXT | Nome da unidade recente |
| categoria_situacao | TEXT | Categoria da situação do aluno |
| nome_situacao | TEXT | Descrição da situação de matrícula |
| fluxo_retido | TEXT | Fluxo retido associado à situação |
| numero_de_matriculas | INTEGER | Número de matrículas para a combinação de situação |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_cassificacao_racial_renda_sexo

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `CassificacaoRacialRendaSexo.csv`
**Documentação:** `dados-fonte/nilo/CassificacaoRacialRendaSexo.pdf` (presente)
**Linhas carregadas:** 213.776
**Cobertura temporal:** 2017 – 2024 (8 anos)
**Instituições representadas:** 56
**Regiões representadas:** 5
**Última carga:** 2026-05-27

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência dos dados |
| regiao | VARCHAR(50) | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | VARCHAR(50) | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | VARCHAR(50) | Designação da organização acadêmica (IF, Cefet, ETV, CPII) |
| instituicao | VARCHAR(50) | Código ou sigla da instituição |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino Superior |
| cor_raca | VARCHAR(50) | Cor/Raça do aluno (Amarela, Branca, Indígena, Parda, Preta, Não Declarada) |
| renda_familiar | VARCHAR(50) | Faixa de renda per capita familiar em salários-mínimos |
| faixa_etaria | VARCHAR(50) | Faixa etária do aluno |
| sexo | VARCHAR(50) | Sexo do aluno (Masculino, Feminino, Outro) |
| numero_concluintes | INTEGER | Quantidade de alunos que concluíram o curso no período |
| numero_ingressantes | INTEGER | Quantidade de alunos que ingressaram no curso no período |
| numero_matriculas | INTEGER | Quantidade total de matrículas ativas no período |
| numero_vagas | INTEGER | Quantidade de vagas oferecidas pelo curso no período |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_dados_gerais

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `DadosGerais.csv`
**Documentação:** `dados-fonte/nilo/DadosGerais.pdf` (presente)
**Linhas carregadas:** 74.620
**Cobertura temporal:** 2017 – 2024
**Última carga:** 2026-05-31

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica conforme a Plataforma Nilo Peçanha |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino |
| instituicao | VARCHAR(50) | Sigla ou código da instituição |
| nome_unidade_recente | TEXT | Nome da unidade de ensino, conforme edição mais recente |
| nome_id_curso | TEXT | Nome e identificador do curso oferecido pela instituição |
| tipo_curso | TEXT | Tipo do curso |
| tipo_oferta | TEXT | Forma de oferta do curso |
| modalidade_ensino | TEXT | Modalidade de ensino do curso |
| numero_de_cursos | INTEGER | Número de cursos contabilizados |
| numero_de_concluintes | INTEGER | Número de concluintes no ano de referência |
| numero_de_ingressantes | INTEGER | Número de ingressantes no ano de referência |
| numero_de_inscritos | INTEGER | Número de inscritos no ano de referência |
| numero_de_matriculas | INTEGER | Número de matrículas ativas no ano de referência |
| numero_de_vagas | INTEGER | Número de vagas ofertadas no ano de referência |
| matricula_equivalente_geral | TEXT | Matrícula equivalente geral. TEXT pois usa vírgula como decimal na fonte |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_cargos_carreira

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `CargosCarreira.csv`
**Documentação:** `dados-fonte/nilo/CargosCarreira.pdf` (presente)
**Linhas carregadas:** 409
**Cobertura temporal:** 2016 – 2023
**Última carga:** 2026-05-31

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica conforme a Plataforma Nilo Peçanha |
| instituicao | VARCHAR(50) | Sigla ou código da instituição |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino |
| carreira_sigla | VARCHAR(50) | Sigla da carreira ou categoria de servidor |
| numero_de_servidores_siafi | INTEGER | Número de servidores segundo SIAFI |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_eficiencia_academica

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `EficienciaAcademica.csv`
**Documentação:** `dados-fonte/nilo/EficienciaAcademica.pdf` (presente)
**Linhas carregadas:** 5.120
**Cobertura temporal:** 2017 – 2024
**Última carga:** 2026-05-31

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica conforme a Plataforma Nilo Peçanha |
| instituicao | VARCHAR(50) | Sigla ou código da instituição |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino |
| nome_unidade_recente | TEXT | Nome da unidade de ensino, conforme edição mais recente |
| eficiencia_academica_concluidos | INTEGER | Número de alunos concluídos |
| eficiencia_academica_concluidos_percentual | TEXT | Percentual de concluídos. TEXT pois usa vírgula como decimal na fonte |
| eficiencia_academica_indice_eficiencia_academica_percentual | TEXT | Índice de eficiência acadêmica em percentual. TEXT pois usa vírgula como decimal na fonte |
| eficiencia_academica_numero_de_evadidos | INTEGER | Número de evadidos |
| eficiencia_academica_retidos | INTEGER | Número de retidos |
| eficiencia_academica_retidos_percentual | TEXT | Percentual de retidos. TEXT pois usa vírgula como decimal na fonte |
| eficiencia_academica_taxa_de_evasao_percentual | TEXT | Taxa de evasão em percentual. TEXT pois usa vírgula como decimal na fonte |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_indice_verticalizacao

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `IndiceVerticalizacao.csv`
**Documentação:** `dados-fonte/nilo/IndiceVerticalizacao.pdf` (presente)
**Linhas carregadas:** 5.224
**Cobertura temporal:** 2017 – 2024
**Última carga:** 2026-05-31

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica conforme a Plataforma Nilo Peçanha |
| instituicao | VARCHAR(50) | Sigla ou código da instituição |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino |
| nome_unidade_recente | TEXT | Nome da unidade de ensino, conforme edição mais recente |
| indice_verticalizacao_vagas_cg | INTEGER | Número de vagas na categoria CG |
| indice_verticalizacao_vagas_ct | INTEGER | Número de vagas na categoria CT |
| indice_verticalizacao_vagas_pg | INTEGER | Número de vagas na categoria PG |
| indice_verticalizacao_vagas_qp | INTEGER | Número de vagas na categoria QP |
| indice_verticalizacao_eixo_tecnologico | TEXT | Índice de verticalização do eixo tecnológico. TEXT pois usa vírgula como decimal na fonte |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_indicadores_gastos

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `IndicadoresGastos.csv`
**Documentação:** `dados-fonte/nilo/IndicadoresGastos.pdf` (presente)
**Linhas carregadas:** 328
**Cobertura temporal:** 2017 – 2024
**Última carga:** 2026-05-31

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica conforme a Plataforma Nilo Peçanha |
| instituicao | VARCHAR(50) | Sigla ou código da instituição |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino |
| gastos_correntes_por_matricula_equivalente | TEXT | Gastos Correntes por matrícula equivalente. TEXT pois usa vírgula como decimal na fonte |
| gastos_correntes_gastos_totais | TEXT | Gastos Totais. TEXT pois usa vírgula como decimal na fonte |
| gastos_correntes_gastos_correntes | TEXT | Gastos Correntes. TEXT pois usa vírgula como decimal na fonte |
| gastos_correntes_inativos_e_pensionistas | TEXT | Gastos com inativos e pensionistas. TEXT pois usa vírgula como decimal na fonte |
| gastos_correntes_investimentos_e_inversoes_financeiras | TEXT | Gastos com investimentos e inversões financeiras. TEXT pois usa vírgula como decimal na fonte |
| gastos_correntes_precatorios | TEXT | Gastos com precatórios. TEXT pois usa vírgula como decimal na fonte |
| gastos_correntes_outros_custeios | TEXT | Outros custeios. TEXT pois usa vírgula como decimal na fonte |
| gastos_correntes_pessoal | TEXT | Gastos com pessoal. TEXT pois usa vírgula como decimal na fonte |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_taxa_evasao

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `TaxaEvasao.csv`
**Documentação:** `dados-fonte/nilo/TaxaEvasao.pdf` (presente)
**Linhas carregadas:** 93.420
**Cobertura temporal:** 2017 – 2024
**Última carga:** 2026-05-31

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica conforme a Plataforma Nilo Peçanha |
| instituicao | VARCHAR(50) | Sigla ou código da instituição |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino |
| nome_unidade_recente | TEXT | Nome da unidade de ensino, conforme edição mais recente |
| nome_curso | TEXT | Nome do curso |
| tipo_curso | TEXT | Tipo do curso |
| tipo_eixo_tecnologico | TEXT | Tipo de eixo tecnológico |
| subeixo_tecnologico | TEXT | Subeixo tecnológico |
| tipo_oferta | TEXT | Tipo de oferta |
| turno_curso | TEXT | Turno do curso |
| modalidade_ensino | TEXT | Modalidade de ensino |
| nome_fonte_financiamento | TEXT | Nome da fonte de financiamento |
| numero_de_matriculas | INTEGER | Número de matrículas |
| matriculas_numero_de_evadidos | INTEGER | Número de alunos evadidos |
| matriculas_taxa_de_evasao_percentual | TEXT | Taxa de evasão percentual. TEXT pois usa vírgula como decimal na fonte |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_taxa_ocupacao

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `TaxaOcupacao.csv`
**Documentação:** `dados-fonte/nilo/TaxaOcupacao.pdf` (presente)
**Linhas carregadas:** 511
**Cobertura temporal:** 2017 – 2024
**Última carga:** 2026-05-31

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica conforme a Plataforma Nilo Peçanha |
| instituicao | VARCHAR(50) | Sigla ou código da instituição |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino |
| taxa_ocupacao_matriculas_ciclos_vigentes | INTEGER | Matrículas em ciclos vigentes para cálculo da taxa de ocupação |
| taxa_ocupacao_vagas_ciclos_vigentes | INTEGER | Vagas em ciclos vigentes para cálculo da taxa de ocupação |
| taxa_ocupacao_taxa_de_ocupacao | TEXT | Taxa de ocupação. TEXT pois usa vírgula como decimal na fonte |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_oferta_vagas_noturnas

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `OfertaVagasNoturnas.csv`
**Documentação:** `dados-fonte/nilo/OfertaVagasNoturnas.pdf` (presente)
**Linhas carregadas:** 3.802
**Cobertura temporal:** 2017 – 2024
**Última carga:** 2026-05-31

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica conforme a Plataforma Nilo Peçanha |
| instituicao | VARCHAR(50) | Sigla ou código da instituição |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino |
| nome_unidade_recente | TEXT | Nome da unidade de ensino, conforme edição mais recente |
| oferta_de_vagas_curso_noturno | INTEGER | Número de vagas ofertadas para curso noturno |
| oferta_de_vagas_curso_noturno_percentual | TEXT | Percentual da oferta de vagas noturnas. TEXT pois usa vírgula como decimal na fonte |
| oferta_de_vagas_graduacao | INTEGER | Número de vagas ofertadas para graduação |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_panorama_orcamentario

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `PanoramaOrcamentario.csv`
**Documentação:** `dados-fonte/nilo/PanoramaOrcamentario.pdf` (presente)
**Linhas carregadas:** 4.615
**Cobertura temporal:** 2013 – 2025
**Última carga:** 2026-05-31

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica conforme a Plataforma Nilo Peçanha |
| instituicao | VARCHAR(50) | Sigla ou código da instituição |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino |
| relacao_do_orgao | TEXT | Relação do órgão dentro da estrutura administrativa |
| resultado_primario_cidada | TEXT | Resultado primário discriminado para o cidadão |
| dotacao_atualizada | TEXT | Dotação atualizada. TEXT pois usa vírgula como decimal na fonte |
| despesa_empenhada | TEXT | Despesa empenhada. TEXT pois usa vírgula como decimal na fonte |
| despesa_liquidada | TEXT | Despesa liquidada. TEXT pois usa vírgula como decimal na fonte |
| despesa_paga | TEXT | Despesa paga. TEXT pois usa vírgula como decimal na fonte |
| despesa_liq_rp | TEXT | Despesa liq&RP. TEXT pois usa vírgula como decimal na fonte |
| despesa_empenhada_a_liquidar | TEXT | Despesa empenhada a liquidar. TEXT pois usa vírgula como decimal na fonte |
| credito_disponivel | TEXT | Crédito disponível. TEXT pois usa vírgula como decimal na fonte |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_percentuais_legais

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `PercentuaisLegais.csv`
**Documentação:** `dados-fonte/nilo/PercentuaisLegais.pdf` (presente)
**Linhas carregadas:** 5.219
**Cobertura temporal:** 2017 – 2024
**Última carga:** 2026-05-31

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica conforme a Plataforma Nilo Peçanha |
| instituicao | VARCHAR(50) | Sigla ou código da instituição |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino |
| nome_unidade_recente | TEXT | Nome da unidade de ensino, conforme edição mais recente |
| matricula_equivalente_formacao_de_professores | TEXT | Matrícula equivalente para formação de professores. TEXT pois usa vírgula como decimal na fonte |
| matricula_equivalente_tecnicos | TEXT | Matrícula equivalente para técnicos. TEXT pois usa vírgula como decimal na fonte |
| matricula_equivalente_proeja | TEXT | Matrícula equivalente para Proeja. TEXT pois usa vírgula como decimal na fonte |
| matricula_equivalente_geral | TEXT | Matrícula equivalente geral. TEXT pois usa vírgula como decimal na fonte |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_professores_por_instituicao

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `ProfessoresPorInstituicao.csv`
**Documentação:** `dados-fonte/nilo/ProfessoresPorInstituicao.pdf` (presente)
**Linhas carregadas:** 5.017
**Cobertura temporal:** 2017 – 2024
**Última carga:** 2026-05-31

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica conforme a Plataforma Nilo Peçanha |
| instituicao | VARCHAR(50) | Sigla ou código da instituição |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino |
| titulacao | TEXT | Titulação do professor |
| jornada_de_trabalho | TEXT | Jornada de trabalho do docente |
| servidores_numero_de_docentes | INTEGER | Número de docentes |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_relacao_aluno_professor_rap

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `RelacaoAlunoProfessorRAP.csv`
**Documentação:** `dados-fonte/nilo/RelacaoAlunoProfessorRAP.pdf` (presente)
**Linhas carregadas:** 5.302
**Cobertura temporal:** 2017 – 2024
**Última carga:** 2026-05-31

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica conforme a Plataforma Nilo Peçanha |
| instituicao | VARCHAR(50) | Sigla ou código da instituição |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino |
| nome_unidade_recente | TEXT | Nome da unidade de ensino, conforme edição mais recente |
| rap_rap | TEXT | RAP. TEXT pois usa vírgula como decimal na fonte |
| rap_matriculas_rap | INTEGER | Número de matrículas RAP |
| rap_professor_equivalente | INTEGER | Professor equivalente RAP |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_relacao_inscritos_vagas

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `RelacaoInscritosVagas.csv`
**Documentação:** `dados-fonte/nilo/RelacaoInscritosVagas.pdf` (presente)
**Linhas carregadas:** 5.191
**Cobertura temporal:** 2017 – 2024
**Última carga:** 2026-05-31

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica conforme a Plataforma Nilo Peçanha |
| instituicao | VARCHAR(50) | Sigla ou código da instituição |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino |
| nome_unidade_recente | TEXT | Nome da unidade de ensino, conforme edição mais recente |
| numero_de_inscritos | INTEGER | Número de inscritos |
| numero_de_vagas | INTEGER | Número de vagas |
| relacao_inscrito_vaga | TEXT | Relação inscrito/vaga. TEXT pois usa vírgula como decimal na fonte |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_reserva_vagas

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `ReservaVagas.csv`
**Documentação:** `dados-fonte/nilo/ReservaVagas.pdf` (presente)
**Linhas carregadas:** 7.523
**Cobertura temporal:** 2019 – 2024
**Última carga:** 2026-05-31

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica conforme a Plataforma Nilo Peçanha |
| instituicao | VARCHAR(50) | Sigla ou código da instituição |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino |
| nome_unidade_recente | TEXT | Nome da unidade de ensino, conforme edição mais recente |
| tipo_reserva_vaga | TEXT | Tipo de reserva de vaga |
| vagas_regulares | INTEGER | Número de vagas regulares |
| vagas_regulares_percentual | TEXT | Percentual de vagas regulares. TEXT pois usa vírgula como decimal na fonte |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_tecnicos_adm_nivel

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `TecnicosAdmNivel.csv`
**Documentação:** `dados-fonte/nilo/TecnicosAdmNivel.pdf` (presente)
**Linhas carregadas:** 2.732
**Cobertura temporal:** 2017 – 2024
**Última carga:** 2026-05-31

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica conforme a Plataforma Nilo Peçanha |
| instituicao | VARCHAR(50) | Sigla ou código da instituição |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino |
| titulacao | TEXT | Titulação do técnico administrativo |
| servidores_numero_de_tae | INTEGER | Número de técnicos administrativos de nível especificado |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |

## stg_nilo_titulacao_docente

**Schema:** `staging`
**Fonte:** Plataforma Nilo Peçanha — arquivo `TitulacaoDocente.csv`
**Documentação:** `dados-fonte/nilo/TitulacaoDocente.pdf` (presente)
**Linhas carregadas:** 512
**Cobertura temporal:** 2017 – 2024
**Última carga:** 2026-05-31

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| ano | INTEGER | Ano de referência |
| regiao | TEXT | Nome da região do Brasil em que a Instituição está situada |
| uf | VARCHAR(2) | Unidade Federativa (UF) da Instituição |
| estado | TEXT | Nome do estado do Brasil em que a Instituição está situada |
| organizacao_academica_pnp | TEXT | Designação da organização acadêmica conforme a Plataforma Nilo Peçanha |
| instituicao | VARCHAR(50) | Sigla ou código da instituição |
| instituicao_nome | TEXT | Nome oficial da Instituição de Ensino |
| servidores_docente_efetivo | INTEGER | Número de docentes efetivos |
| servidores_numero_de_docentes | INTEGER | Número total de docentes |
| servidores_numero_de_servidores | INTEGER | Número total de servidores |
| servidores_itcd | TEXT | ITCD. TEXT pois usa vírgula como decimal na fonte |
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |
