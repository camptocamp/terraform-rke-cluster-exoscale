terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    exoscale = {
      source = "terraform-providers/exoscale"
    }
    rke = {
      source = "rancher/rke"
    }
  }
  required_version = ">= 0.13"
}
