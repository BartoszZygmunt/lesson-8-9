resource "kubernetes_namespace" "this" {
  metadata { name = var.namespace }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = var.namespace
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.chart_version

  values = [file("${path.module}/values.yaml")]

  wait    = true
  timeout = 1200

  depends_on = [kubernetes_namespace.this]
}
 