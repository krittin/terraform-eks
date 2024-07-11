data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.eks_cluster.name
}

provider "kubernetes" {
    host = aws_eks_cluster.eks_cluster.endpoint

    cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
    token = data.aws_eks_cluster_auth.eks.token
}

resource "kubernetes_service_account" "aws_lb_controller" {
  metadata {
    name = "aws-load-balancer-controller"
    annotations = {
        "eks.amazonaws.com/role-arn" = aws_iam_role.aws_lb_controller_role.arn
    }
    labels = {
        "app.kubernetes.io/managed-by" = "eksctl"
    }
    namespace = "kube-system"
    
  }

  depends_on = [ aws_eks_node_group.eks_node_group ]
}