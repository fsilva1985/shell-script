#!/bin/bash

# Arquivo onde será salvo o resultado
OUTPUT_FILE="/home/felipe.miranda/Downloads/scan_result.txt"

# Cria ou limpa o arquivo de saída
> $OUTPUT_FILE

# Lista de pastas e arquivos a serem ignorados
IGNORED_PATHS=(
  ".git"
  "node_modules"
  "vendor"
  ".logs"
  "logs"
  "tests"
  "package-lock.json"
  "pnpm-lock.yaml"
  "scan_result.txt"
  "Makefile"
  "docker-compose.yml"
  "jsconfig.json"
  ".gitignore"
  "code_scan.sh"
  "yarn.lock"
  ".npmrc"
  "storage"
  "bootstrap"
  "public"
  "tests"
  ".docker"
  "artisan"
  "composer.lock"
  "database.sqlite"
  "docker-compose"
  "phpunit.xml"
  "postcss.config.js"
  "README.md"
  "*.md"
  ".github"
  "*.yml"
  "*.svg"
  "*.png"
  "*.jpg"
  ".vscode"
  ".editorconfig"
  "phpunit.xml.dist"
  "*.postman_collection.json"
  ".infrastructure"
  ".env.*"
  ".spin-inventory.ini"
  .vault-password
  ".github"
  ".infrastructure"
  "Dockerfile"
  "docker-*.yml"
  ".gitlab-ci.yml"
  ".spin*"
  ".dockerignore"
  "config"
  "modules"
)

# Função para adicionar paths ao IGNORE_PARAMS com suporte para subdiretórios
add_to_ignore_params() {
  local path=$1
  # Remove barras finais do caminho
  path=${path%/}
  IGNORE_PARAMS+=" -path './${path}' -prune -o -path '**/${path}' -prune -o"
}

# Adiciona arquivos do .gitignore à lista de exclusões
IGNORE_PARAMS=""
if [ -f .gitignore ]; then
  while read -r line; do
    # Ignora linhas em branco e comentários
    [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue
    add_to_ignore_params "$line"
  done < .gitignore
fi

# Adiciona as exclusões padrão
for path in "${IGNORED_PATHS[@]}"; do
  add_to_ignore_params "$path"
done

# Executa o comando find com exclusões e grava a saída em scan_result.txt
eval "find . $IGNORE_PARAMS -type f -print | while read -r file; do echo -e \"\n\n\$file\" >> $OUTPUT_FILE && cat \"\$file\" >> $OUTPUT_FILE && echo -e \"\n\n\" >> $OUTPUT_FILE; done"

echo "Scan completed and saved to $OUTPUT_FILE"
