resource "aws_acmpca_certificate_authority" "certificate_authority" {
  certificate_authority_configuration {
    key_algorithm     = var.algorithm["key"]
    signing_algorithm = var.algorithm["signing"]

    dynamic "subject" {
      for_each = [var.subject]

      content {
        common_name         = try(subject.value.common_name, null)
        country             = try(subject.value.country, null)
        organization        = try(subject.value.organization, null)
        organizational_unit = try(subject.value.organizational_unit, null)
        locality            = try(subject.value.locality, null)
        state               = try(subject.value.state, null)
      }
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

  usage_mode = var.usage_mode
  type = var.type

  depends_on = [aws_s3_bucket_policy.bucket]

}
