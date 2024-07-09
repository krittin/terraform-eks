output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig_certificate_authority_data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "config_kubectl" {
  value = "aws eks update-kubeconfig --region ${var.aws_region} --name ${var.eks_cluster_name}"
}