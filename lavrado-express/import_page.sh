#!/bin/bash

# ==========================================================================
# Script de Automação para Importação de Landing Pages no GitHub Pages
# ==========================================================================

# Configurações do repositório central
TARGET_REPO_DIR="/home/hiago/Workspace/THP/thpinteligencia.github.io"
REPO_URL="git@github-thp:thpinteligencia/thpinteligencia.github.io.git"

# Verifica parâmetros
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Uso: $0 <caminho_origem_da_landing_page> <nome_da_subpasta_no_site>"
    echo "Exemplo: $0 \"/home/hiago/Workspace/THP/ProjetoX/public\" \"projeto-x\""
    exit 1
fi

SRC_DIR="$1"
SUB_FOLDER="$2"

# Valida pasta de origem
if [ ! -d "$SRC_DIR" ]; then
    echo "❌ Erro: A pasta de origem '$SRC_DIR' não existe."
    exit 1
fi

# Clona o repositório central se não existir localmente no caminho padrão
if [ ! -d "$TARGET_REPO_DIR" ]; then
    echo "⚙️ Clonando repositório thpinteligencia.github.io..."
    git clone "$REPO_URL" "$TARGET_REPO_DIR"
    if [ $? -ne 0 ]; then
        echo "❌ Erro ao clonar o repositório. Verifique suas credenciais SSH."
        exit 1
    fi
fi

# Navega até a pasta do repositório
cd "$TARGET_REPO_DIR" || exit 1

# Garante que o repositório local está sincronizado com a nuvem
echo "🔄 Atualizando repositório local..."
git pull origin main

# Cria a subpasta de destino se não existir
DEST_DIR="$TARGET_REPO_DIR/$SUB_FOLDER"
mkdir -p "$DEST_DIR"

# Copia de forma limpa os arquivos
echo "🗑️ Limpando conteúdo anterior na pasta de destino..."
rm -rf "$DEST_DIR"/* 2>/dev/null

echo "📥 Copiando arquivos de '$SRC_DIR' para '$DEST_DIR'..."
cp -R "$SRC_DIR"/* "$DEST_DIR/"

# Git Deploy
echo "🚀 Commitando e enviando alterações..."
git add "$SUB_FOLDER"
git commit -m "feat: import/update landing page for $SUB_FOLDER"
git push origin main

if [ $? -eq 0 ]; then
    echo "✅ Sucesso! A landing page está no ar em:"
    echo "👉 https://thpinteligencia.github.io/$SUB_FOLDER/"
else
    echo "❌ Erro ao enviar os dados para o GitHub."
fi
