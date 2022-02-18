terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.4.1"
    }
  }
}

variable "kubehost" {
  type = string
}

variable "kubeclientcert" {
  type = string
}

variable "kubeclientkey" {
  type = string
}

variable "kubeclustercert" {
  type = string
}

resource helm_release iwok8scollector {
  name       = "iwok8scollector"
  namespace = "default"
  chart = "https://github.com/CiscodCloud/helm_chart/raw/main/iwok8scollector-0.6.2.tgz"

  set {
    name  = "iwoServerVersion"
    value = "8.0"
  }
  set {
    name  = "collectorImage.tag"
    value = "8.0.6"
  }
    set {
    name  = "targetName"
    value = "saukotha-k8s"
  }
}

provider "helm" {
  kubernetes {
    host = var.kubehost
    client_certificate = base64decode(var.kubeclientcert)
    client_key = base64decode(var.kubeclientkey)
    cluster_ca_certificate = base64decode(var.kubeclustercert)
  }
}
