build {
  sources = ["sources.googlecompute.minecraft_debian_11"]

  provisioner "shell" {
    inline = [
      "sudo su"
    ]
  }

  provisioner "file" {
    source      = "${path.root}/minecraft/minecraft.service"
    destination = "/tmp/minecraft.service"
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/minecraft.service /etc/systemd/system/minecraft.service"
    ]
  }

  provisioner "file" {
    source      = "${path.root}/minecraft/server"
    destination = "/tmp/server"
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/server /etc/minecraft" 
    ]
  }

  provisioner "shell" {
    scripts = ["${path.root}/minecraft/scripts/install-minecraft-server.sh"]
  }

  provisioner "shell" {
    scripts = ["${path.root}/scripts/create-service-user.sh"]
    execute_command = "chmod +x {{ .Path }}; {{ .Path }} -u minecraft -p /etc/minecraft"
  }
}
