variable "project_name" {
  description = "Nome do projeto. Usado como prefixo nos recursos RDS."
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs das subnets privadas para o DB subnet group. O banco nunca fica em subnet pública."
  type        = list(string)
}

variable "rds_sg_id" {
  description = "ID do Security Group do RDS. Deve permitir entrada apenas das ECS Tasks."
  type        = string
}

variable "db_instance_class" {
  description = "Classe da instância RDS MySQL."
  type        = string
}

variable "db_name" {
  description = "Nome do banco de dados criado na instância."
  type        = string
}

variable "db_username" {
  description = "Usuário administrador do banco de dados."
  type        = string
}

variable "db_allocated_storage" {
  description = "Armazenamento alocado em GB."
  type        = number
  default     = 20
}

variable "db_multi_az" {
  description = "Habilita Multi-AZ. Recomendado somente em produção."
  type        = bool
  default     = false
}
