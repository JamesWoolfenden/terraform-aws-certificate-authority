output "certificate_authority_id" {
  description = "Certificate authority id"
  value       = module.ca.certificate_authority_id
}


output "certificate_authority_arn" {
  description = "Certificate authority arn"
  value       = module.ca.certificate_authority_arn
}

output "certificate" {
  description = "Root certificate"
  value       = module.ca.certificate
}

output "certificate_chain" {
  description = "Certificate chain"
  value       = module.ca.certificate_chain
}
