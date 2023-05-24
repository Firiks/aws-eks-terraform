provider "aws" {
  region = "eu-central-1"
}

terraform {
  required_providers {
    kubectl = { # select kubectl provider
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }

    helm = { # select helm provider
      source = "hashicorp/helm"
      version = "2.6.0"
    }

  }

  required_version = "~> 1.0" # select terraform version
}
