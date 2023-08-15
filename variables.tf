variable "subject" {
  type = map(any)
}

variable "algorithm" {
  type = map(any)
}

variable "sse_algorithm" {
  description = "The type of encryption algorithm to use"
  type        = string
  default     = "aws:kms"
}

variable "kms_key_arn" {
  description = "ARN or ID of KMS key"
  type        = string
}

variable "usage_mode" {
  type        = string
  default     = "GENERAL_PURPOSE"
}

variable "type" {
  description = "Type of the certificate authority"
  type        = string
  default     = "SUBORDINATE"
}