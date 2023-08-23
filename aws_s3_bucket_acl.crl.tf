resource "aws_s3_bucket_acl" "crl" {
  # checkov:skip=CKV_AWS_20: Required    
  bucket = aws_s3_bucket.crl.id
  acl    = "public-read"
}