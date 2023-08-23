resource "aws_s3_bucket_public_access_block" "crl" {
  # checkov:skip=CKV_AWS_55: Cert bucket needs public read  
  # checkov:skip=CKV_AWS_54: Cert bucket needs public read   
  # checkov:skip=CKV_AWS_53: Cert bucket needs public read   
  # checkov:skip=CKV_AWS_56: Cert bucket needs public read 
  bucket                  = aws_s3_bucket.crl.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}