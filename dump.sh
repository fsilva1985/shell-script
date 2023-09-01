#!/bin/bash

source /home/felipe/shellScript/.env

host=$HOST_ST
port=$PORT_ST

# Solicita ao usuário o nome do banco de dados a ser importado
read -p "Qual o nome do banco de dados que gostaria de importar? " dbname

# Realiza o dump do banco de dados remoto
echo "Dumping $dbname..."
PGPASSWORD=$PASSWORD pg_dump --host "$host" --port "${port}" --username "${USERNAME}" --clean -Fc $dbname --file=/tmp/$dbname.dump

# Remove o banco de dados local e cria um novo banco de dados com o mesmo nome
echo "Recriando banco de dados local..."
psql postgres://postgres:postgres@localhost:5432 -c "drop database $dbname;"
psql postgres://postgres:postgres@localhost:5432 -c "create database $dbname;"

# Restaura o dump do banco de dados remoto no banco de dados local
echo "Restaurando $dbname..."
PGPASSWORD=postgres pg_restore -h localhost -d $dbname /tmp/$dbname.dump -U postgres

# Exibe uma mensagem de conclusão
echo "Done"