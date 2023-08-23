data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket" "crl" {
  # checkov:skip=CKV2_AWS_6: ADD REASON
  # tfsec:ignore:AWS002
  # checkov:skip=CKV_AWS_144: Inappropriate check
  # checkov:skip=CKV2_AWS_37: Versioning off
  # checkov:skip=CKV2_AWS_41:Logging Off
  # checkov:skip=CKV_AWS_21:v4 legacy
  # checkov:skip=CKV_AWS_145:v4 legacy
  # checkov:skip=CKV_AWS_19:v4 legacy
  # checkov:skip=CKV_AWS_18: "Ensure the S3 bucket has access logging enabled"
  # checkov:skip=CKV2_AWS_62: Add your own event notification
  bucket = "certificate-revocation-list-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "crl" {
  bucket = aws_s3_bucket.crl.id
  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "crl" {
  bucket = aws_s3_bucket.crl.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
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

  depends_on = [aws_s3_bucket_versioning.crl]

}

resource "aws_s3_bucket_public_access_block" "crl"{
  bucket = aws_s3_bucket.crl.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  depends_on = [
    aws_s3_bucket_server_side_encryption_configuration.crl,
    aws_s3_bucket_lifecycle_configuration.expire
  ]
}

resource "aws_s3_bucket_policy" "crl" {
  bucket = aws_s3_bucket.crl.id
  policy = data.aws_iam_policy_document.access.json

  depends_on = [
    aws_s3_bucket_public_access_block.crl
  ]
}

resource "aws_s3_bucket_ownership_controls" "crl" {
  bucket = aws_s3_bucket.crl.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }

  depends_on = [
    aws_s3_bucket_policy.crl,
    aws_s3_bucket_public_access_block.crl
  ]
}

resource "aws_s3_bucket_acl" "crl" {
  bucket = aws_s3_bucket.crl.id
  acl    = "public-read"

  depends_on = [
    aws_s3_bucket_ownership_controls.crl,
    aws_s3_bucket_public_access_block.crl,
  ]
}
