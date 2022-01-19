#------------------ AWS provider variables ------------------#
region = "us-west-2"

# Resource tag settings to apply across all resources handled by AWS provider
common_tags = {
  Environment = "Dev"
  Project     = "EKS-Jenkins"
  Owner       = "Muthukumaran"
  Owner_email = "muthukumaranel@gmail.com"
}


#---------------------- VPC variables ----------------------#
vpc_name        = "eks-jenkins-us-west-tf"
cidr            = "10.0.0.0/16"
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.10.0/24", "10.0.11.0/24"]


#---------------------- EKS variables ----------------------#
cluster_name = "eks-jenkins-us-west-tf"

# To see more details about launch template parameters go to
# https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
eks_worker_groups_launch_template = [
  {
    name                 = "jenkins-worker-group-1"
    instance_type        = "t2.micro"
    asg_max_size         = 3
    asg_min_size         = 2
    asg_desired_capacity = 2
  },
  {
    name          = "jenkins-worker-group-2"
    instance_type = "t2.micro"
    asg_max_size  = 2
  }
]

map_users = [
  {
    userarn  = "arn:aws:iam::445425982647:user/k8s"
    username = "k8s"
    groups   = ["system:masters"]
  }
]
