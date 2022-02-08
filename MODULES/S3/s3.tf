
locals {
  #bucket_name = "${var.bucket_name}-${local.prefix}"
  region = "${data.aws_region.current.id}"
  s3_suffix = "0000000"
  prefix = "beginig"
}

variable "bucket_names" {
  default = [
    "ziyotek-devops-practice-bucket",
    "personal-devops-practice-bucket",
    "office-devops-practice-bucket"
  ]
}

resource "aws_s3_bucket" "devops-s3-1" {

  count = var.create_s3 ? 3 : 0

  bucket = "${var.environment}-${var.bucket_names[0]}-${count.index}"
  acl    = var.s3_acl
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning {
    enabled = var.versioning_enabled
  }
}


