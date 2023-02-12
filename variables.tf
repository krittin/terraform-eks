variable "aws_profile" {
  type = string
  description = "AWS profile set up for AWS CLI"
}

variable "aws_region" {
  type = string
  default = "eu-west-2"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
 type = list(string)
 default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}


variable "public_subnet_cidrs" {
 type = list(string)
 default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
 
variable "eks_cluster_name" {
  type = string
  default = "eks_cluster1"
}

variable "k8s_version" {
  type = string
  description = "Version of Kubernetes to run on EKS"
  default = "1.24"
}

variable "pod_cidr" {
  type = string
  description = "CIDR block for pods on EKS cluster"
  default = "172.20.0.0/16"
}

variable "worker_instance_types" {
  type = list(string)
  description = "List of instance types of the worker nodes"
  # Please see this guide https://docs.aws.amazon.com/eks/latest/userguide/choosing-instance-type.html
  default = [ "t3.medium" ]
}

variable "worker_count" {
  type = number
  description = "Number of worker nodes"
  default = 3
}

variable "worker_min" {
  type = number
  description = "Minimum number of worker nodes for Autoscaling"
  default = 1
}

variable "worker_max" {
  type = number
  description = "Maximum number of worker nodes for Autoscaling"
  default = 5
}

