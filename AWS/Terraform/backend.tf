terraform {
  backend "s3" {
    bucket = "icon-artifact-dev"
    key    = "terraform/icon.tfstate"
    region = "eu-west-1"
  }
}
