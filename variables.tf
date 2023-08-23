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

variable "usage_mode" {
  type    = string
  default = "GENERAL_PURPOSE"
}

variable "type" {
  type    = string
  default = "SUBORDINATE"
}
