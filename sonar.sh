#!/bin/bash

# Executa a ferramenta de segurança "gosec" e formata a saída no formato "sonarqube", gravando em "report.json".
# O comando "./..." indica que deve ser analisado todo o código fonte no diretório atual e subdiretórios.
gosec -fmt=sonarqube -out report.json ./...

# Executa todos os testes no código fonte no diretório atual e subdiretórios usando o comando "go test",
# com um tempo limite de 5 segundos e coletando informações de cobertura de código com "-cover" e gravando em "cover.out".
go test ./... -timeout 5s -cover -coverprofile=cover.out

# Executa o scanner de código "SonarQube" usando o comando "~/sonar-scanner/bin/sonar-scanner".
# Este comando pressupõe que o scanner de código SonarQube esteja instalado no diretório "~/sonar-scanner".
~/sonar-scanner/bin/sonar-scanner -Dsonar.login=sqa_a342e4fd9ac94c919a7f8d2dc596f5bdeba71a6b