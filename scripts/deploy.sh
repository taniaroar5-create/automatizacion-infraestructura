#!/bin/bash
set -e
echo "=== Desplegando Infraestructura ==="
cd "$(dirname "$0")/../terraform"

echo "[1/5] Inicializando Terraform..."
terraform init

echo "[2/5] Formateando código..."
terraform fmt

echo "[3/5] Validando configuración..."
terraform validate

echo "[4/5] Generando plan de ejecución..."
terraform plan

echo "[5/5] Aplicando cambios..."
terraform apply -auto-approve

echo "Infraestructura desplegada con éxito."
