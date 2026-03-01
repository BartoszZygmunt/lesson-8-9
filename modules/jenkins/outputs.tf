data "kubernetes_secret" "jenkins" {
  metadata {
    name      = "jenkins"
    namespace = var.namespace
  }
  depends_on = [helm_release.jenkins]
}

output "namespace" { value = var.namespace }

output "admin_password" {
  value     = try(base64decode(data.kubernetes_secret.jenkins.data["jenkins-admin-password"]), null)
  sensitive = true
}
 