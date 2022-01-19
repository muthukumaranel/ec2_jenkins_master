#------------- AWS provider variabels -------------#
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = ""
}

variable "common_tags" {
  description = "Tags for all AWS provided resources"
  type        = map(string)
  default     = {}
}

#------------- VPC Variables -------------#
variable "vpc_name" {
  description = "Name to be used on VPC"
  type        = string
  default     = ""
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}


#------------- EKS Variables -------------#
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = ""
}

variable "eks_worker_groups_launch_template" {
  description = "A list of maps defining worker group configurations to be defined using AWS Launch Templates."
  type        = any
  default     = []
}

variable "map_users" {
  description = "IAM users to add to the aws-auth ConfigMap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}
