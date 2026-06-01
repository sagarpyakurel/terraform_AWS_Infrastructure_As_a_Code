#provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

#configure aws provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "sagar-vpc"{
  cidr_block= "10.0.0.0/16"
}