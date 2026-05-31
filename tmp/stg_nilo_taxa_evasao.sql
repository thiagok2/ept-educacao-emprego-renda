DROP TABLE IF EXISTS staging.stg_nilo_taxa_evasao;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.stg_nilo_taxa_evasao (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao VARCHAR(50),
  instituicao_nome TEXT,
  nome_unidade_recente TEXT,
  nome_curso TEXT,
  tipo_curso TEXT,
  tipo_eixo_tecnologico TEXT,
  subeixo_tecnologico TEXT,
  tipo_oferta TEXT,
  turno_curso TEXT,
  modalidade_ensino TEXT,
  nome_fonte_financiamento TEXT,
  numero_de_matriculas INTEGER,
  matriculas_numero_de_evadidos INTEGER,
  matriculas_taxa_de_evasao_percentual TEXT,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.stg_nilo_taxa_evasao IS 'Tabela staging para Taxa de Evasão da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.nome_unidade_recente IS 'Nome da unidade de ensino, conforme edição mais recente';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.nome_curso IS 'Nome do curso';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.tipo_curso IS 'Tipo do curso';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.tipo_eixo_tecnologico IS 'Tipo de eixo tecnológico';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.subeixo_tecnologico IS 'Subeixo tecnológico';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.tipo_oferta IS 'Tipo de oferta';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.turno_curso IS 'Turno do curso';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.modalidade_ensino IS 'Modalidade de ensino';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.nome_fonte_financiamento IS 'Nome da fonte de financiamento';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.numero_de_matriculas IS 'Número de matrículas';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.matriculas_numero_de_evadidos IS 'Número de alunos evadidos';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.matriculas_taxa_de_evasao_percentual IS 'Taxa de evasão percentual. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_taxa_evasao.carregado_em IS 'Data e hora da carga do CSV';
