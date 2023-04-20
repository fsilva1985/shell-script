#!/bin/bash

# Solicita ao usuário que informe o ambiente de destino
read -p "Qual ambiente gostaria de usar? [dev/st]: " environment

# Verifica o ambiente informado e define o host correspondente
if [ "$environment" = "dev" ]; then
    host="db-cluster.dev.elven.works"
elif [ "$environment" = "st" ]; then
    host="db-cluster.st.elven.works"
else
    # Se o ambiente informado não for "dev" nem "st", exibe uma mensagem de erro e sai
    echo "Ambiente inválido"
    exit 1
fi

# Solicita ao usuário o nome do banco de dados a ser importado
read -p "Qual o nome do banco de dados que gostaria de importar? " dbname

# Realiza o dump do banco de dados remoto
echo "Dumping $dbname..."
PGPASSWORD=3nes2sg3iLP7oFbN95P1 pg_dump --host "$host" --username "felipe_silva" --clean -Fc $dbname --file=/tmp/$dbname.dump

# Remove o banco de dados local e cria um novo banco de dados com o mesmo nome
echo "Recriando banco de dados local..."
psql postgres://postgres:postgres@localhost:5432 -c "drop database $dbname;"
psql postgres://postgres:postgres@localhost:5432 -c "create database $dbname;"

# Restaura o dump do banco de dados remoto no banco de dados local
echo "Restaurando $dbname..."
PGPASSWORD=postgres pg_restore -h localhost -d $dbname /tmp/$dbname.dump -U postgres

# Exibe uma mensagem de conclusão
echo "Done"