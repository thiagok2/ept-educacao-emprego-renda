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
