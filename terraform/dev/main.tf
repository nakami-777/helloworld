module "alb" {
  source = "../modules/alb"

  tag_name_kebab        = var.tag_name_kebab
  security_group_id     = module.security_group.security_group_alb_id
  public_subnet_1a_0_id = module.subnet.public_subnet_1a_0_id
  public_subnet_1c_0_id = module.subnet.public_subnet_1c_0_id
  vpc_id                = module.vpc.vpc_0_id
}

module "ecr" {
  source = "../modules/ecr"

  tag_name = var.tag_name
}

module "ecs" {
  source = "../modules/ecs"

  tag_name                 = var.tag_name
  ecr_image_api            = "654654549333.dkr.ecr.ap-northeast-1.amazonaws.com/helloworld_dev_ecr_api:latest"
  ecr_image_front          = "654654549333.dkr.ecr.ap-northeast-1.amazonaws.com/helloworld_dev_ecr_front:latest"
  ecs_subnet1              = module.subnet.private_subnet_1a_0_id
  ecs_security_group_api   = module.security_group.security_group_ecs_api_id
  ecs_security_group_front = module.security_group.security_group_ecs_front_id
  alb_tg_api_arn           = module.alb.alb_tg_api_arn
  alb_tg_front_arn         = module.alb.alb_tg_front_arn
}

module "nat" {
  source = "../modules/nat"

  tag_name_kebab              = var.tag_name_kebab
  public_subnet_1a_0_id       = module.subnet.public_subnet_1a_0_id
  vpc_id                      = module.vpc.vpc_0_id
  public_subnet               = module.subnet.public_subnet_1a_0_id
  private_subnets_cidr_blocks = [module.subnet.private_subnet_1a_0_cidr]
  private_route_table_ids     = [module.route_table.route_table_private_id]
}

module "route_table" {
  source = "../modules/route_table"

  tag_name = var.tag_name
  vpc_id   = module.vpc.vpc_0_id
  igw_id   = module.vpc.igw_0_id
  # nat_gateway_1a_0_id    = module.nat_gateway.nat_gateway_1a_0_id
  public_subnet_1a_0_id  = module.subnet.public_subnet_1a_0_id
  public_subnet_1c_0_id  = module.subnet.public_subnet_1c_0_id
  private_subnet_1a_0_id = module.subnet.private_subnet_1a_0_id
  private_subnet_1c_0_id = module.subnet.private_subnet_1c_0_id
}

module "security_group" {
  source = "../modules/security_group"

  tag_name = var.tag_name
  vpc_id   = module.vpc.vpc_0_id
  vpc_cidr = module.vpc.vpc_0_cidr
}

module "subnet" {
  source = "../modules/subnet"

  tag_name                 = var.tag_name
  availability_zone_1a     = var.availability_zone_1a
  availability_zone_1c     = var.availability_zone_1c
  vpc_id                   = module.vpc.vpc_0_id
  public_subnet_1a_0_cidr  = "10.0.0.0/24"
  public_subnet_1c_0_cidr  = "10.0.3.0/24"
  private_subnet_1a_0_cidr = "10.0.1.0/24"
  private_subnet_1c_0_cidr = "10.0.2.0/24"
}

module "vpc" {
  source = "../modules/vpc"

  tag_name = var.tag_name
  vpc_cidr = "10.0.0.0/16"
}

module "vpc_endpoint" {
  source = "../modules/vpc_endpoint"

  tag_name       = var.tag_name
  vpc_id         = module.vpc.vpc_0_id
  route_table_id = module.route_table.route_table_private_id
}
