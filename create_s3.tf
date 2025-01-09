provider "aws" {
  region = "us-east-1"  
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-123456"  
  acl    = "private"  

  versioning {
    enabled = true  

  tags = {
    Name        = "My S3 Bucket"
    Environment = "Dev"
  }
}

# Optional: Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "my_bucket_encryption" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256" 
    }
  }
}