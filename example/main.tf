terraform {
  backend "s3" {
    bucket = "mmdev-test-tf-backend"
    key    = "example/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
resource "aws_instance" "example" {
  ami           = "ami-03d79d440297083e3"
  instance_type = "t3.micro"
  tags = {
    Name = "example"
  }
  user_data = <<EOF
  #! /bin/bash
  yum install -y httpd
  systemctl start httpd.service
EOF
}