#Load Identity
data "aws_caller_identity" "current" {}

locals {
    account_id = data.aws_caller_identity.current.account_id
}

# Load Parameters
data "aws_ssm_parameter" "vpc_id" {
  name = "${var.tag_environment}/vpc_id"
}

data "aws_ssm_parameter" "ALB_arn" {
  name = "${var.tag_environment}/ALB_arn"
}

data "aws_ssm_parameter" "ALB_Listener_arn" {
  name = "${var.tag_environment}/ALB_Listener_arn"
}

data "aws_ssm_parameter" "ECR_name" {
  name = "${var.tag_environment}/ECR_name"
}

data "aws_ssm_parameter" "ECR_url" {
  name = "${var.tag_environment}/ECR_url"
}

data "aws_ssm_parameter" "ECS_arn" {
  name = "${var.tag_environment}/ECS_arn"
}

data "aws_ssm_parameter" "ECS_TaskExecutionRole" {
  name = "${var.tag_environment}/ECS_TaskExecutionRole"
}

data "aws_ssm_parameter" "ECS_TaskRole" {
  name = "${var.tag_environment}/ECS_TaskRole"
}