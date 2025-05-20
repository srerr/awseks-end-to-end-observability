terraform {
    required_version = "> 0.14"
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
        }
    }
    backend "s3" {
        bucket = "terraform-remote-state-ram"
        key = "terraform-state-files/terraform-infra-eks/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "terraform-infra-eks"
    }
}