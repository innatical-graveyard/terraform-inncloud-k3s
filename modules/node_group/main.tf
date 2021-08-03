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
          "curl -sfL https://get.k3s.io | K3S_URL=https://${var.master_ip}:6443 K3S_TOKEN=${var.token} sh -"
      ]

        connection {
            type     = "ssh"
            user     = "root"
            host     = self.ip
        }
    }
}