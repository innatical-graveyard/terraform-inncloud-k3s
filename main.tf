terraform {
  required_providers {
    inncloud = {
      source = "innatical/inncloud"
      version = "0.0.2"
    }
    local = {
      source = "hashicorp/local"
      version = "2.1.0"
    }
  }
}

provider "inncloud" {
    token = var.token
    project_id = var.project_id
}

resource "inncloud_server" "master" {
    name = "${var.cluster_name}-master"
    model = var.master_model
    image = "ubuntu-20.04"
    region = var.region
    cycle = var.cycle

    provisioner "remote-exec" {
      inline = [
        "curl -sfL https://get.k3s.io | sh -"
      ]

        connection {
            type     = "ssh"
            user     = "root"
            host     = inncloud_server.master.ip
        }
    }

     provisioner "local-exec" {
        command = "ssh -o StrictHostKeyChecking=no root@${inncloud_server.master.ip} 'cat /var/lib/rancher/k3s/server/node-token' > /tmp/k3s_token"
    }
}

data "local_file" "k3s_token" {
    filename = "/tmp/k3s_token"
    depends_on = [inncloud_server.master]
}

module "node_group" {
    source       = "./modules/node_group"
    cluster_name = var.cluster_name
    region   = var.region
    master_ip = inncloud_server.master.ip
    token = chomp(data.local_file.k3s_token.content)
    for_each   = var.node_groups
    model  = each.key
    node_count = each.value
    depends_on = [inncloud_server.master, data.local_file.k3s_token]
}
