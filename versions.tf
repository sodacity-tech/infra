terraform {
  required_version = ">= 1.9.8"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.49.1"
    }
  }
}
