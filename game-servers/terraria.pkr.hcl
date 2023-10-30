build {
  sources = ["sources.googlecompute.terraria_debian_11"]

  provisioner "shell" {
    inline = [
      "sudo su"
    ]
  }

  provisioner "file" {
    source      = "${path.root}/terraria/terraria.service"
    destination = "/tmp/terraria.service"
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/terraria.service /etc/systemd/system/terraria.service"
    ]
  }

  provisioner "shell" {
    scripts = ["${path.root}/terraria/scripts/install-terraria-server.sh"]
  }

  provisioner "file" {
    source      = "${path.root}/terraria/config.txt"
    destination = "/tmp/config.txt"
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/config.txt /etc/terraria/config.txt"
    ]
  }

  provisioner "shell" {
    scripts = ["${path.root}/scripts/create-service-user.sh"]
    execute_command = "chmod +x {{ .Path }}; {{ .Path }} -u terraria -p /etc/terraria"
  }
}