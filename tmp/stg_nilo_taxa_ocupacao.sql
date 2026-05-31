DROP TABLE IF EXISTS staging.stg_nilo_taxa_ocupacao;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.stg_nilo_taxa_ocupacao (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao VARCHAR(50),
  instituicao_nome TEXT,
  taxa_ocupacao_matriculas_ciclos_vigentes INTEGER,
  taxa_ocupacao_vagas_ciclos_vigentes INTEGER,
  taxa_ocupacao_taxa_de_ocupacao TEXT,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.stg_nilo_taxa_ocupacao IS 'Tabela staging para Taxa de Ocupação da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_taxa_ocupacao.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_taxa_ocupacao.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.stg_nilo_taxa_ocupacao.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_taxa_ocupacao.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.stg_nilo_taxa_ocupacao.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_taxa_ocupacao.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_taxa_ocupacao.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.stg_nilo_taxa_ocupacao.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.stg_nilo_taxa_ocupacao.taxa_ocupacao_matriculas_ciclos_vigentes IS 'Matrículas em ciclos vigentes para cálculo da taxa de ocupação';
COMMENT ON COLUMN staging.stg_nilo_taxa_ocupacao.taxa_ocupacao_vagas_ciclos_vigentes IS 'Vagas em ciclos vigentes para cálculo da taxa de ocupação';
COMMENT ON COLUMN staging.stg_nilo_taxa_ocupacao.taxa_ocupacao_taxa_de_ocupacao IS 'Taxa de ocupação. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_taxa_ocupacao.carregado_em IS 'Data e hora da carga do CSV';
