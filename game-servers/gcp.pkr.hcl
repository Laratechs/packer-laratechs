packer {
  required_plugins {
    googlecompute = {
      version = ">= 1.1.1"
      source = "github.com/hashicorp/googlecompute"
    }
  }
}

source "googlecompute" "minecraft_debian_11" {
  project_id   = "game-svcs"
  ssh_username = "packer"
  region       = "us-east1"
  zone         = "us-east1-b"

  source_image_family = "laratechs-debian-11"
  image_family        = "laratechs-minecraft-debian-11"
  image_name          = "laratechs-minecraft-{{timestamp}}"

  subnetwork   = "packer"
}

source "googlecompute" "terraria_debian_11" {
  project_id   = "game-svcs"
  ssh_username = "packer"
  region       = "us-east1"
  zone         = "us-east1-b"

  source_image_family = "laratechs-debian-11"
  image_family        = "laratechs-terraria-debian-11"
  image_name          = "laratechs-terraria-{{timestamp}}"

  subnetwork   = "packer"
}
