module "ca" {
  source      = "../../"
  algorithm   = var.algorithm
  subject     = var.subject
  kms_key_arn = aws_kms_key.example.arn
}
