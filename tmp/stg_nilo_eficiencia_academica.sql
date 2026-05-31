DROP TABLE IF EXISTS staging.stg_nilo_eficiencia_academica;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.stg_nilo_eficiencia_academica (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao VARCHAR(50),
  instituicao_nome TEXT,
  nome_unidade_recente TEXT,
  eficiencia_academica_concluidos INTEGER,
  eficiencia_academica_concluidos_percentual TEXT,
  eficiencia_academica_indice_eficiencia_academica_percentual TEXT,
  eficiencia_academica_numero_de_evadidos INTEGER,
  eficiencia_academica_retidos INTEGER,
  eficiencia_academica_retidos_percentual TEXT,
  eficiencia_academica_taxa_de_evasao_percentual TEXT,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.stg_nilo_eficiencia_academica IS 'Tabela staging para Eficiência Acadêmica da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.nome_unidade_recente IS 'Nome da unidade de ensino, conforme edição mais recente';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.eficiencia_academica_concluidos IS 'Número de alunos concluídos';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.eficiencia_academica_concluidos_percentual IS 'Percentual de concluídos. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.eficiencia_academica_indice_eficiencia_academica_percentual IS 'Índice de eficiência acadêmica em percentual. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.eficiencia_academica_numero_de_evadidos IS 'Número de evadidos';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.eficiencia_academica_retidos IS 'Número de retidos';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.eficiencia_academica_retidos_percentual IS 'Percentual de retidos. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.eficiencia_academica_taxa_de_evasao_percentual IS 'Taxa de evasão em percentual. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_eficiencia_academica.carregado_em IS 'Data e hora da carga do CSV';
