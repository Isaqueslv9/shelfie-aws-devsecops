variable "project_name" {
  description = "Nome do projeto. Usado como prefixo em todos os recursos AWS."
  type        = string
  default     = "shelfie"
}

variable "aws_region" {
  description = "Região AWS onde todos os recursos serão provisionados."
  type        = string
  default     = "us-east-1"
}

variable "aws_account_id" {
  description = "ID da conta AWS. Usado na construção de ARNs para IAM e Secrets Manager."
  type        = string
}

variable "vpc_cidr" {
  description = "Bloco CIDR da VPC principal."
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Lista de Availability Zones para criação de subnets. Mínimo 2 para alta disponibilidade."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "db_instance_class" {
  description = "Classe da instância RDS MySQL. Use db.t3.micro para staging, db.t3.small ou maior para produção."
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Nome do banco de dados criado na instância RDS."
  type        = string
  default     = "shelfie"
}

variable "db_username" {
  description = "Usuário administrador do banco de dados."
  type        = string
  default     = "admin"
}

variable "db_allocated_storage" {
  description = "Armazenamento alocado para o RDS em GB."
  type        = number
  default     = 20
}

variable "db_multi_az" {
  description = "Habilita Multi-AZ no RDS para alta disponibilidade. Recomendado apenas em produção (custo dobrado)."
  type        = bool
  default     = false
}

variable "db_backup_retention_days" {
  description = "Quantos dias de backups automáticos manter. Mínimo recomendado: 7."
  type        = number
  default     = 7
}


variable "task_cpu" {
  description = "CPU alocada para a ECS Task em unidades Fargate. Valores válidos: 256, 512, 1024, 2048, 4096."
  type        = string
  default     = "512"
}

variable "task_memory" {
  description = "Memória alocada para a ECS Task em MB. Deve ser compatível com o task_cpu escolhido."
  type        = string
  default     = "1024"
}

variable "service_desired_count" {
  description = "Número de tasks ECS em execução simultânea."
  type        = number
  default     = 1
}


variable "acm_certificate_arn" {
  description = "ARN do certificado ACM para TLS no ALB. Deve estar na mesma região do ALB."
  type        = string
  default     = ""
}

variable "sns_alert_arn" {
  description = "ARN do tópico SNS para receber alarmes do CloudWatch (email, Slack via Lambda, etc). Deixar vazio para desabilitar alertas."
  type        = string
  default     = ""
}
