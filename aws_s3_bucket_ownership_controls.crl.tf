resource "aws_s3_bucket_ownership_controls" "crl" {
  # checkov:skip=CKV2_AWS_65: ACLs required for ACM PCA CRL writes
  bucket = aws_s3_bucket.crl.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
