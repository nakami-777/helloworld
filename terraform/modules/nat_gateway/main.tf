resource "aws_eip" "eip_1a_0" {
  domain = "vpc"

  tags = {
    Name = "${var.tag_name_kebab}-eip-1a-0"
  }
}

resource "aws_nat_gateway" "nat_gateway_1a_0" {
  subnet_id     = var.public_subnet_1a_0_id
  allocation_id = aws_eip.eip_1a_0.id

  tags = {
    Name = "${var.tag_name_kebab}-nat-gateway-1a-0"
  }
}