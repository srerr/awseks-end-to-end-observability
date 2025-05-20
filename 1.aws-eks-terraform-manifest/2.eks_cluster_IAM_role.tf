resource "aws_iam_role" "eks_cluster_IAMrole" {
    name = "eks_cluster_IAMrole"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSClusterPolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role       = aws_iam_role.eks_cluster_IAMrole.name
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSVPCResourceController" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
    role       = aws_iam_role.eks_cluster_IAMrole.name
}
resource "aws_iam_role_policy_attachment" "ADOT-AmazonEKSServicePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AWSXrayFullAccess"
    role       = aws_iam_role.eks_cluster_IAMrole.name
  
}
