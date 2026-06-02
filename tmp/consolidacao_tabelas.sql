-- ============================================================================
-- CONSOLIDAÇÃO DE TABELAS STAGING - AGRUPAMENTOS POR GRANULARIDADE
-- ============================================================================
-- Data: 2026-06-02
-- Objetivo: Juntar tabelas staging do NILO por agrupamento, mantendo 
--           a mesma granularidade dentro de cada grupo.
-- ============================================================================

-- GRUPO 1: CURSO/MATRÍCULA/OFERTA
-- Granularidade: unidade + curso + oferta + modalidade + ano
-- Mantém as matrículas sem separação por turno
-- ============================================================================

CREATE TABLE staging.fato_curso_matricula_oferta AS
SELECT
    cmo.ano,
    cmo.instituicao,
    cmo.instituicao_nome,
    cmo.nome_unidade_recente,
    cmo.nome_id_curso,
    cmo.tipo_curso,
    cmo.tipo_oferta,
    cmo.modalidade_ensino,
    -- Dados de matrícula (nomes com prefixo num_)
    cmo.num_cursos,
    cmo.num_concluintes,
    cmo.num_ingressantes,
    cmo.num_vagas,
    cmo.num_inscritos,
    cmo.num_matriculas,
    -- Dados gerais
    dg.numero_de_cursos,
    dg.matricula_equivalente_geral,
    dg.tipo_curso AS tipo_curso_dg,
    dg.tipo_oferta AS tipo_oferta_dg,
    dg.modalidade_ensino AS modalidade_ensino_dg
FROM staging.stg_nilo_curso_matricula_oferta cmo
LEFT JOIN staging.stg_nilo_dados_gerais dg
    ON cmo.ano = dg.ano
    AND cmo.instituicao = dg.instituicao
    AND cmo.nome_id_curso = dg.nome_id_curso
    AND cmo.tipo_oferta = dg.tipo_oferta
ORDER BY
    cmo.ano DESC,
    cmo.instituicao,
    cmo.nome_unidade_recente,
    cmo.nome_id_curso;


-- GRUPO 2: DEMOGRAFIA DOS ESTUDANTES (ÚNICA E DETALHADA)
-- Granularidade: instituição + ano
-- Dados por renda, sexo, ingresso, matrículas
-- ============================================================================

CREATE TABLE staging.fato_instituicao_demografia AS
SELECT
    ano,
    instituicao,
    instituicao_nome,
    regiao,
    uf,
    estado,
    organizacao_academica_pnp,
    -- Dimensões demográficas
    cor_raca,
    renda_familiar,
    faixa_etaria,
    sexo,
    -- Métricas (sem prefixo "numero_de_")
    numero_concluintes,
    numero_ingressantes,
    numero_matriculas,
    numero_vagas
FROM staging.stg_nilo_cassificacao_racial_renda_sexo
ORDER BY
    ano DESC,
    instituicao,
    cor_raca,
    renda_familiar,
    faixa_etaria,
    sexo;


-- GRUPO 3: INDICADORES POR CAMPUS (CONSOLIDADO)
-- Granularidade: instituição + campus + ano
-- Junta: eficiência, verticalização, oferta noturna, percentuais legais,
--        RAP, relação inscritos/vagas, reserva de vagas
-- ============================================================================

CREATE TABLE staging.fato_unidade_indicadores AS
SELECT
    ef.ano,
    ef.instituicao,
    ef.instituicao_nome,
    ef.nome_unidade_recente,
    -- Eficiência Acadêmica (prefixo eficiencia_academica_)
    ef.eficiencia_academica_concluidos,
    ef.eficiencia_academica_concluidos_percentual,
    ef.eficiencia_academica_indice_eficiencia_academica_percentual,
    ef.eficiencia_academica_numero_de_evadidos,
    ef.eficiencia_academica_retidos,
    ef.eficiencia_academica_retidos_percentual,
    ef.eficiencia_academica_taxa_de_evasao_percentual,
    -- Índice de Verticalização (prefixo indice_verticalizacao_)
    vert.indice_verticalizacao_vagas_cg,
    vert.indice_verticalizacao_vagas_ct,
    vert.indice_verticalizacao_vagas_pg,
    vert.indice_verticalizacao_vagas_qp,
    vert.indice_verticalizacao_eixo_tecnologico,
    -- Oferta de Vagas Noturnas (prefixo oferta_de_vagas_)
    ofn.oferta_de_vagas_curso_noturno,
    ofn.oferta_de_vagas_curso_noturno_percentual,
    ofn.oferta_de_vagas_graduacao,
    -- Percentuais Legais (matricula_equivalente_)
    pl.matricula_equivalente_formacao_de_professores,
    pl.matricula_equivalente_tecnicos,
    pl.matricula_equivalente_proeja,
    pl.matricula_equivalente_geral,
    -- Relação Aluno/Professor (prefixo rap_)
    rap.rap_rap,
    rap.rap_matriculas_rap,
    rap.rap_professor_equivalente,
    -- Relação Inscritos/Vagas (numero_de_)
    riv.numero_de_inscritos,
    riv.numero_de_vagas,
    riv.relacao_inscrito_vaga,
    -- Reserva de Vagas
    rv.reserva_cota_vagas,
    rv.vagas_regulares_cota_percentual,
    rv.reserva_ampla_concorrencia_vagas,
    rv.vagas_regulares_ampla_concorrencia_percentual
FROM staging.stg_nilo_eficiencia_academica ef
LEFT JOIN staging.stg_nilo_indice_verticalizacao vert
    ON ef.ano = vert.ano
    AND ef.instituicao = vert.instituicao
    AND ef.nome_unidade_recente = vert.nome_unidade_recente
LEFT JOIN staging.stg_nilo_oferta_vagas_noturnas ofn
    ON ef.ano = ofn.ano
    AND ef.instituicao = ofn.instituicao
    AND ef.nome_unidade_recente = ofn.nome_unidade_recente
LEFT JOIN staging.stg_nilo_percentuais_legais pl
    ON ef.ano = pl.ano
    AND ef.instituicao = pl.instituicao
    AND ef.nome_unidade_recente = pl.nome_unidade_recente
LEFT JOIN staging.stg_nilo_relacao_aluno_professor_rap rap
    ON ef.ano = rap.ano
    AND ef.instituicao = rap.instituicao
    AND ef.nome_unidade_recente = rap.nome_unidade_recente
LEFT JOIN staging.stg_nilo_relacao_inscritos_vagas riv
    ON ef.ano = riv.ano
    AND ef.instituicao = riv.instituicao
    AND ef.nome_unidade_recente = riv.nome_unidade_recente
LEFT JOIN staging.stg_nilo_reserva_vagas2 rv
    ON ef.ano = rv.ano
    AND ef.instituicao = rv.instituicao
    AND ef.nome_unidade_recente = rv.nome_unidade_recente
ORDER BY
    ef.ano DESC,
    ef.instituicao,
    ef.nome_unidade_recente;


-- GRUPO 4: SITUAÇÃO DE MATRÍCULA (POR CAMPUS)
-- Granularidade: instituição + campus + ano
-- Categorias de situação: ativo, retido, evadido, etc.
-- ============================================================================

CREATE TABLE staging.fato_unidade_situacao_matricula AS
SELECT
    ano,
    instituicao,
    instituicao_nome,
    nome_unidade_recente,
    categoria_situacao,
    nome_situacao,
    fluxo_retido,
    numero_de_matriculas
FROM staging.stg_nilo_situacao_matricula
ORDER BY
    ano DESC,
    instituicao,
    nome_unidade_recente,
    categoria_situacao;


-- GRUPO 5: PANORAMA ORÇAMENTÁRIO (POR INSTITUIÇÃO)
-- Granularidade: instituição + ano
-- Relação de órgãos (UO e UGE) + indicadores de gastos
-- ============================================================================

CREATE TABLE staging.fato_instituicao_orcamentario AS
SELECT
    ano,
    instituicao,
    instituicao_nome,
    relacao_do_orgao,
    resultado_primario_cidada,
    dotacao_atualizada,
    despesa_empenhada,
    despesa_liquidada,
    despesa_paga,
    despesa_liq_rp,
    despesa_empenhada_a_liquidar,
    credito_disponivel
FROM staging.stg_nilo_panorama_orcamentario
ORDER BY
    ano DESC,
    instituicao,
    relacao_do_orgao;


-- GRUPO 6: TAXA DE EVASÃO (AGREGADO POR PERÍODOS)
-- Granularidade: instituição + unidade + curso + modalidade + oferta + turno + ano
-- ============================================================================

CREATE TABLE staging.fato_curso_taxa_evasao AS
SELECT
    ano,
    instituicao,
    instituicao_nome,
    nome_unidade_recente,
    nome_curso,
    tipo_curso,
    tipo_eixo_tecnologico,
    subeixo_tecnologico,
    tipo_oferta,
    turno_curso,
    modalidade_ensino,
    nome_fonte_financiamento,
    numero_de_matriculas,
    matriculas_numero_de_evadidos,
    matriculas_taxa_de_evasao_percentual
FROM staging.stg_nilo_taxa_evasao
ORDER BY
    ano DESC,
    instituicao,
    nome_unidade_recente,
    nome_curso,
    turno_curso;


-- GRUPO 7: SERVIDORES (COM PIVOT - DOCENTES E TÉCNICOS)
-- Granularidade: instituição + ano
-- Consolida: cargos/carreira, técnicos por nível, titulação docente,
--            e agrega professores por titulação e jornada
-- ============================================================================

CREATE TABLE staging.fato_instituicao_servidores AS
WITH docentes_pivot AS (
    -- Pivot de titulação e jornada de docentes
    SELECT
        ano,
        instituicao,
        instituicao_nome,
        SUM(CASE WHEN titulacao = 'Doutorado' AND jornada_de_trabalho = '40h' 
                 THEN servidores_numero_de_docentes ELSE 0 END) AS docentes_doutorado_40h,
        SUM(CASE WHEN titulacao = 'Doutorado' AND jornada_de_trabalho = '20h' 
                 THEN servidores_numero_de_docentes ELSE 0 END) AS docentes_doutorado_20h,
        SUM(CASE WHEN titulacao = 'Doutorado' AND jornada_de_trabalho = 'DE' 
                 THEN servidores_numero_de_docentes ELSE 0 END) AS docentes_doutorado_de,
        SUM(CASE WHEN titulacao = 'Mestrado' AND jornada_de_trabalho = '40h' 
                 THEN servidores_numero_de_docentes ELSE 0 END) AS docentes_mestrado_40h,
        SUM(CASE WHEN titulacao = 'Mestrado' AND jornada_de_trabalho = '20h' 
                 THEN servidores_numero_de_docentes ELSE 0 END) AS docentes_mestrado_20h,
        SUM(CASE WHEN titulacao = 'Mestrado' AND jornada_de_trabalho = 'DE' 
                 THEN servidores_numero_de_docentes ELSE 0 END) AS docentes_mestrado_de,
        SUM(CASE WHEN titulacao = 'Especialização' AND jornada_de_trabalho = '40h' 
                 THEN servidores_numero_de_docentes ELSE 0 END) AS docentes_especializacao_40h,
        SUM(CASE WHEN titulacao = 'Especialização' AND jornada_de_trabalho = '20h' 
                 THEN servidores_numero_de_docentes ELSE 0 END) AS docentes_especializacao_20h,
        SUM(CASE WHEN titulacao = 'Especialização' AND jornada_de_trabalho = 'DE' 
                 THEN servidores_numero_de_docentes ELSE 0 END) AS docentes_especializacao_de,
        SUM(CASE WHEN titulacao = 'Graduação' AND jornada_de_trabalho = '40h' 
                 THEN servidores_numero_de_docentes ELSE 0 END) AS docentes_graduacao_40h,
        SUM(CASE WHEN titulacao = 'Graduação' AND jornada_de_trabalho = '20h' 
                 THEN servidores_numero_de_docentes ELSE 0 END) AS docentes_graduacao_20h,
        SUM(CASE WHEN titulacao = 'Graduação' AND jornada_de_trabalho = 'DE' 
                 THEN servidores_numero_de_docentes ELSE 0 END) AS docentes_graduacao_de,
        SUM(servidores_numero_de_docentes) AS docentes_total
    FROM staging.stg_nilo_professores_por_instituicao
    GROUP BY ano, instituicao, instituicao_nome
),
tecnicos_pivot AS (
    -- Agregação de técnicos por titulação
    SELECT
        ano,
        instituicao,
        instituicao_nome,
        SUM(CASE WHEN titulacao = 'Ensino Médio' 
                 THEN servidores_numero_de_tae ELSE 0 END) AS tecnicos_ensino_medio,
        SUM(CASE WHEN titulacao = 'Superior' 
                 THEN servidores_numero_de_tae ELSE 0 END) AS tecnicos_superior,
        SUM(CASE WHEN titulacao = 'Alfabetizado' 
                 THEN servidores_numero_de_tae ELSE 0 END) AS tecnicos_alfabetizado,
        SUM(servidores_numero_de_tae) AS tecnicos_total
    FROM staging.stg_nilo_tecnicos_adm_nivel
    GROUP BY ano, instituicao, instituicao_nome
)
SELECT
    cc.ano,
    cc.instituicao,
    cc.instituicao_nome,
    -- Cargos e Carreira
    cc.numero_de_servidores_siafi AS servidores_total,
    -- Titulação Docente (agregado geral)
    td.servidores_numero_de_docentes AS docentes_numero_total,
    td.servidores_docente_efetivo,
    td.servidores_numero_de_servidores,
    -- Docentes por Titulação e Jornada (pivot)
    dp.docentes_doutorado_40h,
    dp.docentes_doutorado_20h,
    dp.docentes_doutorado_de,
    dp.docentes_mestrado_40h,
    dp.docentes_mestrado_20h,
    dp.docentes_mestrado_de,
    dp.docentes_especializacao_40h,
    dp.docentes_especializacao_20h,
    dp.docentes_especializacao_de,
    dp.docentes_graduacao_40h,
    dp.docentes_graduacao_20h,
    dp.docentes_graduacao_de,
    -- Técnicos por Titulação (agregado)
    tp.tecnicos_ensino_medio,
    tp.tecnicos_superior,
    tp.tecnicos_alfabetizado
FROM staging.stg_nilo_cargos_carreira cc
LEFT JOIN staging.stg_nilo_titulacao_docente td
    ON cc.ano = td.ano
    AND cc.instituicao = td.instituicao
LEFT JOIN docentes_pivot dp
    ON cc.ano = dp.ano
    AND cc.instituicao = dp.instituicao
LEFT JOIN tecnicos_pivot tp
    ON cc.ano = tp.ano
    AND cc.instituicao = tp.instituicao
ORDER BY
    cc.ano DESC,
    cc.instituicao;


-- ============================================================================
-- INFORMAÇÕES ADICIONAIS
-- ============================================================================
-- 
-- Todas as tabelas foram criadas no schema 'staging'.
-- 
-- Linhas de atualização recomendada:
-- - Executar novamente (DROP TABLE IF EXISTS ... CREATE TABLE AS)
--   quando novos dados forem carregados nas tabelas staging
--
-- Granularidades mantidas:
-- 1. Curso/Matrícula: unidade + curso + oferta + modalidade (SEM turno separado)
-- 2. Demografia: instituição (ÚNICA, mais detalhada)
-- 3. Indicadores Campus: instituição + campus (todas as métricas)
-- 4. Situação Matrícula: instituição + campus
-- 5. Orçamento: instituição
-- 6. Taxa Evasão: instituição + campus + curso + modalidade + oferta + turno
-- 7. Servidores: instituição (com pivôs de titulação e jornada)
--
-- ============================================================================
