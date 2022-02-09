resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
  //DNSサーバーによる名前解決
  enable_dns_support = true
  //VPC内リソースに対してパブリックDNS割り当て
  enable_dns_hostnames = true
  tags = {
    Name = "example"
  }
}

