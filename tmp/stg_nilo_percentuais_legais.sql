DROP TABLE IF EXISTS staging.stg_nilo_percentuais_legais;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.stg_nilo_percentuais_legais (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao VARCHAR(50),
  instituicao_nome TEXT,
  nome_unidade_recente TEXT,
  matricula_equivalente_formacao_de_professores TEXT,
  matricula_equivalente_tecnicos TEXT,
  matricula_equivalente_proeja TEXT,
  matricula_equivalente_geral TEXT,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.stg_nilo_percentuais_legais IS 'Tabela staging para Percentuais Legais da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_percentuais_legais.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_percentuais_legais.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.stg_nilo_percentuais_legais.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_percentuais_legais.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.stg_nilo_percentuais_legais.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_percentuais_legais.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_percentuais_legais.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.stg_nilo_percentuais_legais.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.stg_nilo_percentuais_legais.nome_unidade_recente IS 'Nome da unidade de ensino, conforme edição mais recente';
COMMENT ON COLUMN staging.stg_nilo_percentuais_legais.matricula_equivalente_formacao_de_professores IS 'Matrícula equivalente para formação de professores. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_percentuais_legais.matricula_equivalente_tecnicos IS 'Matrícula equivalente para técnicos. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_percentuais_legais.matricula_equivalente_proeja IS 'Matrícula equivalente para Proeja. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_percentuais_legais.matricula_equivalente_geral IS 'Matrícula equivalente geral. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_percentuais_legais.carregado_em IS 'Data e hora da carga do CSV';
