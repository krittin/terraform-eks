provider "helm" {
  kubernetes {
		host = aws_eks_cluster.eks_cluster.endpoint
		cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
		token = data.aws_eks_cluster_auth.eks.token
	}
}

resource "helm_release" "aws_lb_controller" {
	namespace = "kube-system"
	name = "aws-load-balancer-controller"
	repository = "https://aws.github.io/eks-charts"
	chart = "aws-load-balancer-controller"
	version = var.aws_lb_controller_helmchart_version

	set {
	  name = "clusterName"
	  value = aws_eks_cluster.eks_cluster.name
	}
	set {
	  name = "serviceAccount.create"
	  value = "false"
	}
	set {
	  name = "serviceAccount.name"
	  value = kubernetes_service_account.aws_lb_controller.metadata[0].name
	}
}