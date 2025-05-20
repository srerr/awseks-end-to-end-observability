## setting terraform remote storage and remote state locking:
# -----------------------------------------------------------
## Step-01: Introduction
- Understand Terraform Backends
- Understand about Remote State Storage and its advantages
- This state is stored by default in a local file named "terraform.tfstate", but it can also be stored remotely, which works better in a team environment.
- Create AWS S3 bucket to store `terraform.tfstate` file and enable backend configurations in terraform settings block
- Understand about **State Locking** and its advantages
- Create DynamoDB Table and  implement State Locking by enabling the same in Terraform backend configuration

## Step-02: Create S3 Bucket
- Go to Services -> S3 -> Create Bucket
- **Bucket name:** terraform-on-aws-eks
- **Region:** US-East (N.Virginia)
- **Bucket settings for Block Public Access:** leave to defaults
- **Bucket Versioning:** Enable
- Rest all leave to **defaults**
- Click on **Create Bucket**
- **Create Folder**
  - **Folder Name:** dev
  - Click on **Create Folder**
- **Create Folder**
  - **Folder Name:** dev/eks-cluster
  - Click on **Create Folder**  
- **Create Folder**
  - **Folder Name:** dev/app1k8s
  - Click on **Create Folder**    


## Step-03: EKS Cluster: Terraform Backend Configuration
- Terraform Backend as S3: https://www.terraform.io/docs/language/settings/backends/s3.html

  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-on-aws-eks"
    key    = "dev/eks-cluster/terraform.tfstate"
    region = "us-east-1" 
 
    # For State Locking
    dynamodb_table = "dev-ekscluster"    
  }  

## Step-04: terraform.tfvars
# Generic Variables
aws_region = "us-east-1"
environment = "dev"
business_divsion = "hr"

## Step-05: Add State Locking Feature using DynamoDB Table
- Understand about Terraform State Locking Advantages
### Step-05-01: EKS Cluster DynamoDB Table
- Create Dynamo DB Table for EKS Cluster
  - **Table Name:** dev-ekscluster
  - **Partition key (Primary Key):** LockID (Type as String)
  - **Table settings:** Use default settings (checked)
  - Click on **Create**
### Step-05-02: App1 Kubernetes DynamoDB Table
- Create Dynamo DB Table for app1k8s
  - **Table Name:** dev-app1k8s
  - **Partition key (Primary Key):** LockID (Type as String)
  - **Table settings:** Use default settings (checked)
  - Click on **Create**
# Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "terraform-on-aws-eks"
    key    = "dev/app1k8s/terraform.tfstate"
    region = "us-east-1" 

    # For State Locking
    dynamodb_table = "dev-app1k8s"    
  }   


## removing ns forcefully:
--------------------------
->kubectl get namespace observability -o json > ns.json
->Open ns.json in a text editor and remove or empty the finalizers field under .spec.finalizers.

From this:

json
Copy
Edit
"spec": {
  "finalizers": ["kubernetes"]
}
->kubectl replace --raw "/api/v1/namespaces/observability/finalize" -f ./ns.json
https://www.linkedin.com/pulse/building-observability-aws-eks-my-recent-project-sreeram-guguloth-3dwuc