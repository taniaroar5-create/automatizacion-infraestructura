# Automatización de Infraestructura II - Implementación de una infraestructura de red mediante Infraestructura 
como Código

* **Institución:** Universidad Tecnológica del Centro de Veracruz (UTCV)
* **Campus:** Cuitláhuac
* **Programa Educativo:** Ingeniería en Redes Inteligentes y Ciberseguridad
* **Grupo:** 10A IRIC
* **Materia:** Automatización de Infraestructura II
* **Profesor:** Michel Orozco Carrera
* **Presenta:** Tania Rojas Arévalo

---

## 1. Introducción
La automatización de la infraestructura y el concepto de Infraestructura como Código (IaC) permiten gestionar y aprovisionar centros de datos mediante archivos de definición legibles por máquina, en lugar de configuraciones físicas o manuales repetitivas. Esta práctica demuestra el despliegue automatizado de un entorno contenerizado interconectado utilizando herramientas estándar de la industria como Terraform, Docker y Git.

## 2. Descripción del problema
Configurar manualmente redes, contenedores e IPs de forma repetitiva para entornos de desarrollo, pruebas o producción es una tarea propensa a errores humanos, inconsistencias y pérdida de tiempo. El problema radica en cómo estandarizar el aprovisionamiento de una arquitectura multicapa (servidor web, de aplicaciones y de base de datos) asegurando que el entorno pueda destruirse y reconstruirse de manera idéntica y automatizada en cualquier momento.

## 3. Arquitectura
La infraestructura desplegada consta de los siguientes componentes interconectados:
* **Red Docker:** Una red privada tipo bridge llamada `red_empresa_prod` con subred `10.10.0.0/24` y puerta de enlace `10.10.0.1`.
* **Imágenes Docker:** 
  * `nginx:alpine` (para el servidor web).
  * `alpine:latest` (para los servidores de aplicación y base de datos).
* **Contenedores:**
  * **`servidor-web`**: IP `10.10.0.10`, expone el puerto interno `80` hacia el puerto externo `8080` del anfitrión.
  * **`servidor-app`**: IP `10.10.0.20`, mantiene un proceso activo (`tail -f /dev/null`.
  * **`servidor-db`**: IP `10.10.0.30`, mantiene un proceso activo (`tail -f /dev/null`).

## 4. Herramientas utilizadas
* **Terraform (v1.16.4):** Herramienta principal de Infraestructura como Código (IaC) para aprovisionar los recursos.
* **Docker (v29.8.1) y Docker Compose:** Plataforma de contenerización para ejecutar los servicios.
* **Git (v2.47.3):** Sistema de control de versiones para el proyecto.
* **Bash Shell:** Automatización de comandos mediante scripts ejecutables (`deploy.sh`, `verify.sh`, `destroy.sh`).

## 5. Descripción de DevOps
Desde la perspectiva de DevOps, esta práctica promueve la integración continua y la repetibilidad de los entornos. Al tratar la infraestructura como código, se unifican los flujos de desarrollo y operaciones, permitiendo que los cambios en la arquitectura pasen por validación de código (`terraform validate`), pruebas automatizadas de conectividad y despliegues sin intervención manual directa.

## 6. Ventajas de la automatización
Reconstruir la infraestructura a partir del código frente a una configuración manual aporta:
* **Reproducibilidad:** Capacidad de levantar el entorno exacto las veces que sea necesario ejecutando comandos automatizados.
* **Consistencia:** Elimina discrepancias humanas entre entornos de pruebas y producción.
* **Eficiencia y rapidez:** Creación y destrucción de múltiples recursos interconectados (redes, imágenes, contenedores) en segundos.

## 7. Descripción del código Terraform
El proyecto se divide en los siguientes archivos clave dentro de la carpeta `terraform/`:
* **`variables.tf`**: Define las variables de entrada del sistema (nombre de red, subred CIDR e IPs de los servidores).
* **`terraform.tfvars`**: Asigna los valores concretos a las variables (ej. `red_empresa_prod`, `10.10.0.0/24`, etc.).
* **`main.tf`**: Contiene la declaración del proveedor de Docker (`kreuzwerker/docker`), la creación de la red privada y la configuración de los tres contenedores y sus respectivas imágenes.
* **`outputs.tf`**: Expone las salidas relevantes al finalizar el despliegue, como las direcciones IP de los servidores y el ID de la red.

## 8. Descripción de los scripts
En la carpeta `scripts/` se encuentran los automatizadores en Bash:
* **`desploy.sh`**: Automatiza la secuencia de inicialización (`terraform init`), formateo (`terraform fmt`), validación (`terraform validate`), generación de plan (`terraform plan`) y aplicación automática de cambios (`terraform apply -auto-approve`).
* **`verify.sh`**: Comprueba el estado de la infraestructura validando el código IaC, listando contenedores activos en Docker, filtrando redes, ejecutando una prueba de conectividad (`ping`) entre contenedores y verificando el servicio HTTP local mediante `curl`.
* **`destroy.sh`**: Ejecuta la destrucción completa y automatizada de todos los recursos gestionados por Terraform (`terraform destroy -auto-approve`).

## 9. Procedimiento de implementación
1. Inicializar el repositorio Git y estructurar las carpetas del proyecto (`docker`, `docs`, `evidencias`, `scripts`, `terraform`).
2. Configurar los archivos de Terraform (`main.tf`, `variables.tf`, etc.).
3. Ejecutar el script de despliegue o la secuencia manual:
   ```bash
   terraform init
   terraform fmt
   terraform validate
   terraform plan
   terraform apply

## 10. Procedimiento de verificación
Para comprobar el funcionamiento correcto del entorno, se ejecutaron las siguientes pruebas:

Verificación de sintaxis: terraform validate ("Success! The configuration is valid.").

Estado de contenedores: docker ps --filter "name=servidor-".

Verificación de redes: docker network ls para confirmar la existencia de red_empresa_prod.

Conectividad interna: docker exec -it servidor-app ping -c 4 10.10.0.10.

Respuesta HTTP: curl http://localhost:8080 para comprobar la página de bienvenida de Nginx.

## 11. Resultados
Se implementaron exitosamente 6 recursos administrados por Terraform: 1 red Docker, 2 imágenes Docker y 3 contenedores interconectados.

Se comprobó la comunicación interna mediante direccionamiento IP privado (10.10.0.0/24) y la exposición correcta de puertos hacia el host anfitrión en el puerto 8080.

Se validó el ciclo de vida completo de la infraestructura mediante los comandos terraform apply y terraform destroy, demostrando una alta reproductibilidad.

## 12. Concluciones
La implementación de Infraestructura como Código (IaC) mediante Terraform y Docker optimiza de manera drástica el despliegue de arquitecturas de red y servicios. Se demostró que el uso de scripts de automatización reduce la intervención manual, minimiza errores de configuración y garantiza la portabilidad y escalabilidad de los entornos tecnológicos en proyectos de redes y ciberseguridad.


