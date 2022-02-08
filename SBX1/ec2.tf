module "ec2" {
  source = "../MODULES/EC2"

  environment = var.environment

  subnet_id = module.vpc.subnet_1_id
  vpc_security_group = [module.security_group.vpc_sg]
  instance_profile = module.iam.instance_profile
}