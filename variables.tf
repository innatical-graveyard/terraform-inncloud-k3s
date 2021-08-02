variable "token" {
  description = "Innatical Cloud auth token"
}

variable "project_id" {
  description = "Innatical Cloud project id"
}

variable "cluster_name" {
  description = "Cluster name (prefix for all resource names)"
  default     = "inncloud"
}

variable "region" {
  description = "Region where resources will reside"
  default     = "LA1"
}

variable "master_model" {
  description = "Master node model"
  default     = "starter"
}

variable "node_groups" {
  description = "Map of worker node groups, key is model, value is count of nodes in group"
  type        = map(string)
  default = {
    "starter" = 1
  }
}

variable "cycle" {
    description = "The billing cycle for nodes"
    default = "month"
}