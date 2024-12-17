#Create ECR
resource "aws_ecr_repository" "ecr" {
    name                            = var.repository_name
}

resource "aws_ecr_lifecycle_policy" "ecr_policy" {
    repository                      = aws_ecr_repository.ecr.name
    policy                          = local.ecr_policy
}

locals {
  ecr_policy = jsonencode({
        "rules":[
            {
                "rulePriority"      : 1,
                "description"       : "Expire images older than 14 days",
                "selection": {
                    "tagStatus"     : "any",
                    "countType"     : "sinceImagePushed",
                    "countUnit"     : "days",
                    "countNumber"   : 14
                },
                "action": {
                    "type"          : "expire"
                }
            }
        ]
    })
}

#Safe ECR values in Parameter Store
resource "aws_ssm_parameter" "ECR_name" {
  name  = "/${var.tag_environment}/ECR_name"
  type  = "String"
  value = aws_ecr_repository.ecr.name
}

resource "aws_ssm_parameter" "ECR_url" {
  name  = "/${var.tag_environment}/ECR_url"
  type  = "String"
  value = aws_ecr_repository.ecr.repository_url
}