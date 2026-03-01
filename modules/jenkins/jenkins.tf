resource "kubernetes_namespace" "this" {
  metadata { name = var.namespace }
}

resource "helm_release" "jenkins" {
  name       = "jenkins"
  namespace  = var.namespace
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  version    = var.chart_version

  values = [file("${path.module}/values.yaml")]

  wait    = true
  timeout = 1200

  depends_on = [kubernetes_namespace.this]
}
 