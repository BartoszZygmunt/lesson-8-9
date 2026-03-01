terraform {
  backend "s3" {
    bucket         = "lesson-8-9-tfstate-bartoszzygmunt"
    key            = "lesson-8-9/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "lesson-8-9-tflock-bartoszzygmunt"
    encrypt        = true
  }
}
 