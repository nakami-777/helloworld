output "alb_tg_api_arn" {
  value = aws_lb_target_group.alb_target_group_api.arn
}

output "alb_tg_front_arn" {
  value = aws_lb_target_group.alb_target_group_front.arn
}
