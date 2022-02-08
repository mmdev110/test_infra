resource "aws_s3_bucket" "alb_log" {
  bucket = "mmdev-test-alb-log"
  lifecycle_rule {
    enabled = true
    expiration {
      days = "180"
    }
  }
  //削除する時のみ以下のコメントを外してapplyする
  //force_destroy = true
}

resource "aws_s3_bucket" "frontend" {
  bucket = "mmdev-test-frontend"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  //削除する時のみ以下のコメントを外してapplyする
  //force_destroy = true
}
resource "aws_s3_bucket" "records" {
  bucket = "mmdev-test-records"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  lifecycle_rule {
    enabled = true
    expiration {
      days = "1"
    }
  }
  //削除する時のみ以下のコメントを外してapplyする
  //force_destroy = true
}
