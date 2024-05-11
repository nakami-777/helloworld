variable "tag_name" {
  type = string
}

variable "ecr_image_api" {
  type = string
}
variable "ecr_image_front" {
  type = string
}

variable "ecs_subnet1" {
  type = string
}

variable "ecs_security_group_api" {
  type = string
}

variable "ecs_security_group_front" {
  type = string
}

variable "alb_tg_api_arn" {
  type = string
}

variable "alb_tg_front_arn" {
  type = string
}
