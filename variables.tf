variable "cluster_name" { 
    type = string
    default="test" 
}
variable "env_name" {
    type = string
    default="dev" 
}
variable "aws_region" {
    type = string 
    default="us-east-1" 
}
variable "vpc_id" {
}
variable "eks_version" { 
    default="1.23" 
}
variable "min_no_node" { 
    type = number
    default= 1 
}
variable "max_no_node" { 
    type = number
    default= 2 
}
variable "subnet_id" {
    type=list(string)
}
variable "ovverride_nodepool_type" {
    type=list(string)
}
variable "nodepool_type" {
    type=list(string)
}