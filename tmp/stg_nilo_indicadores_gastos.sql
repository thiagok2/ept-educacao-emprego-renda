DROP TABLE IF EXISTS staging.stg_nilo_indicadores_gastos;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.stg_nilo_indicadores_gastos (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao VARCHAR(50),
  instituicao_nome TEXT,
  gastos_correntes_por_matricula_equivalente TEXT,
  gastos_correntes_gastos_totais TEXT,
  gastos_correntes_gastos_correntes TEXT,
  gastos_correntes_inativos_e_pensionistas TEXT,
  gastos_correntes_investimentos_e_inversoes_financeiras TEXT,
  gastos_correntes_precatorios TEXT,
  gastos_correntes_outros_custeios TEXT,
  gastos_correntes_pessoal TEXT,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.stg_nilo_indicadores_gastos IS 'Tabela staging para Indicadores de Gastos da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.gastos_correntes_por_matricula_equivalente IS 'Gastos Correntes por matrícula equivalente. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.gastos_correntes_gastos_totais IS 'Gastos Totais. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.gastos_correntes_gastos_correntes IS 'Gastos Correntes. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.gastos_correntes_inativos_e_pensionistas IS 'Gastos com inativos e pensionistas. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.gastos_correntes_investimentos_e_inversoes_financeiras IS 'Gastos com investimentos e inversões financeiras. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.gastos_correntes_precatorios IS 'Gastos com precatórios. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.gastos_correntes_outros_custeios IS 'Outros custeios. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.gastos_correntes_pessoal IS 'Gastos com pessoal. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_indicadores_gastos.carregado_em IS 'Data e hora da carga do CSV';
