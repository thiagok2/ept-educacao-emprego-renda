DROP TABLE IF EXISTS staging.stg_nilo_indice_verticalizacao;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.stg_nilo_indice_verticalizacao (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao VARCHAR(50),
  instituicao_nome TEXT,
  nome_unidade_recente TEXT,
  indice_verticalizacao_vagas_cg INTEGER,
  indice_verticalizacao_vagas_ct INTEGER,
  indice_verticalizacao_vagas_pg INTEGER,
  indice_verticalizacao_vagas_qp INTEGER,
  indice_verticalizacao_eixo_tecnologico TEXT,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.stg_nilo_indice_verticalizacao IS 'Tabela staging para Índice de Verticalização da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_indice_verticalizacao.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_indice_verticalizacao.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.stg_nilo_indice_verticalizacao.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_indice_verticalizacao.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.stg_nilo_indice_verticalizacao.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_indice_verticalizacao.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_indice_verticalizacao.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.stg_nilo_indice_verticalizacao.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.stg_nilo_indice_verticalizacao.nome_unidade_recente IS 'Nome da unidade de ensino, conforme edição mais recente';
COMMENT ON COLUMN staging.stg_nilo_indice_verticalizacao.indice_verticalizacao_vagas_cg IS 'Número de vagas na categoria CG';
COMMENT ON COLUMN staging.stg_nilo_indice_verticalizacao.indice_verticalizacao_vagas_ct IS 'Número de vagas na categoria CT';
COMMENT ON COLUMN staging.stg_nilo_indice_verticalizacao.indice_verticalizacao_vagas_pg IS 'Número de vagas na categoria PG';
COMMENT ON COLUMN staging.stg_nilo_indice_verticalizacao.indice_verticalizacao_vagas_qp IS 'Número de vagas na categoria QP';
COMMENT ON COLUMN staging.stg_nilo_indice_verticalizacao.indice_verticalizacao_eixo_tecnologico IS 'Índice de verticalização do eixo tecnológico. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_indice_verticalizacao.carregado_em IS 'Data e hora da carga do CSV';
