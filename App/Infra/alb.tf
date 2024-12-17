#Defining the target group and a health check on the application
resource "aws_lb_target_group" "target_group" {
  name                      = "${var.tag_application}-tg"
  port                      = var.container_port
  protocol                  = "HTTP"
  target_type               = "ip"
  vpc_id                    = data.aws_ssm_parameter.vpc_id.value
  health_check {
      path                  = "/"
      protocol              = "HTTP"
      matcher               = "200"
      port                  = "traffic-port"
      healthy_threshold     = 2
      unhealthy_threshold   = 2
      timeout               = 10
      interval              = 30
  }
}

#Defines an Listener Rule for the ALB
resource "aws_lb_listener_rule" "listener_rule" {
  listener_arn = data.aws_ssm_parameter.ALB_Listener_arn.value
  priority     = 100  # Lower number means higher priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

  condition {
    path_pattern {
      values = ["/${var.tag_application}*"]
    }
  }
}