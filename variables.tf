variable "subject" {
  type    = map(any)
  default = {}
}

variable "algorithm" {
  type    = map(any)
  default = {}
}

variable "sse_algorithm" {
  description = "The type of encryption algorithm to use"
  type        = string
  default     = "aws:kms"
}

variable "kms_key_arn" {
  description = "ARN or ID of KMS key"
  type        = string
  default     = null
}

variable "usage_mode" {
  type    = string
  default = "GENERAL_PURPOSE"

  validation {
    condition     = contains(["GENERAL_PURPOSE", "SHORT_LIVED_CERTIFICATE"], var.usage_mode)
    error_message = "Valid values for var: usage_mode are \"GENERAL_PURPOSE\". \"SHORT_LIVED_CERTIFICATE\"."
  }
}

variable "type" {
  description = "Type of the certificate authority"
  type        = string
  default     = "SUBORDINATE"

  validation {
    condition     = contains(["ROOT", "SUBORDINATE"], var.type)
    error_message = "Valid values for var: type are \"ROOT\". \"SUBORDINATE\"."
  }
}
