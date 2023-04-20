#!/bin/bash

# Verifica se a porta foi fornecida como argumento
if [ -z "$1" ]; then
  echo "Usage: $0 port_number" # Caso a porta não seja fornecida, exibe uma mensagem de uso correto e encerra o script
  exit 1
fi

# Encontra o PID que está usando a porta
pid=$(lsof -ti tcp:$1) # Busca o PID do processo que está escutando a porta fornecida como argumento

# Verifica se o PID foi encontrado
if [ -z "$pid" ]; then
  echo "No process found using port $1" # Caso não encontre nenhum processo escutando na porta fornecida, exibe uma mensagem de erro e encerra o script
  exit 1
fi

# Mata o processo
kill -9 $pid # Mata o processo utilizando o sinal SIGKILL

echo "Process with PID $pid killed successfully" # Exibe uma mensagem de sucesso informando o PID do processo que foi morto
