packer {
  required_plugins {
    googlecompute = {
      version = ">= 1.1.1"
      source = "github.com/hashicorp/googlecompute"
    }
  }
}

data "hcp-packer-image" "debian-11-base" {
  bucket_name     = "debian-11-base"
  channel         = "latest"
  cloud_provider  = "gce"
  region          = "us-east1-b"
}

source "googlecompute" "terraria_debian_11" {
  project_id   = "game-svcs"
  ssh_username = "packer"
  region       = "us-east1"
  zone         = "us-east1-b"
  source_image = data.hcp-packer-image.debian-11-base.id 
  image_family = "laratechs-terraria-debian-11"
  image_name   = "laratechs-terraria-{{timestamp}}"
  subnetwork   = "packer"
}
