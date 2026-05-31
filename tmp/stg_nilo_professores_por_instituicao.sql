DROP TABLE IF EXISTS staging.stg_nilo_professores_por_instituicao;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.stg_nilo_professores_por_instituicao (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao VARCHAR(50),
  instituicao_nome TEXT,
  titulacao TEXT,
  jornada_de_trabalho TEXT,
  servidores_numero_de_docentes INTEGER,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.stg_nilo_professores_por_instituicao IS 'Tabela staging para Professores por Instituição da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_professores_por_instituicao.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_professores_por_instituicao.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.stg_nilo_professores_por_instituicao.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_professores_por_instituicao.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.stg_nilo_professores_por_instituicao.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_professores_por_instituicao.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_professores_por_instituicao.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.stg_nilo_professores_por_instituicao.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.stg_nilo_professores_por_instituicao.titulacao IS 'Titulação do professor';
COMMENT ON COLUMN staging.stg_nilo_professores_por_instituicao.jornada_de_trabalho IS 'Jornada de trabalho do docente';
COMMENT ON COLUMN staging.stg_nilo_professores_por_instituicao.servidores_numero_de_docentes IS 'Número de docentes';
COMMENT ON COLUMN staging.stg_nilo_professores_por_instituicao.carregado_em IS 'Data e hora da carga do CSV';
