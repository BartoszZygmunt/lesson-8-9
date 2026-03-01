variable "project_name" { type = string }
variable "aws_region" { type = string }
variable "tags" { type = map(string) }

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
 