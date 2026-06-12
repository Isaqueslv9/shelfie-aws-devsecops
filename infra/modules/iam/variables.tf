variable "project_name" {
  description = "Nome do projeto. Usado como prefixo nos recursos IAM."
  type        = string
}

variable "aws_region" {
  description = "Região AWS. Usado na construção do ARN do Secrets Manager."
  type        = string
}

variable "aws_account_id" {
  description = "ID da conta AWS. Usado na construção do ARN do Secrets Manager."
  type        = string
}
