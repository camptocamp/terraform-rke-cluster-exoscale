terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    exoscale = {
      source = "exoscale/exoscale"
    }
  }
  required_version = ">= 0.13"
}
