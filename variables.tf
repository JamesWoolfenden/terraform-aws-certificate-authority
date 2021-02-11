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
