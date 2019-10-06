module "ca" {
  source    = "../../"
  algorithm = var.algorithm
  subject   = var.subject
}
