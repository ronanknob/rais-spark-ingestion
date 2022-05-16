provider "aws" {
    region = var.aws_region
}

# Centralizar aquivo de controle de estado do terraform
terraform {
    backend "s3" {
        bucket = "desafio-mod-1"
        key = "terraform-state/terraform.state"
        region = "us-east-1"
    }
}