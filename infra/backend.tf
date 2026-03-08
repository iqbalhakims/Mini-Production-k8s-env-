terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }

  cloud {
    organization = "iqbal-hakim"

    workspaces {
      name = "Mini-Production-k8s-env-"
    }
  }
}