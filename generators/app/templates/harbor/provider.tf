terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }
    harbor = {
      source  = "goharbor/harbor"
      version = "3.10.8"
    }

  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "harbor" {
  url = var.harbor_url
  username = "admin"
  password = "Harbor12345"
}
