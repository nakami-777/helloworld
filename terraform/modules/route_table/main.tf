resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "${var.tag_name}_public_route_table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.tag_name}_private_route_table"
  }
}

# nat_gatewayは高いので、コメントアウトしておく
# resource "aws_route" "route_private_subnet_1a_0" {
#   destination_cidr_block = "0.0.0.0/0"
#   route_table_id         = aws_route_table.private.id
#   nat_gateway_id         = var.nat_gateway_1a_0_id
# }

resource "aws_route_table_association" "public_subnet_1a_0_route_association" {
  subnet_id      = var.public_subnet_1a_0_id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnet_1c_0_route_association" {
  subnet_id      = var.public_subnet_1c_0_id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_subnet_1a_0_route_association" {
  subnet_id      = var.private_subnet_1a_0_id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_subnet_1c_0_association" {
  subnet_id      = var.private_subnet_1c_0_id
  route_table_id = aws_route_table.private.id
}
