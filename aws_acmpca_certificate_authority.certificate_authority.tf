resource "aws_acmpca_certificate_authority" "certificate_authority" {
  certificate_authority_configuration {
    key_algorithm     = var.algorithm["key"]
    signing_algorithm = var.algorithm["signing"]

    subject {
      common_name         = try(var.subject["common_name"])
      country             = try(var.subject["country"])
      organization        = try(var.subject["organization"])
      organizational_unit = try(var.subject["organizational_unit"])
    }
  }

  revocation_configuration {
    crl_configuration {
      custom_cname       = "crl.${var.subject["common_name"]}"
      enabled            = true
      expiration_in_days = 7
      s3_bucket_name     = aws_s3_bucket.crl.bucket
      s3_object_acl      = "PUBLIC_READ"
    }
  }

  enabled    = true
  usage_mode = var.usage_mode
  type       = var.type
  depends_on = [aws_s3_bucket_policy.bucket]
}
