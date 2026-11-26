resource "aws_eks_cluster" "this" {
  name = "${var.project_name}-cluster"

  access_config {
    authentication_mode = "API"
  }

  role_arn = var.cluster_role_arn
  version  = var.kubernetes_version

  bootstrap_self_managed_addons = false

  compute_config {
    enabled       = true
    node_pools    = ["general-purpose"]
    node_role_arn = var.node_role_arn
  }

  storage_config {
    block_storage { enabled = true }
  }

  kubernetes_network_config {
    elastic_load_balancing {
      enabled = true
    }
  }

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = false

    subnet_ids = [
      var.priv_subnet1,
      var.priv_subnet2,
    ]
  }
}
