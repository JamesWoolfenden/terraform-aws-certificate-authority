variable "subject" {
  type = map
}

variable "algorithm" {
  type = map
}

variable "sse_algorithm" {
  description = "The type of encryption algorithm to use"
  type        = string
  default     = "aws:kms"
}
