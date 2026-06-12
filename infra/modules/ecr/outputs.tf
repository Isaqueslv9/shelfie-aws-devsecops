output "app_repository_url" {
  description = "URL completa do repositório ECR da aplicação PHP. Usada no docker push e na task definition"
  value       = aws_ecr_repository.app.repository_url
}

output "nginx_repository_url" {
  description = "URL completa do repositório ECR do Nginx. Usada no docker push e na task definition"
  value       = aws_ecr_repository.nginx.repository_url
}

output "app_repository_arn" {
  description = "ARN do repositório ECR da aplicação"
  value       = aws_ecr_repository.app.arn
}

output "nginx_repository_arn" {
  description = "ARN do repositório ECR do Nginx"
  value       = aws_ecr_repository.nginx.arn
}
