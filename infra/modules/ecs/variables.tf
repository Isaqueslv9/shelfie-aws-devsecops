variable "project_name" {
  description = "Nome do projeto. Usado como prefixo nos recursos ECS."
  type        = string
}

variable "aws_region" {
  description = "Região AWS. Usado na configuração de logs do CloudWatch."
  type        = string
}

variable "task_cpu" {
  description = "CPU da ECS Task em unidades Fargate (256, 512, 1024, 2048, 4096)."
  type        = string
}

variable "task_memory" {
  description = "Memória da ECS Task em MB. Deve ser compatível com task_cpu."
  type        = string
}

variable "service_desired_count" {
  description = "Número de tasks ECS em execução simultânea."
  type        = number
  default     = 1
}

variable "execution_role_arn" {
  description = "ARN da Task Execution Role (pull de imagem ECR, escrita de logs)."
  type        = string
}

variable "task_role_arn" {
  description = "ARN da Task Role (permissões da aplicação em runtime)."
  type        = string
}

variable "ecr_app_url" {
  description = "URL do repositório ECR da aplicação PHP."
  type        = string
}

variable "ecr_nginx_url" {
  description = "URL do repositório ECR do Nginx."
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs das subnets privadas onde as tasks Fargate serão executadas."
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "IDs das subnets públicas para o Application Load Balancer."
  type        = list(string)
}

variable "ecs_tasks_sg_id" {
  description = "ID do Security Group das ECS Tasks."
  type        = string
}

variable "alb_sg_id" {
  description = "ID do Security Group do ALB."
  type        = string
}

variable "db_secret_arn" {
  description = "ARN do secret no Secrets Manager com as credenciais do banco (gerado pelo RDS com manage_master_user_password)."
  type        = string
}

variable "acm_certificate_arn" {
  description = "ARN do certificado ACM para HTTPS no ALB. Deixar vazio para usar somente HTTP (não recomendado em produção)."
  type        = string
  default     = ""
}

variable "sns_alert_arn" {
  description = "ARN do tópico SNS para alarmes CloudWatch. Deixar vazio para desabilitar alertas."
  type        = string
  default     = ""
}
