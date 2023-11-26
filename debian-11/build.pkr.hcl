build {
   hcp_packer_registry {
    bucket_name = "debian-11-base"
    description = <<EOT
Debian 11 base image for servers.
    EOT
    bucket_labels = {
      "maintained_by" = "benjamin.lara"
      "os"            = "Debian",
      "version"       = "11",
    }

    build_labels = {
      "build-time" = timestamp()
      "build-name" = "debian-11-base"
    }
  }

  sources = ["sources.googlecompute.debian_11"]

  # Setup HashiCorp APT repository
  provisioner "shell" {
    scripts = ["${path.root}/scripts/setup-hashicorp-repo.sh"]
  }

  # Update packages and install security updates
  provisioner "shell" {
    scripts = ["${path.root}/scripts/update-packages.sh"]
  }

  # Install Google Cloud SDK
  provisioner "shell" {
    scripts = ["${path.root}/scripts/install-google-cloud-sdk.sh"]
  }

  # Install and configure logging agent
  provisioner "shell" {
    scripts = ["${path.root}/scripts/setup-google-stackdriver.sh"]
  }
}
