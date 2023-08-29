build {
  sources = ["sources.googlecompute.debian_11"]
  provisioner "shell" {
    inline = ["echo foo"]
  }
}
