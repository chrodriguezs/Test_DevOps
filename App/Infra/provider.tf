terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "5.81.0"
        }
    }
}
provider "aws" {
    region              = var.region
    default_tags {
		tags = {
            Application = var.tag_application
            Environment = var.tag_environment
        }
	}
}