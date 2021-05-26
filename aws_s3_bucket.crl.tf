resource "aws_s3_bucket" "crl" {
  # checkov:skip=CKV2_AWS_6: ADD REASON
  # tfsec:ignore:AWS002
  # checkov:skip=CKV_AWS_144: Inappropriate check
  # checkov:skip=CKV_AWS_18: "Ensure the S3 bucket has access logging enabled"
  bucket = "certificate-revocation-list-${data.aws_caller_identity.current.account_id}"

  versioning {
    enabled    = true
    mfa_delete = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.sse_algorithm
      }
    }
  }
}

data "aws_caller_identity" "current" {}
