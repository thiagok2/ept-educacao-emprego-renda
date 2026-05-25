---
name: nilo-loader
description: Carrega um CSV da Plataforma Nilo Peçanha na tabela staging do Supabase. Invoque passando o nome do arquivo CSV como argumento (com ou sem extensão), ex: /nilo-loader CursoMatriculaOferta. Cria a tabela stg_nilo_<nome_snake_case> com tipos inferidos, comentários extraídos do PDF homônimo e atualiza NILO.md.
---

# Nilo Loader

Execute todas as etapas abaixo **sem solicitar confirmações ao usuário**. Todas as permissões necessárias já estão pré-autorizadas em `.claude/settings.local.json`. Apenas notifique ao final com o resumo.

## Variáveis de contexto

- Pasta base dos dados: `dados-fonte/nilo/`
- Argumento recebido: nome do CSV (ex: `CursoMatriculaOferta` ou `CursoMatriculaOferta.csv`)
- Nome normalizado: remova a extensão `.csv` se presente, converta para `snake_case` minúsculo
- Nome da tabela: `stg_nilo_<nome_normalizado>`
- Arquivo CSV: `dados-fonte/nilo/<argumento_original_sem_extensão>.csv` (preservar o case original do arquivo)
- Arquivo PDF: `dados-fonte/nilo/<argumento_original_sem_extensão>.pdf` (pode não existir)

---

## Etapa 1 — Verificar arquivos

Execute em paralelo:
```bash
ls dados-fonte/nilo/
```
1. Confirme que o CSV existe (use o nome original do argumento, não snake_case).
2. Verifique se existe o PDF homônimo.
3. Se o CSV não existir, informe o usuário e encerre.

## Etapa 2 — Ler e analisar o CSV

Execute em paralelo:
```bash
head -5 dados-fonte/nilo/<arquivo>.csv
wc -l dados-fonte/nilo/<arquivo>.csv
file dados-fonte/nilo/<arquivo>.csv
```
1. Identifique o separador (`,` `;` ou `|`) e encoding.
2. Liste todas as colunas e amostre os valores para inferir os tipos PostgreSQL:
   - Números inteiros → `INTEGER`
   - Números decimais com vírgula → `TEXT` (com nota no COMMENT)
   - Datas (dd/mm/yyyy) → `DATE`
   - Texto geral → `TEXT`
   - Siglas/códigos curtos (até ~20 chars) → `VARCHAR(50)`

## Etapa 3 — Extrair documentação do PDF

Se o PDF existir:
1. Leia o PDF com a ferramenta Read.
2. Para cada coluna do CSV, localize a descrição correspondente no PDF.
3. Monte um dicionário `coluna → descrição` para uso nos COMMENTs.

Se o PDF não existir:
- Derive descrições legíveis a partir dos nomes das colunas.
- Registre no NILO.md que a documentação do PDF está pendente.

## Etapa 4 — Montar e salvar o DDL

Gere o SQL e salve em `/tmp/stg_nilo_<nome_normalizado>.sql`:

```sql
DROP TABLE IF EXISTS staging.stg_nilo_<nome_normalizado>;

CREATE TABLE staging.stg_nilo_<nome_normalizado> (
  id             SERIAL PRIMARY KEY,
  <coluna_1>     <TIPO>,
  <coluna_2>     <TIPO>,
  ...
  carregado_em   TIMESTAMP DEFAULT NOW()
);

COMMENT ON TABLE  staging.stg_nilo_<nome_normalizado> IS '<descrição geral>';
COMMENT ON COLUMN staging.stg_nilo_<nome_normalizado>.id IS 'Chave surrogate gerada na carga';
COMMENT ON COLUMN staging.stg_nilo_<nome_normalizado>.<coluna_1> IS '<descrição do PDF>';
...
COMMENT ON COLUMN staging.stg_nilo_<nome_normalizado>.carregado_em IS 'Data e hora da carga do CSV';
```

## Etapa 5 — Executar o DDL

```bash
export $(grep -v '^#' .env | xargs) && \
PGPASSWORD="$password" psql -h "$host" -p "$port" -U "$user" -d "$database" \
  -f /tmp/stg_nilo_<nome_normalizado>.sql
```

## Etapa 6 — Carregar os dados em background

Use `run_in_background: true` na chamada Bash para o COPY, pois pode ser demorado:

```bash
export $(grep -v '^#' .env | xargs) && \
PGPASSWORD="$password" psql -h "$host" -p "$port" -U "$user" -d "$database" \
  -c "\COPY staging.stg_nilo_<nome_normalizado> (<colunas_sem_id_sem_carregado_em>) FROM '<caminho_absoluto_csv>' WITH (FORMAT csv, HEADER true, DELIMITER '<sep>', ENCODING '<enc>', NULL '')" \
  && echo "COPY_OK"
```

Aguarde a conclusão do background job. Quando retornar, confirme o volume via MCP:
```sql
SELECT COUNT(*) FROM staging.stg_nilo_<nome_normalizado>;
```

## Etapa 7 — Atualizar NILO.md

Leia o `NILO.md` atual. Se já existir seção para a tabela, **atualize**. Caso contrário, **adicione** ao final:

```markdown
## stg_nilo_<nome_normalizado>

**Fonte:** Plataforma Nilo Peçanha — arquivo `<arquivo_original>.csv`
**Documentação:** `dados-fonte/nilo/<arquivo_original>.pdf` (presente / ausente)
**Linhas carregadas:** <N>
**Cobertura temporal:** <ano_min> – <ano_max> (se coluna `ano` existir)
**Última carga:** <YYYY-MM-DD>

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | SERIAL | Chave surrogate gerada na carga |
| <coluna_1> | <TIPO> | <descrição> |
...
| carregado_em | TIMESTAMP | Data e hora da carga do CSV |
```

---

## Notificação final

Ao concluir todas as etapas, exiba apenas:

```
✓ stg_nilo_<nome_normalizado> criada — <N> linhas carregadas
  PDF: <encontrado/ausente> | NILO.md: atualizado
  <observações se houver colunas sem doc ou tipos TEXT por decimal com vírgula>
```
