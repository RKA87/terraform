resource "aws_s3_bucket" "roboshops3" {
  bucket = var.bucket_name
  region = "us-east-1"

  tags = merge(var.common_tags, {
            Name = "${var.bucket_name}"
        })
}

resource "aws_s3_bucket_ownership_controls" "roboshops3_ownership" {
  bucket = aws_s3_bucket.roboshops3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  
}

resource "aws_s3_bucket_acl" "robohsops3_acl" {
  bucket = aws_s3_bucket.roboshops3.id
  depends_on = [aws_s3_bucket_ownership_controls.roboshops3_ownership]
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "roboshops3_public_access_block" {
  bucket = aws_s3_bucket.roboshops3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  
}