output "vpc_id" {
  description = "ID da VPC criada."
  value       = aws_vpc.shelfie_vpc.id
}

output "public_subnet_ids" {
  description = "IDs das subnets públicas (usadas pelo ALB)."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas (usadas pelo ECS e RDS)."
  value       = aws_subnet.private[*].id
}

output "alb_sg_id" {
  description = "ID do Security Group do ALB."
  value       = aws_security_group.alb.id
}

output "ecs_tasks_sg_id" {
  description = "ID do Security Group das ECS Tasks."
  value       = aws_security_group.ecs_tasks.id
}

output "rds_sg_id" {
  description = "ID do Security Group do RDS."
  value       = aws_security_group.rds.id
}
