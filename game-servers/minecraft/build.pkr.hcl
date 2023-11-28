build {
   hcp_packer_registry {
    bucket_name = "debian-11-minecraft"
    description = <<EOT
Minecraft server base image based on Debian 11.
    EOT
    bucket_labels = {
      "maintained_by"     = "benjamin.lara"
      "os"                = "Debian",
      "os-version"        = "11",
      "minecraft-version" = "1.20.2",
      "paper-build"       = "259"
    }

    build_labels = {
      "build-time" = timestamp()
      "build-name" = "debian-11-minecraft"
    }
  }

  sources = ["sources.googlecompute.minecraft_debian_11"]

  provisioner "shell" {
    inline = [
      "sudo su"
    ]
  }

  provisioner "file" {
    source      = "${path.root}/minecraft.service"
    destination = "/tmp/minecraft.service"
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/minecraft.service /etc/systemd/system/minecraft.service"
    ]
  }

  provisioner "file" {
    source      = "${path.root}/server"
    destination = "/tmp/server"
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/server /etc/minecraft" 
    ]
  }

  provisioner "shell" {
    scripts = ["${path.root}/scripts/install-minecraft-server.sh"]
  }

  provisioner "shell" {
    scripts = ["${path.cwd}/game-servers/scripts/create-service-user.sh"]
    execute_command = "chmod +x {{ .Path }}; {{ .Path }} -u minecraft -p /etc/minecraft"
  }

  provisioner "shell" {
    scripts = ["${path.root}/scripts/crontab-setup.sh"]
  }

}
