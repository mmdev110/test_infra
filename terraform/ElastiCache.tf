//Redis

resource "aws_elasticache_parameter_group" "example" {
  name   = "example"
  family = "redis5.0"
  parameter {
    name  = "cluster-enabled"
    value = "no" //クラスターモード無効
  }
}
resource "aws_elasticache_subnet_group" "example" {
  name       = "example"
  subnet_ids = [aws_subnet.private_0.id, aws_subnet.private_1.id]
}

resource "aws_elasticache_replication_group" "example" {
  replication_group_id          = "example"
  replication_group_description = "Cluster Disabled"
  engine                        = "redis"
  engine_version                = "5.0.4"
  number_cache_clusters         = 3 //プライマリが1つレプリカが2つ
  node_type                     = "cache.m3.medium"
  snapshot_window               = "09:10-10:10" //UTC
  snapshot_retention_limit      = 7             //保持期間
  maintenance_window            = "mon:10:40-mon:11:40"
  automatic_failover_enabled    = true //subnet_group設定が必要
  port                          = 6379
  apply_immediately             = false
  security_group_ids            = [module.redis_sg.security_group_id]
  parameter_group_name          = aws_elasticache_parameter_group.example.name
  subnet_group_name             = aws_elasticache_subnet_group.example.name
}
module "redis_sg" {
  source      = "./security_group"
  name        = "redis-sg"
  vpc_id      = aws_vpc.example.id
  port        = 6379
  cidr_blocks = [aws_vpc.example.cidr_block]
}
