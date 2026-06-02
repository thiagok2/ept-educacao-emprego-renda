# Consolidação de Tabelas Staging - Resultado Final

**Data:** 2 de junho de 2026  
**Status:** ✅ **SUCESSO**  
**Script:** `tmp/consolidacao_tabelas.sql`

---

## 📊 Tabelas Criadas (7 no total)

| # | Tabela | Granularidade | Linhas | Descrição |
|---|--------|---------------|--------|-----------|
| 1 | `fato_curso_matricula_oferta` | unidade + curso + oferta + modalidade + ano | 295.438 | Matrículas por curso (sem turno separado) |
| 2 | `fato_instituicao_demografia` | instituição + ano | 213.776 | Demografia: renda, sexo, faixa etária, cor/raça |
| 3 | `fato_unidade_indicadores` | instituição + campus + ano | 5.120 | 7 JOINs consolidadas: eficiência, verticalização, oferta noturna, percentuais legais, RAP, inscritos/vagas, reserva de vagas |
| 4 | `fato_unidade_situacao_matricula` | instituição + campus + ano | 36.237 | Situação de matrícula por categoria (ativo, retido, evadido) |
| 5 | `fato_instituicao_orcamentario` | instituição + órgão + ano | 4.615 | Panorama orçamentário: dotação, empenho, liquidação, crédito |
| 6 | `fato_curso_taxa_evasao` | instituição + campus + curso + modalidade + turno + ano | 93.420 | Taxa de evasão por curso e turno |
| 7 | `fato_instituicao_servidores` | instituição + ano | 340 | Servidores (com pivot): docentes por titulação/jornada, técnicos |

**Total de registros consolidados:** 648.946

---

## 🔄 JOINs Realizados

### Grupo 1: Curso/Matrícula/Oferta
```sql
LEFT JOIN stg_nilo_curso_matricula_oferta ← stg_nilo_dados_gerais
```

### Grupo 3: Indicadores por Campus (7 JOINs)
```sql
stg_nilo_eficiencia_academica ←
  LEFT JOIN stg_nilo_indice_verticalizacao
  LEFT JOIN stg_nilo_oferta_vagas_noturnas
  LEFT JOIN stg_nilo_percentuais_legais
  LEFT JOIN stg_nilo_relacao_aluno_professor_rap
  LEFT JOIN stg_nilo_relacao_inscritos_vagas
  LEFT JOIN stg_nilo_reserva_vagas2
```

### Grupo 7: Servidores (com PIVOTs)
```sql
stg_nilo_cargos_carreira ←
  LEFT JOIN stg_nilo_titulacao_docente
  LEFT JOIN stg_nilo_professores_por_instituicao (PIVOT por titulação/jornada)
  LEFT JOIN stg_nilo_tecnicos_adm_nivel (PIVOT por escolaridade)
```

---

## 🔑 Chaves de Junção Utilizadas

| Tabela(s) | Chave(s) de Junção |
|-----------|-------------------|
| Curso/Matrícula | `(ano, instituicao, nome_id_curso, tipo_oferta)` |
| Indicadores Campus | `(ano, instituicao, nome_unidade_recente)` |
| Situação Matrícula | `(ano, instituicao, nome_unidade_recente)` |
| Orçamentário | `(ano, instituicao, relacao_do_orgao)` |
| Taxa Evasão | `(ano, instituicao, nome_unidade_recente, nome_curso, turno_curso)` |
| Servidores | `(ano, instituicao)` |

---

## 📝 Estrutura das Tabelas

### fato_curso_matricula_oferta
- Colunas: `ano, instituicao, instituicao_nome, nome_unidade_recente, nome_id_curso, tipo_curso, tipo_oferta, modalidade_ensino, num_*, matricula_equivalente_geral`
- Sem separação de turno; oferece agregação por modalidade

### fato_instituicao_demografia
- Colunas: `ano, instituicao, instituicao_nome, cor_raca, renda_familiar, faixa_etaria, sexo, numero_*`
- Única tabela mais detalhada em termos demográficos

### fato_unidade_indicadores
- Colunas: Todas as métricas de campus (eficiência, verticalização, oferta noturna, percentuais legais, RAP, inscritos/vagas, reserva)
- 38 colunas de indicadores consolidados

### fato_unidade_situacao_matricula
- Colunas: `ano, instituicao, instituicao_nome, nome_unidade_recente, categoria_situacao, nome_situacao, fluxo_retido, numero_de_matriculas`
- Permite análise de fluxo por categoria

### fato_instituicao_orcamentario
- Colunas: `ano, instituicao, instituicao_nome, relacao_do_orgao, resultado_primario_cidada, dotacao_*, despesa_*`
- Suporta análise orçamentária com detalhes de empenho, liquidação, pagamento

### fato_curso_taxa_evasao
- Colunas: `ano, instituicao, instituicao_nome, nome_unidade_recente, nome_curso, tipo_curso, tipo_eixo_tecnologico, subeixo_tecnologico, tipo_oferta, turno_curso, modalidade_ensino, nome_fonte_financiamento, numero_de_matriculas, matriculas_numero_de_evadidos, matriculas_taxa_de_evasao_percentual`
- Granularidade mais fina: permite análise por turno e eixo tecnológico

### fato_instituicao_servidores
- Colunas: Agrega docentes por titulação (Doutorado, Mestrado, Especialização, Graduação) × jornada (40h, 20h, DE); técnicos por escolaridade
- PIVOTs: docentes_[titulacao]_[jornada], tecnicos_[escolaridade]

---

## ✅ Validações

- [x] Todas as 7 tabelas criadas com sucesso
- [x] Contagem de linhas conferida e positiva
- [x] Granularidades mantidas conforme especificado
- [x] JOINs resolvidos corretamente
- [x] Nenhum erro de sintaxe SQL
- [x] PIVOTs implementados para servidores

---

## 🚀 Próximos Passos Sugeridos

1. **Validar dados:** Executar queries de amostra em cada tabela
2. **Criar índices:** Para melhorar performance em `ano, instituicao, nome_unidade_recente`
3. **Documentar:** Adicionar estas tabelas ao `leiame_dw_catalogo.md`
4. **Consultas de negócio:** Preparar queries para análise de empregabilidade, renda, evasão
5. **Versionamento:** Commitar o script `consolidacao_tabelas.sql` e este documento

---

## 📌 Convenções Mantidas

- ✅ Foco em **Institutos Federais** (filtro via `organizacao_academica_pnp = 'Federal'`)
- ✅ Granularidade mínima respeitada para cada grupo
- ✅ Nomenclatura `fato_` para tabelas de negócio consolidadas
- ✅ Schema `staging` para manter organização
- ✅ Nomes de colunas com prefixos semânticos (`eficiencia_academica_`, `indice_verticalizacao_`, etc.)

---

**Script completo:** [consolidacao_tabelas.sql](consolidacao_tabelas.sql)
