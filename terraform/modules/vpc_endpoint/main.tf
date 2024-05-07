resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [var.route_table_id]

  tags = {
    Name = "${var.tag_name}_vpc_endpoint_s3"
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.ecr.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [var.subnet_id]
  private_dns_enabled = true
  security_group_ids  = [var.security_group_id]

  tags = {
    Name = "${var.tag_name}_vpc_endpoint_ecr_api"
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [var.subnet_id]
  private_dns_enabled = true
  security_group_ids  = [var.security_group_id]

  tags = {
    Name = "${var.tag_name}_vpc_endpoint_ecr_dkr"
  }
}

resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [var.subnet_id]
  private_dns_enabled = true
  security_group_ids  = [var.security_group_id]

  tags = {
    Name = "${var.tag_name}_vpc_endpoint_cloudwatch_logs"
  }
}
