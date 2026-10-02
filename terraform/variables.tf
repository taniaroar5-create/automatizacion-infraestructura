variable "network_name" {
  description = "Nombre de la red Docker"
  type        = string
  default     = "red_empresa"
}

variable "network_subnet" {
  description = "Subred CIDR para la infraestructura"
  type        = string
  default     = "10.10.0.0/24"
}

variable "web_ip" {
  description = "IP del Servidor Web"
  type        = string
  default     = "10.10.0.10"
}

variable "app_ip" {
  description = "IP del Servidor de Aplicaciones"
  type        = string
  default     = "10.10.0.20"
}

variable "db_ip" {
  description = "IP del Servidor de Base de Datos"
  type        = string
  default     = "10.10.0.30"
}
