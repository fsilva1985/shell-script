#!/bin/bash

# O comando "find" procura por arquivos dentro do diretório atual (".") e seus subdiretórios ("-type f")
find . -type f |

# O loop "while" lê cada linha de saída do comando "find" e armazena na variável "filename"
while read filename
do
    # Verifica se o nome do arquivo não contém a extensão ".HEIC"
    if [[ "$filename" != *".HEIC"* ]]; then
        continue; # Se não for um arquivo HEIC, pula para o próximo arquivo
    fi

    # Converte o arquivo HEIC em formato JPEG com qualidade 92, mantendo o mesmo nome e apenas mudando a extensão
    heif-convert -q 92 ${filename} ${filename%.*}.JPG
done
