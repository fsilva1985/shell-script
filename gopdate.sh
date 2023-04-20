#!/bin/bash

# Obtém a versão atual do Golang e a versão mais recente disponível
current_version=$(asdf current golang | awk '{print $2}')
latest_version=$(asdf list all golang | grep 1.19 | tail -n 1)

# Extrai o número do patch da versão atual e da versão mais recente
current_version_patch=$(echo $current_version | awk -F "." '{print $3}')
latest_version_patch=$(echo $latest_version | awk -F "." '{print $3}')

# Compara as versões utilizando o operador ">"
if [ $latest_version_patch > $current_version_patch ]; then
    # Instala a versão mais recente do Golang e define como global
    asdf install golang $latest_version
    asdf global golang $latest_version
    
    # Desinstala a versão antiga
    asdf uninstall golang $current_version
    
    # Exibe a versão atual do Golang
    asdf current golang 
else
    echo "Você já tem a versão mais recente do Golang"
fi

# O comando "asdf" é um gerenciador de versões que permite instalar e usar várias
# versões de diversas linguagens de programação no mesmo sistema. Neste script,
# utilizamos o asdf para instalar e selecionar a versão mais recente do Golang,
# caso ela ainda não esteja instalada. 
# Para fazer isso, primeiro comparamos o número do patch da versão atual e da
# versão mais recente. Se o número do patch da versão mais recente for maior que
# o da versão atual, então a nova versão é instalada, definida como global, e a
# versão antiga é desinstalada. Caso contrário, exibimos uma mensagem informando
# que a versão mais recente já está instalada.