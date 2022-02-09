//ホストゾーンは既存のものを使用する
//freenomへのnameserver登録が面倒なため
data "aws_route53_zone" "example" {
  name = "mmdev110.tk"
}

resource "aws_route53_record" "example" {
  zone_id = data.aws_route53_zone.example.zone_id
  name    = data.aws_route53_zone.example.name
  type    = "A"
  alias {
    name                   = aws_lb.example.dns_name
    zone_id                = aws_lb.example.zone_id
    evaluate_target_health = true
  }
}
//証明書DNS検証用のCNAMEレコード
resource "aws_route53_record" "example_certificate" {
  zone_id = data.aws_route53_zone.example.zone_id
  //https://qiita.com/fullsat_/items/a2843ec5fe36484f8e19
  name    = tolist(aws_acm_certificate.example.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.example.domain_validation_options)[0].resource_record_type
  records = [tolist(aws_acm_certificate.example.domain_validation_options)[0].resource_record_value]
  ttl     = 60
}

output "domain_name" {
  value = aws_route53_record.example.name
}
