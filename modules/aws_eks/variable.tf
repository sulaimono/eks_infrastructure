variable "project_name" {
  description = "The Name of the Project"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS"
  type        = string
}

variable "priv_subnet1" {
  description = "1st Private subnet for the EKS"
  type        = string
}

variable "priv_subnet2" {
  description = "2nd Private subnet for the EKS"
  type        = string
}

variable "node_role_arn" {
  description = "Node level Iam role within the cluster"
  type        = string
}

variable "cluster_role_arn" {
  description = "Cluster level Iam role for the project"
  type        = string
}
