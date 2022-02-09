resource "aws_lb" "example" {
  name                       = "example"
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 60
  enable_deletion_protection = true
  subnets = [
    aws_subnet.public_0.id,
    aws_subnet.public_1.id,
  ]
  access_logs {
    bucket  = aws_s3_bucket.alb_log.id
    enabled = true
  }
  security_group = [
    module.http_sg.security_group.id,
    module.https_sg.security_group.id,
    module.http_redirect_sg.security_group.id,
  ]
}

output "alb_dns_name" {
  value = aws_lb.example.dns_name
}

module "http_sg" {
  source      = "./security_group"
  name        = "http-sg"
  vpc_id      = aws_vpc.example.id
  port        = 80
  cidr_blocks = ["0.0.0.0/0"]
}

module "https_sg" {
  source      = "./security_group"
  name        = "https-sg"
  vpc_id      = aws_vpc.example.id
  port        = 443
  cidr_blocks = ["0.0.0.0/0"]
}
module "http_redirect_sg" {
  source      = "./security_group"
  name        = "http-redirect-sg"
  vpc_id      = aws_vpc.example.id
  port        = 8080
  cidr_blocks = ["0.0.0.0/0"]
}

//リスナー
//どのポートのリクエストを受け付けるのか
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed_response"
    fixedfixed_response {
      content_type = "text/plain"
      message_body = "これはHTTPです"
      status_code  = "200"
    }
  }
}
