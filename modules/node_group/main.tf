terraform {
  required_providers {
    inncloud = {
      source = "innatical/inncloud"
      version = "0.0.2"
    }
  }
}

resource "inncloud_server" "node" {
    count       = var.node_count
    name        = "${var.cluster_name}-${var.model}-${count.index}"
    model       = var.model
    region      = var.region
    image       = "ubuntu-20.04"
    cycle       = var.cycle

    provisioner "remote-exec" {
      inline = [
          "apt install -y curl",
          "mkdir /etc/systemd/system/k3s-agent.service.d",
          "echo '[Service]\nExecStart=\nExecStart=-/usr/local/bin/k3s agent --snapshotter native' > /etc/systemd/system/k3s-agent.service.d/override.conf",
          "curl -sfL https://get.k3s.io | K3S_URL=https://${var.master_ip}:6443 K3S_TOKEN=${var.token} sh -"
      ]

        connection {
            type     = "ssh"
            user     = "root"
            host     = self.ip
        }
    }
}