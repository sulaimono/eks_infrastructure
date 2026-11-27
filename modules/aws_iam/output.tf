output "cluster_role_arn" {
  description = "Cluster level Iam roles for the project"
  value       = aws_iam_role.cluster.arn
}

output "node_role_arn" {
  description = "Node level roles within the cluster"
  value       = aws_iam_role.node.arn
}
