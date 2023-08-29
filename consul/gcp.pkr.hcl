packer {
  required_plugins {
    googlecompute = {
      version = ">= 1.1.1"
      source = "github.com/hashicorp/googlecompute"
    }
  }
}

source "googlecompute" "debian_11" {
  project_id   = "dev-minecraft"
  ssh_username = "packer"
  region       = "us-east1"
  zone         = "us-east1-b"

  source_image_family = "laratechs-debian-11"
  image_family        = "laratechs-consul-debian-11"

  subnetwork   = "packer"
}
