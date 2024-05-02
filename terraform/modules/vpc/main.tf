resource "aws_vpc" "vpc_0" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.tag_name}_vpc_0"
  }
}
