terraform {
  required_version = ">=1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.48.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.4.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.2.0"
    }
  }
}

#Defining providers specification
provider "aws" {
  region = var.region

  default_tags {
    tags = var.common_tags
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
