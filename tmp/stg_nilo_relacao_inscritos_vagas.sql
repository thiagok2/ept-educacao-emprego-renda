DROP TABLE IF EXISTS staging.stg_nilo_relacao_inscritos_vagas;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.stg_nilo_relacao_inscritos_vagas (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao VARCHAR(50),
  instituicao_nome TEXT,
  nome_unidade_recente TEXT,
  numero_de_inscritos INTEGER,
  numero_de_vagas INTEGER,
  relacao_inscrito_vaga TEXT,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.stg_nilo_relacao_inscritos_vagas IS 'Tabela staging para Relação Inscritos x Vagas da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_relacao_inscritos_vagas.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_relacao_inscritos_vagas.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.stg_nilo_relacao_inscritos_vagas.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_relacao_inscritos_vagas.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.stg_nilo_relacao_inscritos_vagas.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_relacao_inscritos_vagas.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_relacao_inscritos_vagas.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.stg_nilo_relacao_inscritos_vagas.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.stg_nilo_relacao_inscritos_vagas.nome_unidade_recente IS 'Nome da unidade de ensino, conforme edição mais recente';
COMMENT ON COLUMN staging.stg_nilo_relacao_inscritos_vagas.numero_de_inscritos IS 'Número de inscritos';
COMMENT ON COLUMN staging.stg_nilo_relacao_inscritos_vagas.numero_de_vagas IS 'Número de vagas';
COMMENT ON COLUMN staging.stg_nilo_relacao_inscritos_vagas.relacao_inscrito_vaga IS 'Relação inscrito/vaga. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_relacao_inscritos_vagas.carregado_em IS 'Data e hora da carga do CSV';
