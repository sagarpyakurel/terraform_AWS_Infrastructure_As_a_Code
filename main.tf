terraform {
  cloud {
    organization = "SagarPyakurelOrganization"
    workspaces {
      project = "SagarPyakurelProject"
      name    = "SagarPyakurelWorkspace"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

#configure aws provider
provider "aws" {
  region = "us-east-2"
  profile= "personal"
}


