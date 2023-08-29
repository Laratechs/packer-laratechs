build {
  sources = ["sources.googlecompute.debian_11"]
  provisioner "shell" {
    scripts = ["scripts/debian.sh", "scripts/setup-hashicorp-repo.sh"]
  }
}
