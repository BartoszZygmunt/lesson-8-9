resource "kubernetes_namespace" "app" {
  metadata { name = var.app_namespace }
}

resource "kubernetes_manifest" "django_app" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "django-app"
      namespace = var.namespace
    }
    spec = {
      project = "default"
      source = {
        repoURL        = var.charts_repo_url
        targetRevision = "main"
        path           = "charts/django-app"
        helm = {
          valueFiles = ["values.yaml"]
        }
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = var.app_namespace
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
        syncOptions = [
          "CreateNamespace=true"
        ]
      }
    }
  }

  depends_on = [helm_release.argocd, kubernetes_namespace.app]
}
 