resource "aws_eks_cluster" "test_cluster" {
    name    = var.cluster_name
    role_arn = aws_iam_role.eks_cluster_IAMrole.arn
    version = var.cluster_version

    vpc_config {
        subnet_ids = [aws_subnet.public-subnet1.id,aws_subnet.public-subnet2.id]
        endpoint_private_access = false
        endpoint_public_access = true
        public_access_cidrs = ["0.0.0.0/0"]
    }
    kubernetes_network_config {
        service_ipv4_cidr = "172.20.0.0/16"
    }
    enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
    depends_on = [aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy, aws_iam_role_policy_attachment.eks-AmazonEKSVPCResourceController]
    tags = {
        Environment = "telemetry"
        Name = "telemetry_cluster"
    }
} 