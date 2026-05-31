DROP TABLE IF EXISTS staging.stg_nilo_tecnicos_adm_nivel;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.stg_nilo_tecnicos_adm_nivel (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao VARCHAR(50),
  instituicao_nome TEXT,
  titulacao TEXT,
  servidores_numero_de_tae INTEGER,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.stg_nilo_tecnicos_adm_nivel IS 'Tabela staging para Técnicos Administrativos por Nível da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_tecnicos_adm_nivel.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_tecnicos_adm_nivel.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.stg_nilo_tecnicos_adm_nivel.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_tecnicos_adm_nivel.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.stg_nilo_tecnicos_adm_nivel.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_tecnicos_adm_nivel.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_tecnicos_adm_nivel.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.stg_nilo_tecnicos_adm_nivel.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.stg_nilo_tecnicos_adm_nivel.titulacao IS 'Titulação do técnico administrativo';
COMMENT ON COLUMN staging.stg_nilo_tecnicos_adm_nivel.servidores_numero_de_tae IS 'Número de técnicos administrativos de nível especificado';
COMMENT ON COLUMN staging.stg_nilo_tecnicos_adm_nivel.carregado_em IS 'Data e hora da carga do CSV';
