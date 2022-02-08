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

module "web_server" {
  source        = "./http_server"
  instance_type = "t3.micro"
}

output "public_dns" {
  value = module.web_server.public_dns

}
