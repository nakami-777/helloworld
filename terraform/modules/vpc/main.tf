resource "aws_vpc" "vpc_0" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.tag_name}_vpc_0"
  }
}

resource "aws_internet_gateway" "igw_0" {
  vpc_id = aws_vpc.vpc_0.id

  tags = {
    Name = "${var.tag_name}_igw_0"
  }
}
