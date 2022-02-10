/*
秘匿パラメータはダミー値でリソースを作り、後からCLIで更新する
そもそもterraformで管理しない方が楽かも
CLIコマンドをメモ
aws --profile dev ssm put-parameter --name "plain_name" --value "plain value" --type String
aws --profile dev ssm get-parameter --output text --name "plain_name" --query Parameter.Value
aws --profile dev ssm put-parameter --name "plain_name" --type String --value "modified value" --overwrite
aws --profile dev ssm put-parameter --name "encryption_name" --value
 "encryption value" --type SecureString
aws --profile dev ssm get-parameter --output text --name "encryption_name" --query Parameter.Value --with-decryption
*/

resource "aws_ssm_parameter" "db_username" {
  name        = "/db/username"
  value       = "root"
  type        = "String"
  description = "DBユーザー名"
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/db/password"
  value       = "uninitialized"
  type        = "SecureString"
  description = "DBパスワード"
  lifecycle {
    ignore_changes = [value]
  }
}
resource "aws_ssm_parameter" "db_raw_password" {
  name        = "/db/raw_password"
  value       = "VeryStrongPassword!"
  type        = "SecureString"
  description = "データベースのパスワード"
}
