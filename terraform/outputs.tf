output "network_id" {
  value       = docker_network.private_network.id
  description = "ID de la red de Docker creada"
}

output "web_server_ip" {
  value       = var.web_ip
  description = "Dirección IP del servidor Web"
}

output "app_server_ip" {
  value       = var.app_ip
  description = "Dirección IP del servidor de Aplicaciones"
}

output "db_server_ip" {
  value       = var.db_ip
  description = "Dirección IP del servidor de Base de Datos"
}
