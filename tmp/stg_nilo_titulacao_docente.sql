DROP TABLE IF EXISTS staging.stg_nilo_titulacao_docente;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.stg_nilo_titulacao_docente (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao VARCHAR(50),
  instituicao_nome TEXT,
  servidores_docente_efetivo INTEGER,
  servidores_numero_de_docentes INTEGER,
  servidores_numero_de_servidores INTEGER,
  servidores_itcd TEXT,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.stg_nilo_titulacao_docente IS 'Tabela staging para Titulação Docente da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_titulacao_docente.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_titulacao_docente.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.stg_nilo_titulacao_docente.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_titulacao_docente.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.stg_nilo_titulacao_docente.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_titulacao_docente.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_titulacao_docente.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.stg_nilo_titulacao_docente.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.stg_nilo_titulacao_docente.servidores_docente_efetivo IS 'Número de docentes efetivos';
COMMENT ON COLUMN staging.stg_nilo_titulacao_docente.servidores_numero_de_docentes IS 'Número total de docentes';
COMMENT ON COLUMN staging.stg_nilo_titulacao_docente.servidores_numero_de_servidores IS 'Número total de servidores';
COMMENT ON COLUMN staging.stg_nilo_titulacao_docente.servidores_itcd IS 'ITCD. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_titulacao_docente.carregado_em IS 'Data e hora da carga do CSV';
