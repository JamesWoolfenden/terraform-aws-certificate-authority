resource "aws_acmpca_certificate_authority" "certificate_authority" {
  certificate_authority_configuration {
    key_algorithm     = var.algorithm["key"]
    signing_algorithm = var.algorithm["signing"]

    dynamic "subject" {
      for_each = [var.subject]

      content {
        common_name                  = try(subject.value.common_name, null)
        country                      = try(subject.value.country, null)
        distinguished_name_qualifier = try(subject.value.distinguished_name_qualifier, null)
        generation_qualifier         = try(subject.value.generation_qualifier, null)
        given_name                   = try(subject.value.given_name, null)
        initials                     = try(subject.value.initials, null)
        locality                     = try(subject.value.locality, null)
        organization                 = try(subject.value.organization, null)
        organizational_unit          = try(subject.value.organizational_unit, null)
        pseudonym                    = try(subject.value.pseudonym, null)
        state                        = try(subject.value.state, null)
        surname                      = try(subject.value.surname, null)
        title                        = try(subject.value.title, null)
      }
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

  usage_mode = var.usage_mode
  type       = var.type

  depends_on = [aws_s3_bucket_policy.crl]

}
