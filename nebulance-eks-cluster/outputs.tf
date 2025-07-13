output "cluster_name" {
  value =  module.eks.cluster_name
}

output "kubeconfig" {
  value = module.eks.kubeconfig
  sensitive = true
}

output "node_group_role_arn" {
  value = module.eks.eks_managed_node_groups["default"].iam_role_arn
}
