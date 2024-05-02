resource "aws_ecr_repository" "ecr_api" {
  name                 = "${var.tag_name}_ecr_api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "ecr_front" {
  name                 = "${var.tag_name}_ecr_front"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_policy_api" {
  repository = aws_ecr_repository.ecr_api.name
  policy = jsonencode({
    rules = [
      {
        action = {
          type = "expire"
        }
        description  = "最新のイメージを5つだけ残す"
        rulePriority = 1
        selection = {
          countNumber = 5
          countType   = "imageCountMoreThan"
          tagStatus   = "any"
        }
      }
    ]
  })
}

resource "aws_ecr_lifecycle_policy" "ecr_policy_front" {
  repository = aws_ecr_repository.ecr_front.name
  policy = jsonencode({
    rules = [
      {
        action = {
          type = "expire"
        }
        description  = "最新のイメージを5つだけ残す"
        rulePriority = 1
        selection = {
          countNumber = 5
          countType   = "imageCountMoreThan"
          tagStatus   = "any"
        }
      }
    ]
  })
}
