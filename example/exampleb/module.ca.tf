module "ca" {
  source    = "git::https://github.com/JamesWoolfenden/terraform-aws-certificate-authority.git?ref=ac7e4b8f846704fa5655bcc3d4bdb6640f070f42"
  algorithm = var.algorithm
  subject   = var.subject
}
