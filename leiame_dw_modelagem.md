# Modelagem DW

## Dimensões propostas

### dim_tempo_ano
- Chave natural: `ano`
- Atributos: `ano`, `ano_agrupado` (ano fiscal/letivo se aplicável), `periodo` (não disponível nas tabelas atuais)
- Uso: referenciar fatos em nível anual.

### dim_instituicao
- Chave natural: `instituicao`
- Atributos: `instituicao_nome`, `regiao`, `uf`, `estado`, `organizacao_academica_pnp`
- Uso: base comum para fatos de Instituição e para unir tabelas de mesmo grão institucional.

### dim_unidade_academica
- Chave natural sugerida: `(instituicao, nome_unidade_recente)`
- Atributos: `nome_unidade_recente`, `instituicao_nome`, `regiao`, `uf`, `estado`, `organizacao_academica_pnp`
- Uso: granularidade Campus / unidade dentro da instituição.

### dim_curso
- Chave natural sugerida: `(instituicao, nome_id_curso)` ou `nome_id_curso`
- Atributos: `nome_curso`, `tipo_curso`, `tipo_oferta`, `modalidade_ensino`, `tipo_eixo_tecnologico`, `subeixo_tecnologico`, `nome_fonte_financiamento`, `turno_curso`
- Uso: suportar fatos de Curso/Ano e Curso/Período.

## Fatos propostos

### fato_instituicao_ano
- Grão: `ano + instituicao`
- Chaves:
  - `ano_key` → `dim_tempo_ano`
  - `instituicao_key` → `dim_instituicao`
- Principais medidas:
  - `numero_concluintes`, `numero_ingressantes`, `numero_matriculas`, `numero_vagas`
  - `gastos_correntes_por_matricula_equivalente`, `gastos_correntes_gastos_totais`, `gastos_correntes_gastos_correntes`, `gastos_correntes_inativos_e_pensionistas`, `gastos_correntes_investimentos_e_inversoes_financeiras`, `gastos_correntes_precatorios`, `gastos_correntes_outros_custeios`, `gastos_correntes_pessoal`
  - `taxa_ocupacao_matriculas_ciclos_vigentes`, `taxa_ocupacao_vagas_ciclos_vigentes`, `taxa_ocupacao_taxa_de_ocupacao`
  - `numero_de_servidores_siafi`, `servidores_numero_de_docentes`, `servidores_numero_de_servidores`, `servidores_docente_efetivo`
  - indicadores orçamentários: `dotacao_atualizada`, `despesa_empenhada`, `despesa_liquidada`, `despesa_paga`, `despesa_liq_rp`, `despesa_empenhada_a_liquidar`, `credito_disponivel`
- Fonte inicial: tabelas de Instituição.

### fato_unidade_ano
- Grão: `ano + instituicao + nome_unidade_recente`
- Chaves:
  - `ano_key` → `dim_tempo_ano`
  - `instituicao_key` → `dim_instituicao`
  - `unidade_key` → `dim_unidade_academica`
- Principais medidas:
  - `numero_de_matriculas`, `matriculas_numero_de_evadidos`, `matriculas_taxa_de_evasao_percentual`
  - `eficiencia_academica_concluidos`, `eficiencia_academica_concluidos_percentual`, `eficiencia_academica_indice_eficiencia_academica_percentual`, `eficiencia_academica_numero_de_evadidos`, `eficiencia_academica_retidos`, `eficiencia_academica_retidos_percentual`, `eficiencia_academica_taxa_de_evasao_percentual`
  - `indice_verticalizacao_vagas_cg`, `indice_verticalizacao_vagas_ct`, `indice_verticalizacao_vagas_pg`, `indice_verticalizacao_vagas_qp`, `indice_verticalizacao_eixo_tecnologico`
  - `oferta_de_vagas_curso_noturno`, `oferta_de_vagas_curso_noturno_percentual`, `oferta_de_vagas_graduacao`
  - `matricula_equivalente_formacao_de_professores`, `matricula_equivalente_tecnicos`, `matricula_equivalente_proeja`, `matricula_equivalente_geral`
  - `rap_rap`, `rap_matriculas_rap`, `rap_professor_equivalente`
  - `numero_de_inscritos`, `numero_de_vagas`, `relacao_inscrito_vaga`
  - `tipo_reserva_vaga`, `vagas_regulares`, `vagas_regulares_percentual`
- Fonte inicial: tabelas de Campus.

### fato_curso_ano
- Grão: `ano + instituicao + nome_id_curso`
- Chaves:
  - `ano_key` → `dim_tempo_ano`
  - `instituicao_key` → `dim_instituicao`
  - `curso_key` → `dim_curso`
- Principais medidas:
  - `num_cursos`, `num_concluintes`, `num_ingressantes`, `num_inscritos`, `num_matriculas`, `num_vagas`, `matricula_equivalente_geral`
  - `numero_de_cursos`, `numero_de_concluintes`, `numero_de_ingressantes`, `numero_de_inscritos`, `numero_de_matriculas`, `numero_de_vagas`, `matricula_equivalente_geral`
- Fonte inicial: `stg_nilo_curso_matricula_oferta`, `stg_nilo_dados_gerais`.

### fato_curso_periodo
- Grão: `ano + instituicao + nome_curso + turno_curso + tipo_oferta`
- Chaves:
  - `ano_key` → `dim_tempo_ano`
  - `instituicao_key` → `dim_instituicao`
  - `curso_key` → `dim_curso` (apoiado em `nome_curso` e atributos de oferta)
- Principais medidas:
  - `numero_de_matriculas`, `matriculas_numero_de_evadidos`, `matriculas_taxa_de_evasao_percentual`
- Fonte inicial: `stg_nilo_taxa_evasao`.

## Indicadores sugeridos

- Matrículas ativas e ingressantes
- Concluintes e evasão
- Ocupação de vagas
- Gastos correntes por matrícula equivalente e valores totais
- Eficiência acadêmica e retidos
- Indicadores de gastos por categoria orçamentária
- Relação aluno/professor (RAP)
- Reserva de vagas por categoria
- Percentuais legais de matrícula equivalente
- Titulação e dimensionamento de servidores

## Observações

- Não há evidência de relacionamentos além das chaves propostas.
- A modelagem prioriza fatos alinhados com os grãos detectados e dimensões reutilizáveis.
- Não foram geradas estruturas DDL nesta fase, apenas proposta conceitual.
