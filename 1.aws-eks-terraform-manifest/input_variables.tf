variable "cluster_name" {
    description = "The name of the EKS cluster"
    type        = string
    default = "telemetry_cluster"
  
}
#variable "role_arn" {
#    description = "The ARN of the IAM role to use for the EKS cluster"
#    type        = string
#}

#variable "subnet_ids" {
#    description = "A list of subnet IDs for the EKS cluster"
#    type        = list(string)
#}
variable "cluster_version" {
    description = "The Kubernetes version for the EKS cluster"
    type        = string
    default = "1.31"
}
/*variable "eks_oidc_root_ca_thumbprint" {
  type        = string
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}*/