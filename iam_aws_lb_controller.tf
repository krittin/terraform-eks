data "aws_iam_policy_document" "aws_lb_controller_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks_oidc_provider.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks_oidc_provider.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "aws_lb_controller_role" {
  assume_role_policy = data.aws_iam_policy_document.aws_lb_controller_assume_role_policy.json
  name               = "AWSLoadBalancerControllerIAMRole"
}

resource "aws_iam_policy" "aws_lb_controller_policy" {
  policy = file("./iam_aws_lb_controller_policy.json")
  name   = "AWSLoadBalancerControllerIAMPolicy"
}

resource "aws_iam_role_policy_attachment" "aws_lb_controller_role_with_policy" {
  role       = aws_iam_role.aws_lb_controller_role.name
  policy_arn = aws_iam_policy.aws_lb_controller_policy.arn
}