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

variable "example_instance_type" {
  default = "t3.micro"
}
resource "aws_instance" "example" {
  ami           = "ami-03d79d440297083e3"
  instance_type = var.example_instance_type
  tags = {
    Name = "example"
  }
  user_data = <<EOF
  #! /bin/bash
  yum install -y httpd
  systemctl start httpd.service
EOF
}

output "example_instance_id" {
  value = aws_instance.example.id

}
