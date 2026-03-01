output "ecr_repository_url" {
  value = module.ecr.repository_url
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_ca" {
  value = module.eks.cluster_ca
}

output "eks_oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "eks_oidc_provider_url" {
  value = module.eks.oidc_provider_url
}

output "jenkins_admin_password" {
  value     = module.jenkins.admin_password
  sensitive = true
}

output "argocd_initial_admin_password" {
  value     = module.argo_cd.initial_admin_password
  sensitive = true
} 
 