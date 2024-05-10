resource "aws_lb" "alb_api" {
  name               = "${var.tag_name_kebab}-alb-api"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.subnet_0_id, var.subnet_1_id]

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
    interval            = 60
    matcher             = 200
  }
}

resource "aws_lb_listener" "alb_listerner_0" {
  load_balancer_arn = aws_lb.alb_api.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group_api.arn
  }
}
