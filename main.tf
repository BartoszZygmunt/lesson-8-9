module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  aws_region   = var.aws_region
  tags         = var.tags
}

module "ecr" {
  source          = "./modules/ecr"
  project_name    = var.project_name
  repository_name = "django-app"
  tags            = var.tags
}

module "eks" {
  source             = "./modules/eks"
  project_name       = var.project_name
  cluster_version    = var.cluster_version
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  tags               = var.tags
}

module "jenkins" {
  source = "./modules/jenkins"
}

module "argo_cd" {
  source          = "./modules/argo_cd"
  charts_repo_url = "https://github.com/BartoszZygmunt/lesson-8-9-charts.git"
  app_namespace   = "django"
}
 