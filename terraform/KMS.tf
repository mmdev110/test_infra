resource "aws_kms_key" "example" {
  description             = "Example Customer Master Key"
  enable_key_rotation     = true
  is_enabled              = true
  deletion_window_in_days = 30
}

//CMSに名前(エイリアス)をつける
resource "aws_kms_alias" "example" {
  //先頭にalias/をつけること
  name          = "alias/example"
  target_key_id = aws_kms_key.example.id
}
