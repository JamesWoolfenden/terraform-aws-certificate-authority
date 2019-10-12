output "certificate_signing_request" {
  description = "The CSR itself"
  value       = aws_acmpca_certificate_authority.certificate_authority.certificate_signing_request
}
