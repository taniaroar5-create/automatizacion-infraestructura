#!/bin/bash
echo "=== Verificando Infraestructura ==="
cd "$(dirname "$0")/../terraform"

echo "--> Estado del código IaC:"
terraform validate

echo -e "\n--> Contenedores activos:"
docker ps --filter "name=servidor-"

echo -e "\n--> Redes de Docker:"
docker network ls | grep red_empresa

echo -e "\n--> Comprobando conectividad (Ping APP a WEB):"
docker exec -it servidor-app ping -c 2 10.10.0.10 || echo "Error de conectividad"

echo -e "\n--> Comprobando servicio HTTP local:"
curl -I http://localhost:8080 || echo "Servicio no disponible"
