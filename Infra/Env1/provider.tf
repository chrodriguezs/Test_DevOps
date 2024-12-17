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
            Environment = var.tag_environment
        }
	}
}