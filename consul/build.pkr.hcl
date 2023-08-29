build {
  sources = ["sources.googlecompute.debian_11"]
  provisioner "shell" {
    scripts = ["scripts/consul.sh"]
  }
}
