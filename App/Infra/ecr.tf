#Build and Push a docker image
locals {
  docker_login_command              = "aws ecr get-login-password --region ${var.region} --profile personal | docker login --username AWS --password-stdin ${local.account_id}.dkr.ecr.${var.region}.amazonaws.com"
  docker_build_command              = "docker build -t ${var.tag_application} ../${var.tag_application}/Source"
  docker_tag_command                = "docker tag ${var.tag_application}:latest ${local.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.tag_application}:latest"
  docker_push_command               = "docker push ${data.aws_ssm_parameter.ECR_name.value}.dkr.ecr.${var.region}.amazonaws.com/${var.tag_application}:latest"
}

resource "null_resource" "docker_login" {
    provisioner "local-exec" {
        command                     = local.docker_login_command
    }
    triggers = {
        "run_at"                    = timestamp()
    }
}

resource "null_resource" "docker_build" {
    provisioner "local-exec" {
        command                     = local.docker_build_command
    }
    triggers = {
        "run_at"                    = timestamp()
    }
    depends_on                      = [ null_resource.docker_login ]
}

resource "null_resource" "docker_tag" {
    provisioner "local-exec" {
        command                     = local.docker_tag_command
    }
    triggers = {
        "run_at"                    = timestamp()
    }
    depends_on                      = [ null_resource.docker_build ]
}

resource "null_resource" "docker_push" {
    provisioner "local-exec" {
        command                     = local.docker_push_command
    }
    triggers = {
        "run_at"                    = timestamp()
    }
    depends_on                      = [ null_resource.docker_tag ]
}