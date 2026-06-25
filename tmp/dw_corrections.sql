-- dw_ept_curso_ano | tabela vazia
-- Inserir dados na tabela dw.dw_ept_curso_ano: revisar ETL e executar o INSERT correspondente (origem staging).


-- dw_ept_curso_periodo | 18892 nulos em coluna numérica matriculas_numero_de_evadidos
UPDATE dw."dw_ept_curso_periodo" SET "matriculas_numero_de_evadidos" = 0 WHERE "matriculas_numero_de_evadidos" IS NULL;


-- dw_ept_curso_periodo | validação matriculas_numero_de_evadidos
SELECT COUNT(*) FROM dw."dw_ept_curso_periodo" WHERE "matriculas_numero_de_evadidos" IS NULL;


-- dw_ept_instituicao_ano | 41 nulos em coluna numérica docentes_numero_total
UPDATE dw."dw_ept_instituicao_ano" SET "docentes_numero_total" = 0 WHERE "docentes_numero_total" IS NULL;


-- dw_ept_instituicao_ano | validação docentes_numero_total
SELECT COUNT(*) FROM dw."dw_ept_instituicao_ano" WHERE "docentes_numero_total" IS NULL;


-- dw_ept_instituicao_ano | 41 nulos em coluna numérica servidores_numero_de_servidores
UPDATE dw."dw_ept_instituicao_ano" SET "servidores_numero_de_servidores" = 0 WHERE "servidores_numero_de_servidores" IS NULL;


-- dw_ept_instituicao_ano | validação servidores_numero_de_servidores
SELECT COUNT(*) FROM dw."dw_ept_instituicao_ano" WHERE "servidores_numero_de_servidores" IS NULL;


-- dw_ept_instituicao_demografia | 78467 nulos em coluna numérica numero_concluintes
UPDATE dw."dw_ept_instituicao_demografia" SET "numero_concluintes" = 0 WHERE "numero_concluintes" IS NULL;


-- dw_ept_instituicao_demografia | validação numero_concluintes
SELECT COUNT(*) FROM dw."dw_ept_instituicao_demografia" WHERE "numero_concluintes" IS NULL;


-- dw_ept_instituicao_demografia | 46260 nulos em coluna numérica numero_ingressantes
UPDATE dw."dw_ept_instituicao_demografia" SET "numero_ingressantes" = 0 WHERE "numero_ingressantes" IS NULL;


-- dw_ept_instituicao_demografia | validação numero_ingressantes
SELECT COUNT(*) FROM dw."dw_ept_instituicao_demografia" WHERE "numero_ingressantes" IS NULL;


-- dw_ept_instituicao_demografia | 47710 nulos em coluna numérica numero_vagas
UPDATE dw."dw_ept_instituicao_demografia" SET "numero_vagas" = 0 WHERE "numero_vagas" IS NULL;


-- dw_ept_instituicao_demografia | validação numero_vagas
SELECT COUNT(*) FROM dw."dw_ept_instituicao_demografia" WHERE "numero_vagas" IS NULL;


-- dw_ept_unidade_ano | 18 nulos em coluna numérica eficiencia_academica_numero_de_evadidos
UPDATE dw."dw_ept_unidade_ano" SET "eficiencia_academica_numero_de_evadidos" = 0 WHERE "eficiencia_academica_numero_de_evadidos" IS NULL;


-- dw_ept_unidade_ano | validação eficiencia_academica_numero_de_evadidos
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "eficiencia_academica_numero_de_evadidos" IS NULL;


-- dw_ept_unidade_ano | 1283 nulos em coluna numérica indice_verticalizacao_vagas_cg
UPDATE dw."dw_ept_unidade_ano" SET "indice_verticalizacao_vagas_cg" = 0 WHERE "indice_verticalizacao_vagas_cg" IS NULL;


-- dw_ept_unidade_ano | validação indice_verticalizacao_vagas_cg
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "indice_verticalizacao_vagas_cg" IS NULL;


-- dw_ept_unidade_ano | 187 nulos em coluna numérica indice_verticalizacao_vagas_ct
UPDATE dw."dw_ept_unidade_ano" SET "indice_verticalizacao_vagas_ct" = 0 WHERE "indice_verticalizacao_vagas_ct" IS NULL;


-- dw_ept_unidade_ano | validação indice_verticalizacao_vagas_ct
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "indice_verticalizacao_vagas_ct" IS NULL;


-- dw_ept_unidade_ano | 3140 nulos em coluna numérica indice_verticalizacao_vagas_pg
UPDATE dw."dw_ept_unidade_ano" SET "indice_verticalizacao_vagas_pg" = 0 WHERE "indice_verticalizacao_vagas_pg" IS NULL;


-- dw_ept_unidade_ano | validação indice_verticalizacao_vagas_pg
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "indice_verticalizacao_vagas_pg" IS NULL;


-- dw_ept_unidade_ano | 1854 nulos em coluna numérica indice_verticalizacao_vagas_qp
UPDATE dw."dw_ept_unidade_ano" SET "indice_verticalizacao_vagas_qp" = 0 WHERE "indice_verticalizacao_vagas_qp" IS NULL;


-- dw_ept_unidade_ano | validação indice_verticalizacao_vagas_qp
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "indice_verticalizacao_vagas_qp" IS NULL;


-- dw_ept_unidade_ano | 2062 nulos em coluna numérica oferta_de_vagas_curso_noturno
UPDATE dw."dw_ept_unidade_ano" SET "oferta_de_vagas_curso_noturno" = 0 WHERE "oferta_de_vagas_curso_noturno" IS NULL;


-- dw_ept_unidade_ano | validação oferta_de_vagas_curso_noturno
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "oferta_de_vagas_curso_noturno" IS NULL;


-- dw_ept_unidade_ano | 1338 nulos em coluna numérica oferta_de_vagas_graduacao
UPDATE dw."dw_ept_unidade_ano" SET "oferta_de_vagas_graduacao" = 0 WHERE "oferta_de_vagas_graduacao" IS NULL;


-- dw_ept_unidade_ano | validação oferta_de_vagas_graduacao
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "oferta_de_vagas_graduacao" IS NULL;


-- dw_ept_unidade_ano | 10 nulos em coluna numérica rap_matriculas_rap
UPDATE dw."dw_ept_unidade_ano" SET "rap_matriculas_rap" = 0 WHERE "rap_matriculas_rap" IS NULL;


-- dw_ept_unidade_ano | validação rap_matriculas_rap
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "rap_matriculas_rap" IS NULL;


-- dw_ept_unidade_ano | 34 nulos em coluna numérica numero_de_inscritos
UPDATE dw."dw_ept_unidade_ano" SET "numero_de_inscritos" = 0 WHERE "numero_de_inscritos" IS NULL;


-- dw_ept_unidade_ano | validação numero_de_inscritos
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "numero_de_inscritos" IS NULL;


-- dw_ept_unidade_ano | 36 nulos em coluna numérica numero_de_vagas
UPDATE dw."dw_ept_unidade_ano" SET "numero_de_vagas" = 0 WHERE "numero_de_vagas" IS NULL;


-- dw_ept_unidade_ano | validação numero_de_vagas
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "numero_de_vagas" IS NULL;


-- dw_ept_unidade_ano | 1434 nulos em coluna numérica reserva_cota_vagas
UPDATE dw."dw_ept_unidade_ano" SET "reserva_cota_vagas" = 0 WHERE "reserva_cota_vagas" IS NULL;


-- dw_ept_unidade_ano | validação reserva_cota_vagas
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "reserva_cota_vagas" IS NULL;


-- dw_ept_unidade_ano | 1353 nulos em coluna numérica reserva_ampla_concorrencia_vagas
UPDATE dw."dw_ept_unidade_ano" SET "reserva_ampla_concorrencia_vagas" = 0 WHERE "reserva_ampla_concorrencia_vagas" IS NULL;


-- dw_ept_unidade_ano | validação reserva_ampla_concorrencia_vagas
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "reserva_ampla_concorrencia_vagas" IS NULL;


-- dw_ept_curso_periodo | 18892 nulos em coluna textual matriculas_taxa_de_evasao_percentual
UPDATE dw."dw_ept_curso_periodo" SET "matriculas_taxa_de_evasao_percentual" = '0' WHERE "matriculas_taxa_de_evasao_percentual" IS NULL;


-- dw_ept_curso_periodo | validação matriculas_taxa_de_evasao_percentual
SELECT COUNT(*) FROM dw."dw_ept_curso_periodo" WHERE "matriculas_taxa_de_evasao_percentual" IS NULL;


-- dw_ept_unidade_ano | 2062 nulos em coluna textual oferta_de_vagas_curso_noturno_percentual
UPDATE dw."dw_ept_unidade_ano" SET "oferta_de_vagas_curso_noturno_percentual" = '0' WHERE "oferta_de_vagas_curso_noturno_percentual" IS NULL;


-- dw_ept_unidade_ano | validação oferta_de_vagas_curso_noturno_percentual
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "oferta_de_vagas_curso_noturno_percentual" IS NULL;


-- dw_ept_unidade_ano | 1030 nulos em coluna textual matricula_equivalente_formacao_de_professores
UPDATE dw."dw_ept_unidade_ano" SET "matricula_equivalente_formacao_de_professores" = '0' WHERE "matricula_equivalente_formacao_de_professores" IS NULL;


-- dw_ept_unidade_ano | validação matricula_equivalente_formacao_de_professores
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "matricula_equivalente_formacao_de_professores" IS NULL;


-- dw_ept_unidade_ano | 114 nulos em coluna textual matricula_equivalente_tecnicos
UPDATE dw."dw_ept_unidade_ano" SET "matricula_equivalente_tecnicos" = '0' WHERE "matricula_equivalente_tecnicos" IS NULL;


-- dw_ept_unidade_ano | validação matricula_equivalente_tecnicos
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "matricula_equivalente_tecnicos" IS NULL;


-- dw_ept_unidade_ano | 3194 nulos em coluna textual matricula_equivalente_proeja
UPDATE dw."dw_ept_unidade_ano" SET "matricula_equivalente_proeja" = '0' WHERE "matricula_equivalente_proeja" IS NULL;


-- dw_ept_unidade_ano | validação matricula_equivalente_proeja
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "matricula_equivalente_proeja" IS NULL;


-- dw_ept_unidade_ano | 10 nulos em coluna textual matricula_equivalente_geral
UPDATE dw."dw_ept_unidade_ano" SET "matricula_equivalente_geral" = '0' WHERE "matricula_equivalente_geral" IS NULL;


-- dw_ept_unidade_ano | validação matricula_equivalente_geral
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "matricula_equivalente_geral" IS NULL;


-- dw_ept_unidade_ano | 1434 nulos em coluna textual vagas_regulares_cota_percentual
UPDATE dw."dw_ept_unidade_ano" SET "vagas_regulares_cota_percentual" = '0' WHERE "vagas_regulares_cota_percentual" IS NULL;


-- dw_ept_unidade_ano | validação vagas_regulares_cota_percentual
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "vagas_regulares_cota_percentual" IS NULL;


-- dw_ept_unidade_ano | 1353 nulos em coluna textual vagas_regulares_ampla_concorrencia_percentual
UPDATE dw."dw_ept_unidade_ano" SET "vagas_regulares_ampla_concorrencia_percentual" = '0' WHERE "vagas_regulares_ampla_concorrencia_percentual" IS NULL;


-- dw_ept_unidade_ano | validação vagas_regulares_ampla_concorrencia_percentual
SELECT COUNT(*) FROM dw."dw_ept_unidade_ano" WHERE "vagas_regulares_ampla_concorrencia_percentual" IS NULL;
