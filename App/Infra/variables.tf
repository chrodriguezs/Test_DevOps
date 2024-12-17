#Provider variables
variable "region" {
  description = "Main region for all resources"
  type        = string
}

variable "tag_application" {
  description = "Tag for application Name"
  type        = string
}

variable "tag_environment" {
  description = "Tag for environment"
  type        = string
}

#ALB Variables
variable "container_port" {
  description = "Port that needs to be exposed for the application"
}