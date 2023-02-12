resource "aws_eks_node_group" "eks_node_group" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.eks_cluster_name}_node_group"
  node_role_arn = aws_iam_role.eks_node_group_role.arn

  subnet_ids = aws_subnet.private_subnets[*].id

  capacity_type = "ON_DEMAND"
  instance_types = var.worker_instance_types

  scaling_config {
    desired_size = var.worker_count
    min_size = var.worker_min
    max_size = var.worker_max
  }

  update_config {
    max_unavailable = 1
  }

#  depends_on = [
#    aws_iam_role_policy_attachment.eks_node_group_AmazonEKSWorkerNodePolicy,
#    aws_iam_role_policy_attachment.eks_node_group_AmazonEKS_CNI_Policy,
#    aws_iam_role_policy_attachment.eks_node_group_AmazonEC2ContainerRegistryReadOnly,
#  ]
    depends_on = [ aws_iam_role_policy_attachment.eks_node_group_role_with_policies ]
}