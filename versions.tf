terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    exoscale = {
      source = "exoscale/exoscale"
    }
    rke = {
      source = "rancher/rke"
    }
  }
  required_version = ">= 0.13"
}
