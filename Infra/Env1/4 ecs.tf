#Create ECS
resource "aws_ecs_cluster" "ecs_cluster" {
    name                                = var.ECS_name
}

#Create ECS Security Group
resource "aws_security_group" "ecs_sg" {
    vpc_id                      = aws_vpc.vpc.id
    name                        = "${var.ECS_name}-sg"
    description                 = "Security group for ECS"
    revoke_rules_on_delete      = true
}

resource "aws_security_group_rule" "ecs_alb_ingress" {
    type                        = "ingress"
    from_port                   = 0
    to_port                     = 0
    protocol                    = "-1"
    description                 = "Allow inbound traffic from ALB"
    security_group_id           = aws_security_group.ecs_sg.id
    source_security_group_id    = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "ecs_all_egress" {
    type                        = "egress"
    from_port                   = 0
    to_port                     = 0
    protocol                    = "-1"
    description                 = "Allow outbound traffic from ECS"
    security_group_id           = aws_security_group.ecs_sg.id
    cidr_blocks                 = ["0.0.0.0/0"] 
}

#Create ECS IAM Roles
resource "aws_iam_role" "ecsTaskExecutionRole" {
    name                  = "${var.tag_environment}_ecsTaskExecutionRole"
    assume_role_policy    = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions               = ["sts:AssumeRole"]

    principals {
      type                = "Service"
      identifiers         = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
    role                  = aws_iam_role.ecsTaskExecutionRole.name
    policy_arn            = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecsTaskRole" {
    name                  = "${var.tag_environment}_ecsTaskRole"
    assume_role_policy    = data.aws_iam_policy_document.assume_role_policy.json   
}

resource "aws_iam_role_policy_attachment" "ecsTaskRole_policy" {
    role                  = aws_iam_role.ecsTaskRole.name
    policy_arn            = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

#Safe ECR values in Parameter Store
resource "aws_ssm_parameter" "ECS_arn" {
  name  = "/${var.tag_environment}/ECS_arn"
  type  = "String"
  value = aws_ecs_cluster.ecs_cluster.arn
}

resource "aws_ssm_parameter" "ECS_TaskExecutionRole" {
  name  = "/${var.tag_environment}/ECS_TaskExecutionRole"
  type  = "String"
  value = aws_iam_role.ecsTaskExecutionRole.arn
}

resource "aws_ssm_parameter" "ECS_TaskRole" {
  name  = "/${var.tag_environment}/ECS_TaskRole"
  type  = "String"
  value = aws_iam_role.ecsTaskRole.arn
}