module "App" {
  source = "../Infra"

  #Provider variables
  region          = "eu-west-1"
  tag_application = "simple-app2"
  tag_environment = "Env1"

  #ALB Variables
  container_port = 1081
}

