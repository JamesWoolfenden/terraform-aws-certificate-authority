output "certificate_signing_request" {
  value = aws_acmpca_certificate_authority.certificate_authority.certificate_signing_request
}
