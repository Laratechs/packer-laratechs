build {
  sources = ["sources.googlecompute.debian_11"]

  # Update packages and install security updates
  provisioner "shell" {
    scripts = ["scripts/update-packages.sh"]
  }

  # Install and configure logging agent
  provisioner "shell" {
    scripts = ["scripts/setup-google-stackdriver.sh"]
  }

  # Setup HashiCorp APT repository
  provisioner "shell" {
    scripts = ["scripts/setup-hashicorp-repo.sh"]
  }
}
