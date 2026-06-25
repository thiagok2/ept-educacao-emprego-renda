# Relatório de prontidão das tabelas dw_*

| Tabela | Linhas | Nulos críticos | Órfãos FK | Consistência c/ fato | Duplicatas | Status |
|--------|--------|----------------|-----------|----------------------|------------|--------|
| dw_ept_curso_ano | 0 | - | - | N/A | 0 | ❌ |
| dw_ept_curso_periodo | 92608 | matriculas_numero_de_evadidos:18892, matriculas_taxa_de_evasao_percentual:18892 | - | N/A | 0 | ⚠️ |
| dw_ept_instituicao_ano | 328 | docentes_numero_total:41, servidores_numero_de_servidores:41 | - | N/A | 0 | ⚠️ |
| dw_ept_instituicao_demografia | 213776 | numero_concluintes:78467, numero_ingressantes:46260, numero_vagas:47710 | - | OK | 0 | ⚠️ |
| dw_ept_orcamentario_uge_ano | 533 | - | - | N/A | 0 | ✅ |
| dw_ept_unidade_ano | 5120 | eficiencia_academica_numero_de_evadidos:18, indice_verticalizacao_vagas_cg:1283, indice_verticalizacao_vagas_ct:187, indice_verticalizacao_vagas_pg:3140, indice_verticalizacao_vagas_qp:1854, oferta_de_vagas_curso_noturno:2062, oferta_de_vagas_curso_noturno_percentual:2062, oferta_de_vagas_graduacao:1338, matricula_equivalente_formacao_de_professores:1030, matricula_equivalente_tecnicos:114, matricula_equivalente_proeja:3194, matricula_equivalente_geral:10, rap_matriculas_rap:10, numero_de_inscritos:34, numero_de_vagas:36, reserva_cota_vagas:1434, vagas_regulares_cota_percentual:1434, reserva_ampla_concorrencia_vagas:1353, vagas_regulares_ampla_concorrencia_percentual:1353 | - | N/A | 0 | ⚠️ |