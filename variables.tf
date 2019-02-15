variable "vpc_name" {
  type    = "string"
  default = "my_production_test"
}

variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "ecs_cluster" {
  description = "ECS cluster name"
  default     = "my_ecs_cluster"
}

variable "key_name" {
  description = "EC2 instance key pair name"
  type        = "string"
  default     = "lydia"
}

variable "region" {
  description = "AWS region"
  default     = "us-east"
}

variable "desired_capacity" {
  description = "Desired number of instances in the cluster"
  default     = 1
}

variable "min_instance_size" {
  description = "Minimum number of instances in the cluster"
  default     = 1
}

variable "max_instance_size" {
  description = "Maximum number of instances in the cluster"
  default     = 1
}

variable "aws_user_key_path" {
  type    = "string"
  default = "/Users/lydiastepanek/.ec2/lydia.pem"
}

variable "app_server_SG_name" {
  type    = "string"
  default = "my_app_security_group"
}

variable "bastion_SG_name" {
  type    = "string"
  default = "my_bastion_security_group"
}

variable "bastion_server_ami" {
  type    = "string"
  default = "ami-0c7e0451fbe4a3b8a"
}

variable "app_server_ami" {
  type    = "string"
  default = "ami-0c9da1d34cb689bf6"
}
