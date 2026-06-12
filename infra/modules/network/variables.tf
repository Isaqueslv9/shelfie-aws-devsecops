variable "project_name" {
  description = "Nome do projeto. Usado como prefixo nos recursos de rede."
  type        = string
}

variable "vpc_cidr" {
  description = "Bloco CIDR da VPC principal."
  type        = string
}

variable "availability_zones" {
  description = "Lista de AZs para criação das subnets públicas e privadas. Mínimo 2."
  type        = list(string)
}
