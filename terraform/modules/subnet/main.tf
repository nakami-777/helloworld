resource "aws_subnet" "public_subnet_0" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_0_cidr
  availability_zone       = var.availability_zone_1a
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tag_name}_${var.public_subnet_name}_0"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.availability_zone_1c
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.tag_name}_${var.public_subnet_name}_1"
  }
}

resource "aws_subnet" "private_subnet_0" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_0_cidr
  availability_zone       = var.availability_zone_1a
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.tag_name}_${var.private_subnet_name}_0"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnet_1_cidr
  availability_zone       = var.availability_zone_1a
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.tag_name}_${var.private_subnet_name}_1"
  }
}

