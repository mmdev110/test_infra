terraform {
  backend "s3" {
    bucket = "mmdev-test-tf-backend"
    key    = "example/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
