#!/bin/bash

# Verifica se o parâmetro foi passado
if [ -z "$1" ]; then
  echo "É necessário passar o parâmetro"
  exit 1
fi

# Faz o parse do arquivo JSON e escreve no output
jq -r --arg param "$1" 'to_entries[] | select(.key | ascii_upcase | sub($param + "_";"")) | "\(.key | ascii_upcase | sub($param + "_";""))=\(.value)"' secrets.json

# O comando "jq" acima faz o parse do arquivo "secrets.json" e escreve na saída padrão
# apenas as chaves que correspondem ao parâmetro passado, convertendo seus valores para
# maiúsculas e removendo o prefixo do parâmetro.
# Por exemplo, se o parâmetro passado for "foo", as chaves do arquivo que começam com "foo_"
# serão exibidas na saída padrão, com o prefixo removido e seus valores convertidos para maiúsculas.
# Caso nenhuma chave seja encontrada, a saída será vazia.