resource "aws_s3_bucket" "crl" {
  bucket = "certificate-revocation-list-${data.aws_caller_identity.current.account_id}"
  versioning {
    enabled = true
  }
}

data "aws_caller_identity" "current" {}
