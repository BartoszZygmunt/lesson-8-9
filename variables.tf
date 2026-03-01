variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "project_name" {
  type    = string
  default = "lesson-8-9"
}

variable "cluster_version" {
  type    = string
  default = "1.29"
}

variable "tags" {
  type = map(string)
  default = {
    Project = "lesson-8-9"
    Owner   = "bartoszzygmunt"
  }
} 
 