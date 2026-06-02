# Inventário DW — Tabelas Staging

Fonte principal: `NILO.md` (metadados existentes)

Cada tabela abaixo é uma `stg_nilo_*` no schema `staging`.

## stg_nilo_curso_matricula_oferta
- Linhas carregadas: 74.620
- Cobertura temporal: 2017 – 2024
- Granularidade: Curso/Ano
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao_nome: TEXT
  - instituicao: VARCHAR(50)
  - nome_unidade_recente: TEXT
  - nome_id_curso: TEXT
  - tipo_curso: TEXT
  - tipo_oferta: TEXT
  - modalidade_ensino: TEXT
  - num_cursos: INTEGER
  - num_concluintes: INTEGER
  - num_ingressantes: INTEGER
  - num_inscritos: INTEGER
  - num_matriculas: INTEGER
  - num_vagas: INTEGER
  - matricula_equivalente_geral: TEXT
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_situacao_matricula
- Linhas carregadas: 36.237
- Cobertura temporal: 2024 – 2024
- Granularidade: Campus
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao: TEXT
  - instituicao_nome: TEXT
  - nome_unidade_recente: TEXT
  - categoria_situacao: TEXT
  - nome_situacao: TEXT
  - fluxo_retido: TEXT
  - numero_de_matriculas: INTEGER
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_cassificacao_racial_renda_sexo
- Linhas carregadas: 213.776
- Cobertura temporal: 2017 – 2024
- Granularidade: Instituição
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: VARCHAR(50)
  - uf: VARCHAR(2)
  - estado: VARCHAR(50)
  - organizacao_academica_pnp: VARCHAR(50)
  - instituicao: VARCHAR(50)
  - instituicao_nome: TEXT
  - cor_raca: VARCHAR(50)
  - renda_familiar: VARCHAR(50)
  - faixa_etaria: VARCHAR(50)
  - sexo: VARCHAR(50)
  - numero_concluintes: INTEGER
  - numero_ingressantes: INTEGER
  - numero_matriculas: INTEGER
  - numero_vagas: INTEGER
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_dados_gerais
- Linhas carregadas: 74.620
- Cobertura temporal: 2017 – 2024
- Granularidade: Curso/Ano
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao_nome: TEXT
  - instituicao: VARCHAR(50)
  - nome_unidade_recente: TEXT
  - nome_id_curso: TEXT
  - tipo_curso: TEXT
  - tipo_oferta: TEXT
  - modalidade_ensino: TEXT
  - numero_de_cursos: INTEGER
  - numero_de_concluintes: INTEGER
  - numero_de_ingressantes: INTEGER
  - numero_de_inscritos: INTEGER
  - numero_de_matriculas: INTEGER
  - numero_de_vagas: INTEGER
  - matricula_equivalente_geral: TEXT
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_cargos_carreira
- Linhas carregadas: 409
- Cobertura temporal: 2016 – 2023
- Granularidade: Instituição
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao: VARCHAR(50)
  - instituicao_nome: TEXT
  - carreira_sigla: VARCHAR(50)
  - numero_de_servidores_siafi: INTEGER
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_eficiencia_academica
- Linhas carregadas: 5.120
- Cobertura temporal: 2017 – 2024
- Granularidade: Campus
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao: VARCHAR(50)
  - instituicao_nome: TEXT
  - nome_unidade_recente: TEXT
  - eficiencia_academica_concluidos: INTEGER
  - eficiencia_academica_concluidos_percentual: TEXT
  - eficiencia_academica_indice_eficiencia_academica_percentual: TEXT
  - eficiencia_academica_numero_de_evadidos: INTEGER
  - eficiencia_academica_retidos: INTEGER
  - eficiencia_academica_retidos_percentual: TEXT
  - eficiencia_academica_taxa_de_evasao_percentual: TEXT
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_indice_verticalizacao
- Linhas carregadas: 5.224
- Cobertura temporal: 2017 – 2024
- Granularidade: Campus
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao: VARCHAR(50)
  - instituicao_nome: TEXT
  - nome_unidade_recente: TEXT
  - indice_verticalizacao_vagas_cg: INTEGER
  - indice_verticalizacao_vagas_ct: INTEGER
  - indice_verticalizacao_vagas_pg: INTEGER
  - indice_verticalizacao_vagas_qp: INTEGER
  - indice_verticalizacao_eixo_tecnologico: TEXT
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_indicadores_gastos
- Linhas carregadas: 328
- Cobertura temporal: 2017 – 2024
- Granularidade: Instituição
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao: VARCHAR(50)
  - instituicao_nome: TEXT
  - gastos_correntes_por_matricula_equivalente: TEXT
  - gastos_correntes_gastos_totais: TEXT
  - gastos_correntes_gastos_correntes: TEXT
  - gastos_correntes_inativos_e_pensionistas: TEXT
  - gastos_correntes_investimentos_e_inversoes_financeiras: TEXT
  - gastos_correntes_precatorios: TEXT
  - gastos_correntes_outros_custeios: TEXT
  - gastos_correntes_pessoal: TEXT
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_taxa_evasao
- Linhas carregadas: 93.420
- Cobertura temporal: 2017 – 2024
- Granularidade: Curso/Período
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao: VARCHAR(50)
  - instituicao_nome: TEXT
  - nome_unidade_recente: TEXT
  - nome_curso: TEXT
  - tipo_curso: TEXT
  - tipo_eixo_tecnologico: TEXT
  - subeixo_tecnologico: TEXT
  - tipo_oferta: TEXT
  - turno_curso: TEXT
  - modalidade_ensino: TEXT
  - nome_fonte_financiamento: TEXT
  - numero_de_matriculas: INTEGER
  - matriculas_numero_de_evadidos: INTEGER
  - matriculas_taxa_de_evasao_percentual: TEXT
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_taxa_ocupacao
- Linhas carregadas: 511
- Cobertura temporal: 2017 – 2024
- Granularidade: Instituição
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao: VARCHAR(50)
  - instituicao_nome: TEXT
  - taxa_ocupacao_matriculas_ciclos_vigentes: INTEGER
  - taxa_ocupacao_vagas_ciclos_vigentes: INTEGER
  - taxa_ocupacao_taxa_de_ocupacao: TEXT
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_oferta_vagas_noturnas
- Linhas carregadas: 3.802
- Cobertura temporal: 2017 – 2024
- Granularidade: Campus
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao: VARCHAR(50)
  - instituicao_nome: TEXT
  - nome_unidade_recente: TEXT
  - oferta_de_vagas_curso_noturno: INTEGER
  - oferta_de_vagas_curso_noturno_percentual: TEXT
  - oferta_de_vagas_graduacao: INTEGER
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_panorama_orcamentario
- Linhas carregadas: 4.615
- Cobertura temporal: 2013 – 2025
- Granularidade: Instituição
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao: VARCHAR(50)
  - instituicao_nome: TEXT
  - relacao_do_orgao: TEXT
  - resultado_primario_cidada: TEXT
  - dotacao_atualizada: TEXT
  - despesa_empenhada: TEXT
  - despesa_liquidada: TEXT
  - despesa_paga: TEXT
  - despesa_liq_rp: TEXT
  - despesa_empenhada_a_liquidar: TEXT
  - credito_disponivel: TEXT
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_percentuais_legais
- Linhas carregadas: 5.219
- Cobertura temporal: 2017 – 2024
- Granularidade: Campus
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao: VARCHAR(50)
  - instituicao_nome: TEXT
  - nome_unidade_recente: TEXT
  - matricula_equivalente_formacao_de_professores: TEXT
  - matricula_equivalente_tecnicos: TEXT
  - matricula_equivalente_proeja: TEXT
  - matricula_equivalente_geral: TEXT
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_professores_por_instituicao
- Linhas carregadas: 5.017
- Cobertura temporal: 2017 – 2024
- Granularidade: Instituição
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao: VARCHAR(50)
  - instituicao_nome: TEXT
  - titulacao: TEXT
  - jornada_de_trabalho: TEXT
  - servidores_numero_de_docentes: INTEGER
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_relacao_aluno_professor_rap
- Linhas carregadas: 5.302
- Cobertura temporal: 2017 – 2024
- Granularidade: Campus
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao: VARCHAR(50)
  - instituicao_nome: TEXT
  - nome_unidade_recente: TEXT
  - rap_rap: TEXT
  - rap_matriculas_rap: INTEGER
  - rap_professor_equivalente: INTEGER
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_relacao_inscritos_vagas
- Linhas carregadas: 5.191
- Cobertura temporal: 2017 – 2024
- Granularidade: Campus
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao: VARCHAR(50)
  - instituicao_nome: TEXT
  - nome_unidade_recente: TEXT
  - numero_de_inscritos: INTEGER
  - numero_de_vagas: INTEGER
  - relacao_inscrito_vaga: TEXT
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_reserva_vagas
- Linhas carregadas: 7.523
- Cobertura temporal: 2019 – 2024
- Granularidade: Campus
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao: VARCHAR(50)
  - instituicao_nome: TEXT
  - nome_unidade_recente: TEXT
  - tipo_reserva_vaga: TEXT
  - vagas_regulares: INTEGER
  - vagas_regulares_percentual: TEXT
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_tecnicos_adm_nivel
- Linhas carregadas: 2.732
- Cobertura temporal: 2017 – 2024
- Granularidade: Instituição
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao: VARCHAR(50)
  - instituicao_nome: TEXT
  - titulacao: TEXT
  - servidores_numero_de_tae: INTEGER
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado

## stg_nilo_titulacao_docente
- Linhas carregadas: 512
- Cobertura temporal: 2017 – 2024
- Granularidade: Instituição
- Colunas e tipos:
  - id: SERIAL
  - ano: INTEGER
  - regiao: TEXT
  - uf: VARCHAR(2)
  - estado: TEXT
  - organizacao_academica_pnp: TEXT
  - instituicao: VARCHAR(50)
  - instituicao_nome: TEXT
  - servidores_docente_efetivo: INTEGER
  - servidores_numero_de_docentes: INTEGER
  - servidores_numero_de_servidores: INTEGER
  - servidores_itcd: TEXT
  - carregado_em: TIMESTAMP
- Chaves candidatas: id (PK surrogate)
- Índices existentes: PK `id`; nenhum índice adicional documentado


