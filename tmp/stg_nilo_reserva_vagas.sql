DROP TABLE IF EXISTS staging.stg_nilo_reserva_vagas;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.stg_nilo_reserva_vagas (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao VARCHAR(50),
  instituicao_nome TEXT,
  nome_unidade_recente TEXT,
  tipo_reserva_vaga TEXT,
  vagas_regulares INTEGER,
  vagas_regulares_percentual TEXT,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.stg_nilo_reserva_vagas IS 'Tabela staging para Reserva de Vagas da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_reserva_vagas.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_reserva_vagas.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.stg_nilo_reserva_vagas.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_reserva_vagas.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.stg_nilo_reserva_vagas.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_reserva_vagas.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_reserva_vagas.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.stg_nilo_reserva_vagas.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.stg_nilo_reserva_vagas.nome_unidade_recente IS 'Nome da unidade de ensino, conforme edição mais recente';
COMMENT ON COLUMN staging.stg_nilo_reserva_vagas.tipo_reserva_vaga IS 'Tipo de reserva de vaga';
COMMENT ON COLUMN staging.stg_nilo_reserva_vagas.vagas_regulares IS 'Número de vagas regulares';
COMMENT ON COLUMN staging.stg_nilo_reserva_vagas.vagas_regulares_percentual IS 'Percentual de vagas regulares. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_reserva_vagas.carregado_em IS 'Data e hora da carga do CSV';
