# =============================================================================
# ECR — copie esses valores como secrets no GitHub Actions
# =============================================================================

output "ecr_app_repository_url" {
  description = "URL do repositório ECR da aplicação PHP. Adicionar como secret ECR_REGISTRY e ECR_REPOSITORY_APP no GitHub."
  value       = module.ecr.app_repository_url
}

output "ecr_nginx_repository_url" {
  description = "URL do repositório ECR do Nginx. Adicionar como secret ECR_REPOSITORY_NGINX no GitHub."
  value       = module.ecr.nginx_repository_url
}

# =============================================================================
# ECS — copie esses valores como secrets no GitHub Actions
# =============================================================================

output "ecs_cluster_name" {
  description = "Nome do cluster ECS. Adicionar como secret ECS_CLUSTER no GitHub."
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "Nome do serviço ECS. Adicionar como secret ECS_SERVICE no GitHub."
  value       = module.ecs.service_name
}

output "ecs_task_definition_arn" {
  description = "ARN da task definition criada pelo Terraform."
  value       = module.ecs.task_definition_arn
}

# =============================================================================
# ALB — use para acessar a aplicação e configurar DNS
# =============================================================================

output "alb_dns_name" {
  description = "DNS público do ALB. Configure como CNAME no seu domínio ou acesse direto no browser."
  value       = module.ecs.alb_dns_name
}

output "alb_zone_id" {
  description = "Zone ID do ALB. Necessário para criar registro Alias no Route 53."
  value       = module.ecs.alb_zone_id
}

# =============================================================================
# RDS
# =============================================================================

output "db_endpoint" {
  description = "Endpoint de conexão do banco MySQL (host:porta)."
  value       = module.rds.db_endpoint
}

output "db_secret_arn" {
  description = "ARN do secret com as credenciais do banco no Secrets Manager."
  value       = module.rds.db_secret_arn
  sensitive   = true
}

# =============================================================================
# REDE
# =============================================================================

output "vpc_id" {
  description = "ID da VPC criada."
  value       = module.network.vpc_id
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas (ECS + RDS)."
  value       = module.network.private_subnet_ids
}

output "public_subnet_ids" {
  description = "IDs das subnets públicas (ALB)."
  value       = module.network.public_subnet_ids
}
