provider "aws" {
    region = var.aws_region
}

# Centralizar aquivo de controle de estado do terraform
terraform {
    backend "s3" {
        bucket = "terraform-state-igti-ronan"
        key = "state/igti/edc/mod1/terraform.state"
        region = "us-east-1"
    }
}