DROP TABLE IF EXISTS staging.stg_nilo_dados_gerais;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.stg_nilo_dados_gerais (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao_nome TEXT,
  instituicao VARCHAR(50),
  nome_unidade_recente TEXT,
  nome_id_curso TEXT,
  tipo_curso TEXT,
  tipo_oferta TEXT,
  modalidade_ensino TEXT,
  numero_de_cursos INTEGER,
  numero_de_concluintes INTEGER,
  numero_de_ingressantes INTEGER,
  numero_de_inscritos INTEGER,
  numero_de_matriculas INTEGER,
  numero_de_vagas INTEGER,
  matricula_equivalente_geral TEXT,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.stg_nilo_dados_gerais IS 'Tabela staging para Dados Gerais da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.nome_unidade_recente IS 'Nome da unidade de ensino, conforme edição mais recente';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.nome_id_curso IS 'Nome e identificador do curso oferecido pela instituição';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.tipo_curso IS 'Tipo do curso';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.tipo_oferta IS 'Forma de oferta do curso';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.modalidade_ensino IS 'Modalidade de ensino do curso';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.numero_de_cursos IS 'Número de cursos contabilizados';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.numero_de_concluintes IS 'Número de concluintes no ano de referência';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.numero_de_ingressantes IS 'Número de ingressantes no ano de referência';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.numero_de_inscritos IS 'Número de inscritos no ano de referência';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.numero_de_matriculas IS 'Número de matrículas ativas no ano de referência';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.numero_de_vagas IS 'Número de vagas ofertadas no ano de referência';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.matricula_equivalente_geral IS 'Matrícula equivalente geral. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_dados_gerais.carregado_em IS 'Data e hora da carga do CSV';
