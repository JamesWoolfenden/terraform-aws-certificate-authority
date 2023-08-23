resource "aws_acmpca_certificate_authority_certificate" "certificate_authority_certificate" {
  certificate_authority_arn = aws_acmpca_certificate_authority.certificate_authority.arn

  certificate       = aws_acmpca_certificate.certificate.certificate
  certificate_chain = aws_acmpca_certificate.certificate.certificate_chain

  depends_on = [
    aws_acmpca_certificate_authority.certificate_authority,
    aws_acmpca_certificate.certificate
  ]
}
