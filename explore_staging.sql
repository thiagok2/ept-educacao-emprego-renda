-- Script para explorar todas as tabelas do schema 'staging'

-- 1. INFORMAÇÕES SOBRE CADA TABELA (colunas, tipos, constraints)
\echo '========== ESTRUTURA DE TODAS AS TABELAS =========='

SELECT 
  t.table_name,
  c.column_name,
  c.data_type,
  CASE WHEN kcu.column_name IS NOT NULL THEN 'PRIMARY KEY' ELSE '' END AS constraint_type,
  c.is_nullable
FROM information_schema.tables t
JOIN information_schema.columns c ON t.table_schema = c.table_schema AND t.table_name = c.table_name
LEFT JOIN information_schema.key_column_usage kcu ON c.table_schema = kcu.table_schema 
  AND c.table_name = kcu.table_name AND c.column_name = kcu.column_name 
  AND kcu.constraint_name LIKE '%pkey%'
WHERE t.table_schema = 'staging'
  AND t.table_type = 'BASE TABLE'
ORDER BY t.table_name, c.ordinal_position;

\echo ''
\echo '========== CONTAGEM DE LINHAS POR TABELA =========='
SELECT 
  table_name,
  (SELECT COUNT(*) FROM staging.stg_nilo_curso_matricula_oferta) AS stg_nilo_curso_matricula_oferta,
  (SELECT COUNT(*) FROM staging.stg_nilo_dados_gerais) AS stg_nilo_dados_gerais,
  (SELECT COUNT(*) FROM staging.stg_nilo_cassificacao_racial_renda_sexo) AS stg_nilo_cassificacao_racial_renda_sexo,
  (SELECT COUNT(*) FROM staging.stg_nilo_eficiencia_academica) AS stg_nilo_eficiencia_academica,
  (SELECT COUNT(*) FROM staging.stg_nilo_indice_verticalizacao) AS stg_nilo_indice_verticalizacao,
  (SELECT COUNT(*) FROM staging.stg_nilo_oferta_vagas_noturnas) AS stg_nilo_oferta_vagas_noturnas,
  (SELECT COUNT(*) FROM staging.stg_nilo_percentuais_legais) AS stg_nilo_percentuais_legais,
  (SELECT COUNT(*) FROM staging.stg_nilo_relacao_aluno_professor_rap) AS stg_nilo_relacao_aluno_professor_rap,
  (SELECT COUNT(*) FROM staging.stg_nilo_relacao_inscritos_vagas) AS stg_nilo_relacao_inscritos_vagas,
  (SELECT COUNT(*) FROM staging.stg_nilo_reserva_vagas2) AS stg_nilo_reserva_vagas2,
  (SELECT COUNT(*) FROM staging.stg_nilo_situacao_matricula) AS stg_nilo_situacao_matricula,
  (SELECT COUNT(*) FROM staging.stg_nilo_panorama_orcamentario) AS stg_nilo_panorama_orcamentario,
  (SELECT COUNT(*) FROM staging.stg_nilo_taxa_evasao) AS stg_nilo_taxa_evasao,
  (SELECT COUNT(*) FROM staging.stg_nilo_cargos_carreira) AS stg_nilo_cargos_carreira,
  (SELECT COUNT(*) FROM staging.stg_nilo_tecnicos_adm_nivel) AS stg_nilo_tecnicos_adm_nivel,
  (SELECT COUNT(*) FROM staging.stg_nilo_titulacao_docente) AS stg_nilo_titulacao_docente,
  (SELECT COUNT(*) FROM staging.stg_nilo_professores_por_instituicao) AS stg_nilo_professores_por_instituicao
FROM information_schema.tables
WHERE table_schema = 'staging'
LIMIT 1;

-- Tabelas individuais com exemplos

\echo ''
\echo '========== 1. stg_nilo_curso_matricula_oferta =========='
SELECT * FROM staging.stg_nilo_curso_matricula_oferta LIMIT 3;

\echo ''
\echo '========== 2. stg_nilo_dados_gerais =========='
SELECT * FROM staging.stg_nilo_dados_gerais LIMIT 3;

\echo ''
\echo '========== 3. stg_nilo_cassificacao_racial_renda_sexo =========='
SELECT * FROM staging.stg_nilo_cassificacao_racial_renda_sexo LIMIT 3;

\echo ''
\echo '========== 4. stg_nilo_eficiencia_academica =========='
SELECT * FROM staging.stg_nilo_eficiencia_academica LIMIT 3;

\echo ''
\echo '========== 5. stg_nilo_indice_verticalizacao =========='
SELECT * FROM staging.stg_nilo_indice_verticalizacao LIMIT 3;

\echo ''
\echo '========== 6. stg_nilo_oferta_vagas_noturnas =========='
SELECT * FROM staging.stg_nilo_oferta_vagas_noturnas LIMIT 3;

\echo ''
\echo '========== 7. stg_nilo_percentuais_legais =========='
SELECT * FROM staging.stg_nilo_percentuais_legais LIMIT 3;

\echo ''
\echo '========== 8. stg_nilo_relacao_aluno_professor_rap =========='
SELECT * FROM staging.stg_nilo_relacao_aluno_professor_rap LIMIT 3;

\echo ''
\echo '========== 9. stg_nilo_relacao_inscritos_vagas =========='
SELECT * FROM staging.stg_nilo_relacao_inscritos_vagas LIMIT 3;

\echo ''
\echo '========== 10. stg_nilo_reserva_vagas2 =========='
SELECT * FROM staging.stg_nilo_reserva_vagas2 LIMIT 3;

\echo ''
\echo '========== 11. stg_nilo_situacao_matricula =========='
SELECT * FROM staging.stg_nilo_situacao_matricula LIMIT 3;

\echo ''
\echo '========== 12. stg_nilo_panorama_orcamentario =========='
SELECT * FROM staging.stg_nilo_panorama_orcamentario LIMIT 3;

\echo ''
\echo '========== 13. stg_nilo_taxa_evasao =========='
SELECT * FROM staging.stg_nilo_taxa_evasao LIMIT 3;

\echo ''
\echo '========== 14. stg_nilo_cargos_carreira =========='
SELECT * FROM staging.stg_nilo_cargos_carreira LIMIT 3;

\echo ''
\echo '========== 15. stg_nilo_tecnicos_adm_nivel =========='
SELECT * FROM staging.stg_nilo_tecnicos_adm_nivel LIMIT 3;

\echo ''
\echo '========== 16. stg_nilo_titulacao_docente =========='
SELECT * FROM staging.stg_nilo_titulacao_docente LIMIT 3;

\echo ''
\echo '========== 17. stg_nilo_professores_por_instituicao =========='
SELECT * FROM staging.stg_nilo_professores_por_instituicao LIMIT 3;

\echo ''
\echo '========== FOREIGN KEYS E RELACIONAMENTOS =========='
SELECT
  tc.table_schema,
  tc.table_name,
  kcu.column_name,
  ccu.table_schema AS foreign_table_schema,
  ccu.table_name AS foreign_table_name,
  ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
  ON tc.constraint_name = kcu.constraint_name
  AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage AS ccu
  ON ccu.constraint_name = tc.constraint_name
  AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.table_schema = 'staging'
ORDER BY tc.table_name;
