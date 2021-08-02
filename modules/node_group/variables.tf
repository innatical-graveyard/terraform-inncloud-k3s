variable "node_count" {
  description = "Count of nodes in group"
  default     = 1
}

variable "cluster_name" {
  description = "Cluster name (prefix for all resource names)"
  default     = "inncloud"
}

variable "region" {
  description = "Region where resources will reside"
  default     = "LA1"
}

variable "model" {
  description = "Model type"
  type = string
}

variable "cycle" {
    description = "The billing cycle for nodes"
    default = "month"
}

variable "master_ip" {
    description = "IP of the master node"
    type = string
}

variable "token" {
    description = "The K3s token"
    type = string
}