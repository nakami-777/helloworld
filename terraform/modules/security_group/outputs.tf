output "security_group_vpce_id" {
  value = aws_security_group.security_group_vpce.id
}

output "security_group_ecs_api_id" {
  value = aws_security_group.security_group_ecs_api.id
}

output "security_group_ecs_front_id" {
  value = aws_security_group.security_group_ecs_front.id
}

output "security_group_alb_id" {
  value = aws_security_group.security_group_alb.id
}
