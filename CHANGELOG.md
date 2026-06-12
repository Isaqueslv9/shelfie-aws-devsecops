# Changelog

---

## [1.0.0] — 2026-06-12 — Release: Infraestrutura AWS + CI/CD Completo

### Adicionado

#### Pipeline CI/CD (GitHub Actions)
- `ci.yml`: pipeline na branch `develop` com GitLeaks, Docker build, Trivy, Semgrep e SonarCloud, seguido de `terraform fmt`, `validate` e `plan`
- `cd.yml`: pipeline na branch `main` com `terraform apply` automático + build/push de imagens para ECR + deploy via `aws ecs update-service`
- Imagens Docker tagueadas com `github.sha` em vez de `:latest` no CD
- `fetch-depth: 0` no checkout do CI para GitLeaks escanear histórico completo

#### IaC — Módulos Terraform
- **Módulo `network`**: VPC `10.0.0.0/16`, 2 subnets públicas, 2 subnets privadas, Internet Gateway, Route Table pública, Security Groups para ALB, ECS Tasks e RDS
- **Módulo `ecr`**: Repositórios `shelfie-app` e `shelfie-nginx` com `image_tag_mutability = IMMUTABLE`, scan on push habilitado e lifecycle policy (max 10 imagens)
- **Módulo `iam`**: Role `ecs-task-execution` com `AmazonECSTaskExecutionRolePolicy` + policy inline para `secretsmanager:GetSecretValue` em `shelfie/*`. Role `ecs-task` para permissões de runtime
- **Módulo `rds`**: Instância MySQL 8.0 `db.t3.micro`, `storage_encrypted = true`, `manage_master_user_password = true` (credencial gerenciada automaticamente pelo Secrets Manager), `deletion_protection = false` (custo de portfólio)
- **Módulo `ecs`**: Cluster Fargate com Container Insights, Task Definition com 2 containers (nginx + php-fpm), secrets injection do Secrets Manager, CloudWatch Log Groups, ALB com listener HTTP (condicional HTTPS via `count`), CloudWatch Alarms para `service_down` e `alb_5xx`
- Backend Terraform: S3 (`shelfie-terraform-state`) + DynamoDB (`shelfie-terraform-locks`) para state lock

#### Segurança e DevSecOps
- `.pre-commit-config.yaml`: hooks `terraform_fmt`, `terraform_validate`, `terraform_tflint`, `terraform_checkov`, `check-yaml`
- `.tflint.hcl`: plugin AWS habilitado
- `sonar-project.properties`: integração SonarCloud configurada
- Supressões inline Semgrep documentadas (`# nosemgrep:`) nos recursos Terraform onde o comportamento é intencional para ambiente de portfólio

#### Infraestrutura Local
- `docker-compose.yml` com stack completa: MySQL 9.7, PHP 8.2-FPM Alpine, Nginx 1.31-Alpine
- Stack de observabilidade local: Prometheus `v2.52.0`, Grafana `10.4.0`, nginx-prometheus-exporter
- Healthchecks configurados nos containers MySQL e Nginx

### Corrigido

#### Fase 0 — Correções de Red Flags
- Trivy Action fixado em `@v0.20.0` (era referência flutuante)
- Nginx fixado em `nginx:1.31-alpine` (era `:latest`)
- `fastcgi_pass` corrigido de `127.0.0.1:9000` para `app:9000` no nginx.conf
- `app/.dockerignore` criado para reduzir contexto de build

#### Módulos Terraform
- `network/main.tf`: corrigido `var.cidr_block` → `var.vpc_cidr`, adicionado `.id` em 3 referências de VPC, adicionado Internet Gateway e Route Tables (causa do erro `InvalidSubnet: VPC has no internet gateway`)
- `ecr/main.tf`: corrigido atributo `repository` nas lifecycle policies (`aws_ecr_repository.app` → `aws_ecr_repository.app.name`)
- `ecs/main.tf`: `internal = false` no ALB, ECS service movido para subnets públicas com `assign_public_ip = true` (sem NAT Gateway por custo), `aws_lb_listener.https` com `count` condicional, `alarm_actions` condicional para SNS vazio
- `rds/main.tf`: substituídos valores hardcoded por variáveis, `manage_master_user_password = true`

#### Aplicação PHP
- `meus_livros.php`: `LIMIT` e `OFFSET` movidos para parâmetros PDO (`$params[]`) — eliminado SQL injection via taint de `$_GET['page']`

### Removido
- `infra.yml` (pipeline de infra separado): absorvido pelo `ci.yml` e `cd.yml`
- `deploy.yml`: substituído por `cd.yml` com fluxo unificado Terraform + ECS
- 5 diretórios `.terraform/` nos módulos (provider AWS duplicado ~870MB cada, ~5GB total)
- Variável `db_backup_retention_days` (removida da raiz e do módulo RDS — valor fixado em 0 pelo linter)
- NAT Gateway (removido por custo — ECS tasks nas subnets públicas)

### Alterado
- `.gitignore`: reorganizado em seções, adicionados `**/.terraform/`, `.venv/`, `__pycache__/`, `.idea/`, `.vscode/`
- `infra/variables.tf`: removida `db_backup_retention_days`, `environment` mantido para referência
- `terraform.tfvars.example`: atualizado para refletir variáveis atuais
- Versão mínima do Terraform nos módulos: `>= 1.13.4` → `>= 1.8.0`
- Provider AWS: `version = "6.47.0"` → `version = "~> 6.47.0"`

---

## [0.2.0] — 2026-05 — Containerização e GitHub Actions Inicial

### Adicionado
- Docker Compose com MySQL, PHP-FPM e Nginx
- `app/dockerfile` multi-serviço
- Pipeline inicial CI com Trivy e Semgrep (`develop`)
- Pipeline inicial CD com push ECR e update ECS (`main`)
- GitLeaks integrado nos dois pipelines

---

## [0.1.0] — 2026-04 — MVP da Aplicação PHP

### Adicionado
- CRUD de livros com PHP + MySQL puro
- Sistema de login com sessão PHP
- Filtro e busca com PDO prepared statements
- Paginação na listagem de livros
- Sistema de favoritos
- Estatísticas de leitura
- CSS responsivo
