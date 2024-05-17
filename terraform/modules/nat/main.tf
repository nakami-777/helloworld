# nat用のeip
# resource "aws_eip" "eip_1a_0" {
#   domain = "vpc"

#   tags = {
#     Name = "${var.tag_name_kebab}-eip-1a-0"
#   }
# }

# nat_gatewayは高いので、コメントアウトしておく
# resource "aws_nat_gateway" "nat_gateway_1a_0" {
#   subnet_id     = var.public_subnet_1a_0_id
#   allocation_id = aws_eip.eip_1a_0.id

#   tags = {
#     Name = "${var.tag_name_kebab}-nat-gateway-1a-0"
#   }
# }

module "nat" {
  source  = "int128/nat-instance/aws"
  version = "2.1.0"

  name                        = "${var.tag_name_kebab}-nat-instance-1a-0"
  vpc_id                      = var.vpc_id
  public_subnet               = var.public_subnet
  private_subnets_cidr_blocks = var.private_subnets_cidr_blocks
  private_route_table_ids     = var.private_route_table_ids
}

resource "aws_eip" "nat_instance_eip_1a_0" {
  network_interface = module.nat.eni_id

  tags = {
    Name = "${var.tag_name_kebab}-nat-instance-eip-1a-0"
  }
}
