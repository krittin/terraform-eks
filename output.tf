output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "config_kubectl" {
  value = "aws eks update-kubeconfig --region ${var.aws_region} --name ${var.eks_cluster_name}"
}