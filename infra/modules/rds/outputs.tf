output "db_endpoint" {
  description = "Endpoint de conexão do RDS MySQL (host:porta). Passado como variável de ambiente para a aplicação."
  value       = aws_db_instance.mysql.endpoint
}

output "db_secret_arn" {
  description = "ARN do secret gerado pelo Secrets Manager com as credenciais do banco. Referenciado na task definition ECS."
  value       = aws_db_instance.mysql.master_user_secret[0].secret_arn
}

output "db_instance_id" {
  description = "Identificador da instância RDS. Usado em alarmes CloudWatch e snapshots."
  value       = aws_db_instance.mysql.identifier
}

output "db_name" {
  description = "Nome do banco de dados criado na instância."
  value       = aws_db_instance.mysql.db_name
}
