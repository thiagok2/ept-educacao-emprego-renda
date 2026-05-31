DROP TABLE IF EXISTS staging.stg_nilo_panorama_orcamentario;

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE staging.stg_nilo_panorama_orcamentario (
  id SERIAL PRIMARY KEY,
  ano INTEGER,
  regiao TEXT,
  uf VARCHAR(2),
  estado TEXT,
  organizacao_academica_pnp TEXT,
  instituicao VARCHAR(50),
  instituicao_nome TEXT,
  relacao_do_orgao TEXT,
  resultado_primario_cidada TEXT,
  dotacao_atualizada TEXT,
  despesa_empenhada TEXT,
  despesa_liquidada TEXT,
  despesa_paga TEXT,
  despesa_liq_rp TEXT,
  despesa_empenhada_a_liquidar TEXT,
  credito_disponivel TEXT,
  carregado_em TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE staging.stg_nilo_panorama_orcamentario IS 'Tabela staging para Panorama Orçamentário da Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.ano IS 'Ano de referência';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.regiao IS 'Nome da região do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.uf IS 'Unidade Federativa (UF) da Instituição';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.estado IS 'Nome do estado do Brasil em que a Instituição está situada';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.organizacao_academica_pnp IS 'Designação da organização acadêmica conforme a Plataforma Nilo Peçanha';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.instituicao IS 'Sigla ou código da instituição';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.instituicao_nome IS 'Nome oficial da Instituição de Ensino';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.relacao_do_orgao IS 'Relação do órgão dentro da estrutura administrativa';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.resultado_primario_cidada IS 'Resultado primário discriminado para o cidadão';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.dotacao_atualizada IS 'Dotação atualizada. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.despesa_empenhada IS 'Despesa empenhada. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.despesa_liquidada IS 'Despesa liquidada. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.despesa_paga IS 'Despesa paga. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.despesa_liq_rp IS 'Despesa liq&RP. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.despesa_empenhada_a_liquidar IS 'Despesa empenhada a liquidar. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.credito_disponivel IS 'Crédito disponível. TEXT pois usa vírgula como decimal na fonte';
COMMENT ON COLUMN staging.stg_nilo_panorama_orcamentario.carregado_em IS 'Data e hora da carga do CSV';
