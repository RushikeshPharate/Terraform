
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "test_bucket"

  tags = {
    Name        = "test_bucket"
  }
}


output "s3_bucket_arn" {
    value = aws_s3_bucket.s3_bucket.arn
}

output "s3_bucket_id" {
    value = aws_s3_bucket.s3_bucket.id
}

output "s3_bucket_name" {
    value = aws_s3_bucket.s3_bucket.bucket_domain_name
}

