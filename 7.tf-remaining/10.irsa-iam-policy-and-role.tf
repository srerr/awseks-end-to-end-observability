resource "aws_iam_role" "irsa_role" {
name = "telemetry_irsa_role"
assume_role_policy = jsonencode({
Version = "2012-10-17"
Statement = [
{
    Action = "sts:AssumeRoleWithWebIdentity"
    Effect = "Allow"
    Sid= ""
    Principal = {
        Federated = "${aws_iam_openid_connect_provider.oidc_provider.arn}"
    }
    Condition = {
        StringEquals = {
            "${local.aws_iam_oidc_connect_provider_extract_from_arn}:sub": "system:serviceaccount:default:irsa-demo-sa"
        }
    }
},
]

})
tags = {
Environment = "telemetry"
}
}
output "openid_connect_provider_extract_from_arn" {
value = local.aws_iam_oidc_connect_provider_extract_from_arn
description = "Name of the OIDC provider"
  
}
resource "aws_iam_role_policy_attachment" "irsa_iam_role_policy_attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.irsa_role.name
}
resource "aws_iam_role_policy_attachment" "irsa_aws_mysql_policy_attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  role       = aws_iam_role.irsa_role.name
}

output "irsa_iam_role_arn" {
  description = "IRSA Demo IAM Role ARN"
  value = aws_iam_role.irsa_role.arn
}
resource "aws_iam_role_policy_attachment" "ADOT-AmazonEKSServicePolicy1" {
    policy_arn = "arn:aws:iam::aws:policy/AWSXrayFullAccess"
    role       = aws_iam_role.irsa_role.name
  
}