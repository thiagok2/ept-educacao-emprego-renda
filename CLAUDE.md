# EPT — Educação, Emprego e Renda

Projeto de coleta, consolidação e análise de dados da Educação Profissional e Tecnológica (EPT), com foco nas **Instituições Federais de Educação (IFs)**. O projeto consome dados do [Observatório EPT](https://observatorio-ept-rascunho.netlify.app/) como uma de suas fontes, além de outras bases públicas.

---

## Objetivo

Consolidar microdados públicos de múltiplas fontes sobre EPT no Brasil — matrículas, cursos, concluintes, indicadores de empregabilidade e renda — filtrando e enriquecendo os registros relativos aos Institutos Federais. O Observatório EPT é uma das fontes de dados consolidados utilizadas pelo projeto, não o destino final.

---

## Fontes de Dados

| Fonte | Descrição | Pasta |
|---|---|---|
| **Plataforma Nilo Peçanha (PNP)** | Dados oficiais da Rede Federal: matrículas, cursos, docentes, servidores, infraestrutura | `dados-fonte/nilo/` |
| **Censo da Educação Básica e Superior (INEP)** | Microdados anuais do INEP: matrículas técnicas, indicadores de fluxo, concluintes | `dados-fonte/inep/` |
| **Observatório EPT** | Dados consolidados já tratados, usados como base de referência e complemento às demais fontes | `dados-fonte/observatorio/` |

> Os arquivos CSV/XLSX das fontes são gitignored por volume. Baixe diretamente das fontes oficiais conforme instruções em `dados-fonte/READ_DADOS_FONTES.md`.

### Links oficiais das fontes

- PNP: https://www.plataformanilopeçanha.mec.gov.br/
- Censo INEP (Básica): https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-escolar
- Censo INEP (Superior): https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-da-educacao-superior
- Observatório EPT: https://observatorio-ept-rascunho.netlify.app/

---

## Stack Tecnológica

| Camada | Tecnologia |
|---|---|
| ETL visual | Pentaho Data Integration (PDI/Kettle) — arquivos `.ktr` e `.kjb` |
| ETL alternativo | Apache Hop |
| Scripts de transformação | Python |
| Banco de dados | PostgreSQL via Supabase |
| Acesso via Claude Code | MCP `@modelcontextprotocol/server-postgres` |

---

## Estrutura do Projeto

```
ept-educacao-emprego-renda/
├── dados-fonte/              # CSVs/XLSX das fontes (gitignored por volume)
│   ├── nilo/                 # Dados da Plataforma Nilo Peçanha
│   ├── inep/                 # Microdados INEP
│   └── observatorio/         # Dados consolidados do Observatório
├── etl/                      # Transformações e pipelines
│   ├── ept.ktr               # Transformação Pentaho principal
│   └── README_ETL.md
├── .env.example              # Estrutura das credenciais (sem valores)
├── .mcp.json.example         # Estrutura da config MCP (sem credenciais)
└── CLAUDE.md                 # Este arquivo
```

---

## Setup do Ambiente

### 1. Credenciais do banco

Copie `.env.example` para `.env` e preencha com as credenciais do Supabase:

```bash
cp .env.example .env
```

As credenciais ficam em **Supabase → Settings → Database → Connection string** (usar o host do connection pooler):

```
host=aws-1-us-east-1.pooler.supabase.com
port=5432
database=postgres
user=postgres.<project-ref>
password=<sua-senha>
```

### 2. MCP para Claude Code

Copie `.mcp.json.example` para `.mcp.json` e substitua com a connection string real, **URL-encodando a senha** (caracteres especiais: `/` → `%2F`, `+` → `%2B`, `@` → `%40`):

```bash
cp .mcp.json.example .mcp.json
```

Exemplo de connection string com senha URL-encoded:

```
postgresql://postgres.<ref>:minha%40senha%2Fcomcaracteres@aws-1-us-east-1.pooler.supabase.com:5432/postgres
```

Reinicie o Claude Code após configurar o `.mcp.json` para o MCP postgres ficar disponível.

### 3. Pentaho Data Integration

- Importe a conexão do banco em **Edit → Create connection** usando os valores do `.env`
- Abra os arquivos `.ktr` em `etl/` via PDI ou Apache Hop

---

## Banco de Dados (Supabase/PostgreSQL)

O banco concentra os dados consolidados prontos para consumo pelo Observatório. Todas as tabelas de negócio vivem no schema `public`.

Para explorar via Claude Code (com MCP ativo):

```sql
-- Listar tabelas do projeto
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public' ORDER BY table_name;
```

---

## Convenções

- Foco exclusivo em **Institutos Federais** (IFs) — filtrar `NO_CATEGORIA_ADMINISTRATIVA = 'Federal'` ou equivalente em cada fonte
- Granularidade mínima: **instituição × ano × curso**
- Nomenclatura de tabelas: `snake_case`, prefixo pela fonte quando necessário (`pnp_`, `inep_`, `obs_`)
- Arquivos de dados brutos nunca são commitados — apenas scripts e transformações
