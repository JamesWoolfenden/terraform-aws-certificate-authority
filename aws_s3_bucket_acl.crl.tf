resource "aws_s3_bucket_acl" "crl" {
  # checkov:skip=CKV_AWS_20: Required
  # checkov:skip=CKV_AWS_379: CRL must be publicly readable
  bucket = aws_s3_bucket.crl.id
  acl    = "public-read"
}
