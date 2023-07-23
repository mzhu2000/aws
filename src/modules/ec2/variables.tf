variable "ec2_should_be_created" {
  description = "Should the EC2 be created?"
  type        = bool
  default     = true
}

variable "ec2_name" {
  description = "The Name of the EC2"
  type        = string
  default     = "mzhu2000 EC2"
}

variable "ec2_security_group_name" {
  description = "The Name of the EC2 Security Group"
  type        = string
  default     = "mzhu2000 EC2 Security Group"
}

variable "ec2_security_group_description" {
  description = "The Description of the EC2 Security Group"
  type        = string
  default     = "mzhu2000 EC2 Security Group"
}

/* variable "ec2_ami" {
  description = "The Amazon Machine Image"
  type        = string
  default     = "ami-04610228df433d0c5" # AMZN2 Liunx (64-bit ARM) The latest build so far in 2023
} */

variable "ec2_instance_type" {
  description = "The EC2 Instance type"
  type        = string
  default     = "t4g.nano" # The smallest type for demo purpose only
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

/* variable "public_subnet_id" {
  description = "The ID of the Public Subnet"
  type        = string
} */

variable "private_subnet_id" {
  description = "The ID of the Private Subnet"
  type        = list(string)
}

variable "ec2_ssh_key_name" {
  description = "The SSH Key Name"
  type        = string
  default     = "mzhu2000-ec2-key"
}

variable "ec2_ssh_public_key_path" {
  description = "The local path to the SSH Public Key"
  type        = string
}
