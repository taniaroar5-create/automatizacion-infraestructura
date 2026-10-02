terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {}

# 1. Red Privada 10.10.0.0/24
resource "docker_network" "private_network" {
  name   = var.network_name
  driver = "bridge"
  ipam_config {
    subnet = var.network_subnet
  }
}

# Imágenes de Docker
resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = false
}

resource "docker_image" "alpine" {
  name         = "alpine:latest"
  keep_locally = false
}

# 2. Servidor Web (10.10.0.10)
resource "docker_container" "web_server" {
  name  = "servidor-web"
  image = docker_image.nginx.image_id

  networks_advanced {
    name         = docker_network.private_network.name
    ipv4_address = var.web_ip
  }

  ports {
    internal = 80
    external = 8080
  }
}

# 3. Servidor de Aplicaciones (10.10.0.20)
resource "docker_container" "app_server" {
  name    = "servidor-app"
  image   = docker_image.alpine.image_id
  command = ["tail", "-f", "/dev/null"]

  networks_advanced {
    name         = docker_network.private_network.name
    ipv4_address = var.app_ip
  }
}

# 4. Servidor de Base de Datos (10.10.0.30)
resource "docker_container" "db_server" {
  name    = "servidor-db"
  image   = docker_image.alpine.image_id
  command = ["tail", "-f", "/dev/null"]

  networks_advanced {
    name         = docker_network.private_network.name
    ipv4_address = var.db_ip
  }
}
