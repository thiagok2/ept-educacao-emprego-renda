/** https://dontpad.com/jefferson-001 **/

1.
resolver o problema de duplicidade de dados na tabela staging.stg_nilo_situacao_matricula, verificando a relação entre as colunas categoria_situacao, nome_situacao e fluxo_retido.
```sql
SELECT * FROM staging.stg_nilo_situacao_matricula;--por campus --encontrar a relacao entre: categoria_situacao, nome_situacao, fluxo_retido

SELECT * FROM staging.stg_nilo_panorama_orcamentario-- pesqusar relacao_do_orgao(Órgão da UO, Órgão da UGE) - avaliar remover e ficar apenas com uma
```
2. 


