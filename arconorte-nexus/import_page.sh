#!/bin/bash

# ==========================================================================
# Script de Automação para Importação da Landing Page do ArcoNorte Nexus
# ==========================================================================

# Configurações do repositório central (determinado dinamicamente)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
REPO_URL="git@github-thp:thpinteligencia/thpinteligencia.github.io.git"

# Define caminhos padrão específicos do ArcoNorte Nexus
DEFAULT_SRC_DIR="/home/hiago/Workspace/THP/arconorte-nexus/docs"
DEFAULT_SUB_FOLDER="arconorte-nexus"

SRC_DIR="${1:-$DEFAULT_SRC_DIR}"
SUB_FOLDER="${2:-$DEFAULT_SUB_FOLDER}"

echo "🔄 Iniciando sincronização da landing page para '$SUB_FOLDER'..."
echo "📂 Pasta de Origem: $SRC_DIR"
echo "📂 Pasta de Destino: $TARGET_REPO_DIR/$SUB_FOLDER"

# Valida pasta de origem
if [ ! -d "$SRC_DIR" ]; then
    echo "❌ Erro: A pasta de origem '$SRC_DIR' não existe."
    exit 1
fi

# Navega até a pasta do repositório
cd "$TARGET_REPO_DIR" || exit 1

# Garante que o repositório local está sincronizado com a nuvem
echo "🔄 Atualizando repositório local thpinteligencia.github.io..."
git pull origin main

# Cria a subpasta de destino se não existir
DEST_DIR="$TARGET_REPO_DIR/$SUB_FOLDER"
mkdir -p "$DEST_DIR"

# Copia de forma limpa os arquivos
echo "🗑️ Limpando conteúdo anterior na pasta de destino (exceto import_page.sh e README.md)..."
rm -f "$DEST_DIR"/index.html "$DEST_DIR"/style.css "$DEST_DIR"/script.js 2>/dev/null

echo "📥 Copiando novos arquivos de '$SRC_DIR' para '$DEST_DIR'..."
cp "$SRC_DIR"/index.html "$DEST_DIR/"
cp "$SRC_DIR"/style.css "$DEST_DIR/"
cp "$SRC_DIR"/script.js "$DEST_DIR/"

# Sanitização automática no index.html de destino (como rede de segurança)
echo "🧹 Sanitizando links no arquivo de destino..."
# Garante a substituição de links diretos ao repositório privado se eles voltarem a ser introduzidos na origem
sed -i 's|href="https://github.com/vrural/arconorte-nexus"|href="../"|g' "$DEST_DIR/index.html"
sed -i 's|class="nav-item github-link-btn"|class="nav-item portfolio-link-btn"|g' "$DEST_DIR/index.html"
sed -i 's|id="github-nav"|id="portfolio-nav"|g' "$DEST_DIR/index.html"
sed -i 's|Repositório|Portfólio THP|g' "$DEST_DIR/index.html"

# Git Deploy
echo "🚀 Commitando e enviando alterações para o repositório público..."
git add "$SUB_FOLDER/index.html" "$SUB_FOLDER/style.css" "$SUB_FOLDER/script.js" "$SUB_FOLDER/README.md" "$SUB_FOLDER/import_page.sh"
git commit -m "feat: deploy/update landing page for $SUB_FOLDER"
git push origin main

if [ $? -eq 0 ]; then
    echo "✅ Sucesso! A landing page está no ar em:"
    echo "👉 https://thpinteligencia.github.io/$SUB_FOLDER/"
else
    echo "❌ Erro ao enviar os dados para o GitHub."
fi
