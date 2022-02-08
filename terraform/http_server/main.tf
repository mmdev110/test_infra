variable "instance_type" {

}
resource "aws_instance" "default" {
  ami                    = "ami-03d79d440297083e3"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.default.id]

  user_data = <<EOF
    #! /bin/bash
    yum install -y httpd
    systemctl start httpd.service
EOF

}

resource "aws_security_group" "default" {
  name = "ec2"
  ingress = [{
    description = ""
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    //エラー出るので以下追記
    cidr_blocks      = []
    ipv6_cidr_blocks = []
    security_groups  = []
    prefix_list_ids  = []
    self             = false
  }]

  egress = [{
    description = ""
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    //エラー出るので以下追記
    ipv6_cidr_blocks = []
    security_groups  = []
    prefix_list_ids  = []
    self             = false
  }]
}

output "public_dns" {
  value = aws_instance.default.public_dns
}
