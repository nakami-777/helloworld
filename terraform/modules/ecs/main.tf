resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy2" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy3" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy4" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy5" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# resource "aws_ecs_cluster" "ecs_0" {
#   name = "${var.tag_name}_ecs_0"

#   setting {
#     name  = "containerInsights"
#     value = "enabled"
#   }

#   tags = {
#     Name = "${var.tag_name}_ecs_0"
#   }
# }

# resource "aws_ecs_cluster_capacity_providers" "ecs_cluster_capacity_provider" {
#   cluster_name       = aws_ecs_cluster.ecs_0.name
#   capacity_providers = ["FARGATE"]

#   default_capacity_provider_strategy {
#     base              = 1
#     weight            = 100
#     capacity_provider = "FARGATE"
#   }
# }

# resource "aws_ecs_task_definition" "ecs_task_api" {
#   family                   = "${var.tag_name}_ecs_task_api"
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]
#   cpu                      = "256"
#   memory                   = "512"
#   task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
#   execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

#   container_definitions = jsonencode(
#     [
#       {
#         "name" : "${var.tag_name}_ecs_task_api",
#         "image" : var.ecr_image_api,
#         "essentials" : true,
#         "portMappings" : [
#           {
#             "containerPort" : 8080,
#             "hostPort" : 8080,
#             "protocol" : "tcp"
#           }
#         ],
#       }
#     ]
#   )
# }

# resource "aws_ecs_service" "ecs_service_api" {
#   name                   = "${var.tag_name}_ecs_service_api"
#   cluster                = aws_ecs_cluster.ecs_0.id
#   task_definition        = aws_ecs_task_definition.ecs_task_api.arn
#   desired_count          = 1
#   launch_type            = "FARGATE"
#   enable_execute_command = true

#   network_configuration {
#     subnets          = [var.ecs_api_subnet]
#     security_groups  = [var.ecs_security_group]
#     assign_public_ip = false
#   }

#   load_balancer {
#     target_group_arn = var.alb_tg_arn
#     container_name   = "${var.tag_name}_ecs_task_api"
#     container_port   = 8080
#   }
# }
