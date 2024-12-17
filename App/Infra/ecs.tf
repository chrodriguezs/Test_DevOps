#Create Task Definition
resource "aws_ecs_task_definition" "task_definition" {
    family                              = "${var.tag_application}-task"

    container_definitions               = jsonencode(
    [
    {
        "name"                          : "${var.tag_application}-container",
        "image"                         : "${data.aws_ssm_parameter.ECR_name.value}:latest",
        "entryPoint"                    : []
        "essential"                     : true,
        "networkMode"                   : "awsvpc",
        "portMappings"                  : [
                                            {
                                                "containerPort" : var.container_port,
                                                "hostPort"      : var.container_port,
                                            }
                                          ]
        "healthCheck"                   : {
                                            "command"     : [ "CMD-SHELL", "curl -f http://localhost:${var.container_port}/ || exit 1" ],
                                            "interval"    : 30,
                                            "timeout"     : 5,
                                            "startPeriod" : 10,
                                            "retries"     : 3
                                          }
    }
    ] 
    )

    requires_compatibilities            = ["FARGATE"]
    network_mode                        = "awsvpc"
    cpu                                 = "256"
    memory                              = "512"
    execution_role_arn                  = data.aws_ssm_parameter.ECS_TaskExecutionRole.value
    task_role_arn                       = data.aws_ssm_parameter.ECS_TaskRole.value
}

#Create Task Service
resource "aws_ecs_service" "ecs_service" {
    name                                = "${var.tag_application}-service"
    cluster                             = data.aws_ssm_parameter.ECS_arn.value
    task_definition                     = aws_ecs_task_definition.task_definition.arn
    launch_type                         = "FARGATE"
    scheduling_strategy                 = "REPLICA"
    desired_count                       = 2 # the number of tasks you wish to run

  load_balancer {
    target_group_arn                    = aws_lb_target_group.target_group.arn #the target group defined in the alb file
    container_name                      = "${var.tag_application}-container"
    container_port                      = var.container_port
  }
}
