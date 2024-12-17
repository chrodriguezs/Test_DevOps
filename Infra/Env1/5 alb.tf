#Defining the Application Load Balancer
resource "aws_alb" "application_load_balancer" {
  name                      = "test-alb"
  internal                  = false
  load_balancer_type        = "application"
  subnets                   = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  security_groups           = [aws_security_group.alb_sg.id]
}

#Create ALB Security Group
resource "aws_security_group" "alb_sg" {
    vpc_id                      = aws_vpc.vpc.id
    name                        = "demo-sg-alb"
    description                 = "Security group for alb"
    revoke_rules_on_delete      = true
}

resource "aws_security_group_rule" "alb_ingress" {
    type                        = "ingress"
    from_port                   = 80
    to_port                     = 80
    protocol                    = "TCP"
    description                 = "Allow http inbound traffic from internet"
    security_group_id           = aws_security_group.alb_sg.id
    cidr_blocks                 = ["0.0.0.0/0"] 
}

resource "aws_security_group_rule" "alb_egress" {
    type                        = "egress"
    from_port                   = 0
    to_port                     = 0
    protocol                    = "-1"
    description                 = "Allow outbound traffic from alb"
    security_group_id           = aws_security_group.alb_sg.id
    cidr_blocks                 = ["0.0.0.0/0"] 
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "File not Found."
      status_code  = "404"
    }
  }
}

#Safe LoadBalancer ARN in Parameter Store
resource "aws_ssm_parameter" "ALB_arn" {
  name  = "/${var.tag_environment}/ALB_arn"
  type  = "String"
  value = aws_alb.application_load_balancer.arn
}

resource "aws_ssm_parameter" "ALB_Listener_arn" {
  name  = "/${var.tag_environment}/ALB_Listener_arn"
  type  = "String"
  value = aws_lb_listener.alb_listener.arn
}