output "vpc_0_id" {
  value = aws_vpc.vpc_0.id
}

output "vpc_0_cidr" {
  value = aws_vpc.vpc_0.cidr_block
}

output "igw_0_id" {
  value = aws_internet_gateway.igw_0.id
}
