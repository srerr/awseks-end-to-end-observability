data "aws_partition" "current" {}
data "tls_certificate" "thumbprint" {
  url = aws_eks_cluster.test_cluster.identity[0].oidc[0].issuer
  depends_on = [ aws_eks_cluster.test_cluster ]
}
resource "aws_iam_openid_connect_provider" "oidc_provider" {
    url     = aws_eks_cluster.test_cluster.identity[0].oidc[0].issuer
    client_id_list  = ["sts.${data.aws_partition.current.dns_suffix}"]
    thumbprint_list = [data.tls_certificate.thumbprint.certificates[0].sha1_fingerprint]
    tags = {
        Environment = "telemetry"
        Name = "telemetry_oidc_provider"
    }
    depends_on = [ aws_eks_cluster.test_cluster ]
}
output "aws_iam_openid_connect_provider_arn" {
    value = aws_iam_openid_connect_provider.oidc_provider.arn
    description = "value of the OIDC provider ARN"
}
locals {
    aws_iam_oidc_connect_provider_extract_from_arn = element(split("oidc-provider/", "${aws_iam_openid_connect_provider.oidc_provider.arn}"), 1)
}
output "name_of_aws_iam_oidc_connect_provider" {
    value = local.aws_iam_oidc_connect_provider_extract_from_arn
    description = "Name of the OIDC provider"
}  