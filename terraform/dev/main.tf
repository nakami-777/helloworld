module "vpc" {
  source = "../modules/vpc"

  tag_name = var.tag_name
  vpc_cidr = "10.0.0.0/16"
}

module "subnet" {
  source = "../modules/subnet"

  tag_name                  = var.tag_name
  default_availability_zone = var.default_availability_zone
  vpc_id                    = module.vpc.vpc_0_id
  public_subnet_0_cidr      = "10.0.0.0/24"
  private_subnet_0_cidr     = "10.0.1.0/24"
  private_subnet_1_cidr     = "10.0.2.0/24"
}

module "ecr" {
  source = "../modules/ecr"

  tag_name = var.tag_name
}
