terraform {
  required_providers {
    twc = {
      source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }
  }
  required_version = ">= 1.4.4"
}

provider "twc" {
  token = var.twc_token
}

data "twc_os" "os" {
  name    = var.os_name
  version = var.os_version
}

data "twc_configurator" "configurator" {
  location = var.location
}

resource "twc_ssh_key" "your_key" {
  name = var.ssh_key_name
  body = file(var.ssh_public_key_path)
}

resource "twc_server" "jenkins" {
  depends_on = [twc_ssh_key.your_key]

  name         = var.server_name
  os_id        = data.twc_os.os.id
  ssh_keys_ids = [twc_ssh_key.your_key.id]

  configuration {
    configurator_id = data.twc_configurator.configurator.id
    disk            = var.disk_size
    cpu             = var.cpu_count
    ram             = var.ram_size
  }
}

resource "twc_server_ip" "ext_ip" {
  source_server_id = twc_server.jenkins.id
  type             = "ipv4"

  provisioner "remote-exec" {
    inline = [
      "sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key",
      "echo \"deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/\" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-11-jdk",
      "sudo apt-get install -y jenkins",
      "sudo systemctl enable jenkins",
      "sudo systemctl start jenkins"
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = twc_server_ip.ext_ip.ip
    }
  }
}