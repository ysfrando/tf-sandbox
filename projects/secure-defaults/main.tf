module "secure_module" {
  source                  = "./modules/secure_module"
  vpc_id                  = "vpc-0931b62e3647f32eb"
  bucket_name             = "my-project-bucket-ysfrando-123434252"
  allowed_ports           = [22, 80, 443]
  allowed_cidrs           = ["192.168.1.0/24"]
  allowed_security_groups = []
  environment             = "prod"
  project_name            = "secure-defaults"
}
