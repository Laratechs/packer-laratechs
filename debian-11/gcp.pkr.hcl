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
  source_image = "debian-11-bullseye-v20230814"
  ssh_username = "packer"
  region       = "us-east1"
  zone         = "us-east1-b"
  image_family = "laratechs-debian-11"
  subnetwork   = "packer"
  image_name   = "laratechs-debian-11-{{timestamp}}"
}
