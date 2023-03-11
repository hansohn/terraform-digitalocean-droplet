terraform {
  required_version = ">= 1.0.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.0.0"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">= 2.0.0"
    }

    http = {
      source  = "hashicorp/http"
      version = ">= 3.0.0"
    }
  }
}
