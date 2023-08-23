resource "aws_acmpca_certificate" "certificate" {
  certificate_authority_arn   = aws_acmpca_certificate_authority.certificate_authority.arn
  certificate_signing_request = aws_acmpca_certificate_authority.certificate_authority.certificate_signing_request
  signing_algorithm           = var.algorithm["signing"]

  template_arn = "arn:${data.aws_partition.current.partition}:acm-pca:::template/RootCACertificate/V1"

  validity {
    type  = "YEARS"
    value = 10
  }

  depends_on = [aws_acmpca_certificate_authority.certificate_authority]
}

data "aws_partition" "current" {}
