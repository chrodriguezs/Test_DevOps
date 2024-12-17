#Provider variables
variable "region" {
  description = "Main region for all resources"
  type        = string
}

variable "tag_environment" {
  description = "Tag for environment"
  type        = string
}

#VPC variables
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the main VPC"
}

variable "public_subnet_1" {
  type        = string
  description = "CIDR block for public subnet 1"
}

variable "public_subnet_2" {
  type        = string
  description = "CIDR block for public subnet 2"
}

variable "private_subnet_1" {
  type        = string
  description = "CIDR block for private subnet 1"
}

variable "private_subnet_2" {
  type        = string
  description = "CIDR block for private subnet 2"
}

variable "availibilty_zone_1" {
  type        = string
  description = "First availibility zone"
}

variable "availibilty_zone_2" {
  type        = string
  description = "Second availibility zone"
}

#DynamoDB Variables
variable "DynamoDB_name" {
  type        = string
  description = "DynamoDB Name"
}


#ECR variables
variable "repository_name" {
  type        = string
  description = "Respository Name"
}

#ECS variables
variable "ECS_name" {
  type        = string
  default     = "ECS Name"
}


  