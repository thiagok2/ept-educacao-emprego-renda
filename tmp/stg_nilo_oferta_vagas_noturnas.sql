DROP TABLE IF EXISTS staging.stg_nilo_oferta_vagas_noturnas;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.stg_nilo_oferta_vagas_noturnas (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao VARCHAR(50),
  instituicao_nome TEXT,
  nome_unidade_recente TEXT,
  oferta_de_vagas_curso_noturno INTEGER,
  oferta_de_vagas_curso_noturno_percentual TEXT,
  oferta_de_vagas_graduacao INTEGER,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.stg_nilo_oferta_vagas_noturnas IS 'Tabela staging para Oferta de Vagas Noturnas da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_oferta_vagas_noturnas.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_oferta_vagas_noturnas.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.stg_nilo_oferta_vagas_noturnas.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_oferta_vagas_noturnas.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.stg_nilo_oferta_vagas_noturnas.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_oferta_vagas_noturnas.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_oferta_vagas_noturnas.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.stg_nilo_oferta_vagas_noturnas.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.stg_nilo_oferta_vagas_noturnas.nome_unidade_recente IS 'Nome da unidade de ensino, conforme edição mais recente';
COMMENT ON COLUMN staging.stg_nilo_oferta_vagas_noturnas.oferta_de_vagas_curso_noturno IS 'Número de vagas ofertadas para curso noturno';
COMMENT ON COLUMN staging.stg_nilo_oferta_vagas_noturnas.oferta_de_vagas_curso_noturno_percentual IS 'Percentual da oferta de vagas noturnas. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_oferta_vagas_noturnas.oferta_de_vagas_graduacao IS 'Número de vagas ofertadas para graduação';
COMMENT ON COLUMN staging.stg_nilo_oferta_vagas_noturnas.carregado_em IS 'Data e hora da carga do CSV';
