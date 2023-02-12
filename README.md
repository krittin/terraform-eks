# Terraform configuration for building an AWS EKS cluster

This configuration creates an EKS cluster and a node group that span across 3 availability zones in configurable region.

# Prerequisites


- AWS CLI, this code is tested on version 2.9.21 
- AWS S3 bucket to store Terraform statefile 
- AWS IAM user under which this Terraform configuration will be run
  - Configured as AWS CLI profile (see [instruction](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html))
  - Assigned with S3 bucket permissions (see [the detail](https://developer.hashicorp.com/terraform/language/settings/backends/s3#s3-bucket-permissions))
- Terraform version 1.3.7 or above

# Usage
| Warning:  AWS charges $0.10 per hour for each EKS cluster so you will incur some charges, see [EKS pricing page](https://aws.amazon.com/eks/pricing/)|
| - |
1. Create backend.tfvars to store statefile in the S3 bucket
```
bucket = "<your bucket name>"
key = "terraform.tfstate"
region = "<your AWS region>"
```
2. Do Terraform init with the backend.tfvars
```
terraform init -backend-config=backend.tfvars
```
3. Configure parameters ([variables.tf](variables.tf)) in a variable file
4. And the usuals
```
terraform plan -var-file=$YOUR_VAR_FILES
terraform apply -var-file=$YOUR_VAR_FILES
```
5. Point your kubectl to the cluser
```
aws eks update-kubeconfig --region $YOUR_AWS_REGION --name $YOUR_EKS_CLUSTER_NAME
```
