build {
   hcp_packer_registry {
    bucket_name = "debian-11-terraria"
    description = <<EOT
Terraria server base image based on Debian 11.
    EOT
    bucket_labels = {
      "maintained_by"    = "benjamin.lara"
      "os"               = "Debian",
      "os-version"       = "11",
      "terraria-version" = "1.4.4.9"
    }

    build_labels = {
      "build-time" = timestamp()
      "build-name" = "debian-11-terraria"
    }
  }

  sources = ["sources.googlecompute.terraria_debian_11"]

  provisioner "shell" {
    inline = [
      "sudo su"
    ]
  }

  provisioner "file" {
    source      = "${path.root}/terraria.service"
    destination = "/tmp/terraria.service"
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/terraria.service /etc/systemd/system/terraria.service"
    ]
  }

  provisioner "shell" {
    scripts = ["${path.root}/scripts/install-terraria-server.sh"]
  }

  provisioner "file" {
    source      = "${path.root}/config.txt"
    destination = "/tmp/config.txt"
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/config.txt /etc/terraria/config.txt"
    ]
  }

  provisioner "shell" {
    scripts = ["${path.cwd}/game-servers/scripts/create-service-user.sh"]
    execute_command = "chmod +x {{ .Path }}; {{ .Path }} -u terraria -p /etc/terraria"
  }
}
