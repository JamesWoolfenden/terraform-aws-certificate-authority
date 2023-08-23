output "certificate_authority_id" {
  description = "Certificate authority id"
  value       = aws_acmpca_certificate_authority.certificate_authority.id
}


output "certificate_authority_arn" {
  description = "Certificate authority arn"
  value       = aws_acmpca_certificate_authority.certificate_authority.arn
}
