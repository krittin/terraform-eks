#-------------------------------------------------------------
# eks cluster
#-------------------------------------------------------------

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks_cluster_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role_with_cluster_policy" {
  role = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

#-------------------------------------------------------------
# eks node group
#-------------------------------------------------------------
resource "aws_iam_role" "eks_node_group_role" {
  name = "eks_node_group_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

#resource "aws_iam_role_policy_attachment" "eks_node_group_AmazonEKSWorkerNodePolicy"{
#  role = aws_iam_role.eks_node_group_role.name
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#}

#resource "aws_iam_role_policy_attachment" "eks_node_group_AmazonEKS_CNI_Policy"{
#  role = aws_iam_role.eks_node_group_role.name
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#}

#resource "aws_iam_role_policy_attachment" "eks_node_group_AmazonEC2ContainerRegistryReadOnly"{
#  role = aws_iam_role.eks_node_group_role.name
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#}

resource "aws_iam_role_policy_attachment" "eks_node_group_role_with_policies" {

  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ])

  role = aws_iam_role.eks_node_group_role.name
  policy_arn = each.value
}