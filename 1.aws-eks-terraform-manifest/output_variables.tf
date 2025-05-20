output "cluster_id" {
    description = "value of the EKS cluster id"
    value = aws_eks_cluster.test_cluster.id
}
output "cluster_arn" {
    description = "value of the EKS cluster arn"
    value = aws_eks_cluster.test_cluster.arn
}
output "cluster_certificate_authority_data" {
    description = "value of the EKS cluster certificate authority data"
    value = aws_eks_cluster.test_cluster.certificate_authority.0.data
}
output "cluster_endpoint" {
    description = "value of the EKS cluster endpoint"
    value = aws_eks_cluster.test_cluster.endpoint
}
output "cluster_version" {
    description = "value of the EKS cluster version"
    value = aws_eks_cluster.test_cluster.version
}
output "cluster_iam_role_name" {
    description = "value of the EKS cluster IAM role name"
    value = aws_iam_role.eks_cluster_IAMrole.name
}
output "cluster_iam_role_arn" {
    description = "value of the EKS cluster IAM role arn"
    value = aws_iam_role.eks_cluster_IAMrole.arn
}
output "cluster_oidc_provider_arn" {
    description = "value of the EKS cluster OIDC provider arn"
    value = aws_eks_cluster.test_cluster.identity.0.oidc.0.issuer
}
output "cluster_oidc_provider_url" {
    description = "value of the EKS cluster OIDC provider url"
    value = aws_eks_cluster.test_cluster.identity[0].oidc[0].issuer
}
output "cluster_security_group_id" {
    description = "value of the EKS cluster security group id"
    value = aws_eks_cluster.test_cluster.vpc_config[0].cluster_security_group_id
}
/*
output "thumbprint_list" {
    description = "value of the thumbprint list"
    value = data.tls_certificate.thumbprint.certificates[0].sha1_fingerprint
  
}
*/
#node group outputs

output "node_group_id" {
    description = "value of the EKS node group id"
    value = aws_eks_node_group.telemetry-eks-ng.id
}
output "name_group_arn" {
    description = "value of the EKS node group arn"
    value = aws_eks_node_group.telemetry-eks-ng.arn
}
output "name_group_cluster_name" {
    description = "value of the EKS node group cluster name"
    value = aws_eks_node_group.telemetry-eks-ng.cluster_name
}

#s3 bucket outputs
/*
output "bucket_domain_name" {
    description = "s3 bucket domain name"
    value = aws_s3_bucket.media_static_bucket.bucket_domain_name
}
output "bucket_regional_domain_name" {
    description = "s3 bucket regional domain name"
    value = aws_s3_bucket.media_static_bucket.bucket_regional_domain_name
}
output "s3_region" {
    description = "s3 bucket region"
    value = aws_s3_bucket.media_static_bucket.region
}
output "name_s3_bucket" {
    description = "s3 bucket name"
    value = aws_s3_bucket.media_static_bucket.id
}
*/
#rds outputs give the db endpoint and port to connect to the db from the application NAME ,USER, PASSWORD 
/*
output "db_endpoint" {
    description = "db endpoint"
    value = aws_db_instance.mysql.endpoint
}
output "db_port" {
    description = "db port"
    value = aws_db_instance.mysql.port
}
output "db_name" {
    description = "db name"
    value = aws_db_instance.mysql.name
}
output "db_username" {
    description = "db username"
    value = aws_db_instance.mysql.username
}
output "db_password" {
    description = "db password"
    sensitive = true
    value = aws_db_instance.mysql.password
}
*/