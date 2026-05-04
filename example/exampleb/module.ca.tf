module "ca" {
  source    = "git::https://github.com/JamesWoolfenden/terraform-aws-certificate-authority.git?ref=c7cd5e15bf5345c0be6252cc7cb1414a2f89ff2b" #v0.2.72
  algorithm = var.algorithm
  subject   = var.subject
}
