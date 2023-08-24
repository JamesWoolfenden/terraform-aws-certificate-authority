output "certificate_signing_request" {
  value = module.ca.certificate_signing_request
}
output "certificate_authority_id" {
  description = "Certificate authority id"
  value       = module.ca.certificate_authority_id
}
output "certificate_authority_arn" {
  description = "Certificate authority arn"
  value       = module.ca.certificate_authority_arn
}
