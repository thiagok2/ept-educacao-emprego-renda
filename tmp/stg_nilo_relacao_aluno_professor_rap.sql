DROP TABLE IF EXISTS staging.stg_nilo_relacao_aluno_professor_rap;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.stg_nilo_relacao_aluno_professor_rap (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao VARCHAR(50),
  instituicao_nome TEXT,
  nome_unidade_recente TEXT,
  rap_rap TEXT,
  rap_matriculas_rap INTEGER,
  rap_professor_equivalente INTEGER,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.stg_nilo_relacao_aluno_professor_rap IS 'Tabela staging para Relação Aluno Professor RAP da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_relacao_aluno_professor_rap.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_relacao_aluno_professor_rap.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.stg_nilo_relacao_aluno_professor_rap.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_relacao_aluno_professor_rap.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.stg_nilo_relacao_aluno_professor_rap.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_relacao_aluno_professor_rap.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_relacao_aluno_professor_rap.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.stg_nilo_relacao_aluno_professor_rap.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.stg_nilo_relacao_aluno_professor_rap.nome_unidade_recente IS 'Nome da unidade de ensino, conforme edição mais recente';
COMMENT ON COLUMN staging.stg_nilo_relacao_aluno_professor_rap.rap_rap IS 'RAP. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_relacao_aluno_professor_rap.rap_matriculas_rap IS 'Número de matrículas RAP';
COMMENT ON COLUMN staging.stg_nilo_relacao_aluno_professor_rap.rap_professor_equivalente IS 'Professor equivalente RAP';
COMMENT ON COLUMN staging.stg_nilo_relacao_aluno_professor_rap.carregado_em IS 'Data e hora da carga do CSV';
