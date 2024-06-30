resource "aws_eks_cluster" "eks_cluster" {
  name = var.eks_cluster_name
  version = var.k8s_version
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.private_subnets[*].id
    endpoint_private_access = true
    endpoint_public_access =  true
    public_access_cidrs = var.my_private_cidrs
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.pod_cidr
  }
  
  depends_on = [ aws_iam_role_policy_attachment.eks_cluster_role_with_cluster_policy ]

}
