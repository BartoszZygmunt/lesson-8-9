data "kubernetes_secret" "initial_admin" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = var.namespace
  }
  depends_on = [helm_release.argocd]
}

output "namespace" { value = var.namespace }

output "initial_admin_password" {
  value     = try(base64decode(data.kubernetes_secret.initial_admin.data["password"]), null)
  sensitive = true
}
 