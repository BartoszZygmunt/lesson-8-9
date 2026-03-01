variable "namespace" {
  type    = string
  default = "argocd"
}

variable "chart_version" {
  type    = string
  default = "7.6.12"
}

variable "charts_repo_url" {
  type    = string
  default = "https://github.com/BartoszZygmunt/lesson-8-9-charts.git"
}

variable "app_namespace" {
  type    = string
  default = "django"
}
 