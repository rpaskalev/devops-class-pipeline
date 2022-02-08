locals {
    etl_prefix = "ziyotek-prefix"
    prod_etl_bucket_names = toset([
        "${local.etl_prefix}-production-etl",
        "${local.etl_prefix}-prod-etl"
    ])
}

resource "aws_s3_bucket" "devops" {
    for_each = local.prod_etl_bucket_names


  bucket = each.key
  acl    = "private"

  tags = {
    s3_bucket_name   = each.key
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  for_each = aws_s3_bucket.devops
  bucket = each.value.id

  block_public_acls   = true
  block_public_policy = true
  depends_on = [aws_s3_bucket.devops]
}

resource "aws_s3_bucket_ownership_controls" "example" {
  for_each = aws_s3_bucket.devops
  bucket = each.value.id

depends_on = [aws_s3_bucket_public_access_block.example]
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}