resource "aws_acmpca_certificate_authority" "certificate_authority" {
  certificate_authority_configuration {
    key_algorithm     = var.algorithm["key"]
    signing_algorithm = var.algorithm["signing"]

    subject {
      common_name         = var.subject["common_name"]
      country             = var.subject["country"]
      organization        = var.subject["organization"]
      organizational_unit = var.subject["organizational_unit"]
    }
  }

  revocation_configuration {
    crl_configuration {
      custom_cname       = "crl.${var.subject["common_name"]}"
      enabled            = true
      expiration_in_days = 7
      s3_bucket_name     = aws_s3_bucket.crl.bucket
    }
  }

  depends_on = [aws_s3_bucket_policy.bucket]
}
