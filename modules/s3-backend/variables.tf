variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "project_name" {
  type    = string
  default = "lesson-8-9"
}

# S3 bucket name musi być globalnie unikalny — daj coś swojego
variable "name_suffix" {
  type    = string
  default = "laresistancepl"
}
 