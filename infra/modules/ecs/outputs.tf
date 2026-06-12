output "cluster_name" {
  description = "Nome do cluster ECS. Usado no deploy.yml para referenciar o cluster."
  value       = aws_ecs_cluster.main.name
}

output "cluster_arn" {
  description = "ARN do cluster ECS."
  value       = aws_ecs_cluster.main.arn
}

output "service_name" {
  description = "Nome do serviço ECS. Usado no deploy.yml para forçar novo deploy."
  value       = aws_ecs_service.main.name
}

output "task_definition_arn" {
  description = "ARN da task definition ativa no momento do apply."
  value       = aws_ecs_task_definition.app.arn
}

output "alb_dns_name" {
  description = "DNS público do ALB. Use para acessar a aplicação ou configurar o CNAME no seu domínio."
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "Zone ID do ALB. Necessário para criar registros do tipo Alias no Route 53."
  value       = aws_lb.main.zone_id
}
