resource "aws_lb" "alb_api" {
  name               = "${var.tag_name_kebab}-alb-api"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.public_subnet_1a_0_id, var.public_subnet_1c_0_id]

  enable_deletion_protection = false
}

resource "aws_lb" "alb_front" {
  name               = "${var.tag_name_kebab}-alb-front"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.public_subnet_1a_0_id, var.public_subnet_1c_0_id]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "alb_target_group_api" {
  name        = "${var.tag_name_kebab}-alb-tg-api"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    protocol            = "HTTP"
    path                = "/health"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 10
    interval            = 300
    matcher             = 200
  }
}

resource "aws_lb_target_group" "alb_target_group_front" {
  name        = "${var.tag_name_kebab}-alb-tg-front"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    protocol            = "HTTP"
    path                = "/api/health"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 10
    interval            = 300
    matcher             = 200
  }
}

resource "aws_lb_listener" "alb_listerner_api" {
  load_balancer_arn = aws_lb.alb_api.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group_api.arn
  }
}

resource "aws_lb_listener" "alb_listerner_front" {
  load_balancer_arn = aws_lb.alb_front.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group_front.arn
  }
}
