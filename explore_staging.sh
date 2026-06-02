#!/bin/bash

# Script para conectar ao Supabase e explorar o schema 'staging'

echo "========== EXPLORAÇÃO DO SCHEMA 'STAGING' - EPT =========="
echo ""

# Se .env não existe, pedir credenciais
if [ ! -f .env ]; then
    echo "Arquivo .env não encontrado. Solicitando credenciais do Supabase..."
    read -p "Host (ex: aws-1-us-east-1.pooler.supabase.com): " DB_HOST
    read -p "Porta [5432]: " DB_PORT
    DB_PORT=${DB_PORT:-5432}
    read -p "Database [postgres]: " DB_NAME
    DB_NAME=${DB_NAME:-postgres}
    read -p "Usuário (ex: postgres.seu-project-ref): " DB_USER
    read -sp "Senha: " DB_PASSWORD
    echo ""
else
    # Carregar do .env
    export $(cat .env | grep -v '^#' | xargs)
    DB_HOST=$host
    DB_PORT=$port
    DB_NAME=$database
    DB_USER=$user
    DB_PASSWORD=$password
fi

echo ""
echo "Conectando ao banco: $DB_HOST:$DB_PORT/$DB_NAME como $DB_USER..."
echo ""

# Executar o script SQL
PGPASSWORD="$DB_PASSWORD" psql \
  -h "$DB_HOST" \
  -p "$DB_PORT" \
  -U "$DB_USER" \
  -d "$DB_NAME" \
  -f explore_staging.sql

echo ""
echo "Exploração concluída!"
