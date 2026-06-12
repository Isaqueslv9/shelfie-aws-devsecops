output "execution_role_arn" {
  description = "ARN da Task Execution Role. Passada para o ECS para pull de imagem ECR e escrita de logs no CloudWatch."
  value       = aws_iam_role.ecs_task_execution.arn
}

output "task_role_arn" {
  description = "ARN da Task Role. Permissões que os containers têm em tempo de execução."
  value       = aws_iam_role.ecs_task.arn
}
