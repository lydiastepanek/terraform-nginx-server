variable "vpc_name" {
  type    = "string"
  default = "my_production_test"
}

variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "key_name" {
  description = "EC2 instance key pair name"
  type        = "string"
  default     = "lydia"
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
