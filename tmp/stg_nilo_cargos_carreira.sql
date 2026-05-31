DROP TABLE IF EXISTS staging.stg_nilo_cargos_carreira;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.stg_nilo_cargos_carreira (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao VARCHAR(50),
  instituicao_nome TEXT,
  carreira_sigla VARCHAR(50),
  numero_de_servidores_siafi INTEGER,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.stg_nilo_cargos_carreira IS 'Tabela staging para Cargos e Carreiras da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_cargos_carreira.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_cargos_carreira.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.stg_nilo_cargos_carreira.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_cargos_carreira.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.stg_nilo_cargos_carreira.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_cargos_carreira.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_cargos_carreira.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.stg_nilo_cargos_carreira.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.stg_nilo_cargos_carreira.carreira_sigla IS 'Sigla da carreira ou categoria de servidor';
COMMENT ON COLUMN staging.stg_nilo_cargos_carreira.numero_de_servidores_siafi IS 'Número de servidores segundo SIAFI';
COMMENT ON COLUMN staging.stg_nilo_cargos_carreira.carregado_em IS 'Data e hora da carga do CSV';
