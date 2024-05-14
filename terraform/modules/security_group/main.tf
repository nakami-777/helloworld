resource "aws_security_group" "security_group_alb" {
  name   = "${var.tag_name}_security_group_alb"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.tag_name}_security_group_alb"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "security_group_vpce" {
  name   = "${var.tag_name}_security_group_vpce"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.tag_name}_security_group_vpce"

  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "security_group_ecs_api" {
  name   = "${var.tag_name}_security_group_ecs_api"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.tag_name}_security_group_ecs_api"
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "security_group_ecs_front" {
  name   = "${var.tag_name}_security_group_ecs_front"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.tag_name}_security_group_ecs_front"
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
