resource "aws_s3_bucket" "alb_log" {
  bucket = "mmdev-test-alb-log"
  lifecycle_rule {
    enabled = true
    expiration {
      days = "180"
    }
  }
  //削除する時のみ以下のコメントを外してapplyする
  force_destroy = true
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
  force_destroy = true
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
  force_destroy = true
}

resource "aws_s3_bucket_policy" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.alb_log.json
}
data "aws_iam_policy_document" "alb_log" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_log.id}/*"]
    principals {
      type = "AWS"
      //582318560864 = ELB account id in ap-northeast-1
      identifiers = ["582318560864"]
    }
  }
}
