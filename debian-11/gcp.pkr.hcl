source "googlecompute" "debian_11" {
  project_id   = "game-svcs"
  source_image = "debian-11-bullseye-v20231010"
  ssh_username = "packer"
  region       = "us-east1"
  zone         = "us-east1-b"
  image_family = "laratechs-debian-11"
  subnetwork   = "packer"
  image_name   = "laratechs-debian-11-{{timestamp}}"
}
