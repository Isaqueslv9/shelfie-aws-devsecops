module "network" {
  source = "./modules/network"

  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
}

module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
}

module "iam" {
  source = "./modules/iam"

  project_name   = var.project_name
  aws_region     = var.aws_region
  aws_account_id = var.aws_account_id
}

module "rds" {
  source = "./modules/rds"

  project_name             = var.project_name
  private_subnet_ids       = module.network.private_subnet_ids
  rds_sg_id                = module.network.rds_sg_id
  db_instance_class        = var.db_instance_class
  db_name                  = var.db_name
  db_username              = var.db_username
  db_allocated_storage     = var.db_allocated_storage
  db_multi_az              = var.db_multi_az
  db_backup_retention_days = var.db_backup_retention_days
}

module "ecs" {
  source = "./modules/ecs"

  project_name          = var.project_name
  aws_region            = var.aws_region
  task_cpu              = var.task_cpu
  task_memory           = var.task_memory
  service_desired_count = var.service_desired_count
  execution_role_arn    = module.iam.execution_role_arn
  task_role_arn         = module.iam.task_role_arn
  ecr_app_url           = module.ecr.app_repository_url
  ecr_nginx_url         = module.ecr.nginx_repository_url
  private_subnet_ids    = module.network.private_subnet_ids
  public_subnet_ids     = module.network.public_subnet_ids
  ecs_tasks_sg_id       = module.network.ecs_tasks_sg_id
  alb_sg_id             = module.network.alb_sg_id
  db_secret_arn         = module.rds.db_secret_arn
  acm_certificate_arn   = var.acm_certificate_arn
  sns_alert_arn         = var.sns_alert_arn
}
