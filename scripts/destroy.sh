#!/bin/bash
set -e
echo "=== Destruyendo Infraestructura ==="
cd "$(dirname "$0")/../terraform"
terraform destroy -auto-approve
echo "Infraestructura eliminada correctamente."
