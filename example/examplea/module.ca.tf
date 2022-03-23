module "ca" {
  source    = "../../"
  algorithm = var.algorithm
  subject   = var.subject
  kms_key   = aws_kms_key.example
}
