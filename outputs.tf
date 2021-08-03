output "master_ip" {
  depends_on  = [inncloud_server.master]
  description = "Public IP Address of the master node"
  value       = inncloud_server.master.ip
}


output "nodes_ip" {
  depends_on  = [module.node_group]
  description = "Public IP Address of the worker nodes in groups"
  value = {
    for type, n in module.node_group :
    type => n.node_ip
  }
}