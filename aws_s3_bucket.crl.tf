resource "aws_s3_bucket" "crl" {
  # checkov:skip=CKV2_AWS_6: Cert bucket needs public read
  # checkov:skip=CKV_AWS_144: Inappropriate check
  # checkov:skip=CKV2_AWS_37: Versioning off
  # checkov:skip=CKV2_AWS_41: Logging Off
  # checkov:skip=CKV_AWS_18: "Ensure the S3 bucket has access logging enabled"
  # checkov:skip=CKV2_AWS_62: Add your own event notification
  # checkov:skip=CKV_AWS_145: bucket should be readable
  # checkov:skip=CKV_AWS_20: bucket should be readable
  bucket = "certificate-revocation-list-${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket_versioning" "crl" {
  bucket = aws_s3_bucket.crl.id
  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "expire" {
  bucket = aws_s3_bucket.crl.bucket

  rule {
    id     = "Keep previous version 1 year"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 365
    }
  }

  rule {
    id     = "Delete old incomplete multi-part uploads"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}
