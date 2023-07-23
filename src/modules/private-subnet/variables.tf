/* variable "private_subnet0_should_be_created" {
  description = "Should the Private Subnet0 be created?"
  type        = bool
  default     = true
}

variable "private_subnet0_name" {
  description = "The Name of the Private Subnet0"
  type        = string
  default     = "mzhu2000 Private Subnet0"
}

variable "private_subnet0_cidr_block" {
  description = "The IPv4 CIDR block of the Private Subnet0"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet0_availability_zone" {
  description = "The Availability Zone of the Private Subnet0"
  type        = string
  default     = "us-east-1b"
}

variable "private_subnet1_should_be_created" {
  description = "Should the Private Subnet1 be created?"
  type        = bool
  default     = true
}

variable "private_subnet1_name" {
  description = "The Name of the Private Subnet1"
  type        = string
  default     = "mzhu2000 Private Subnet1"
}

variable "private_subnet1_cidr_block" {
  description = "The IPv4 CIDR block of the Private Subnet1"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet1_availability_zone" {
  description = "The Availability Zone of the Private Subnet1"
  type        = string
  default     = "us-east-1c"
} */


variable "p-subnets" {
   type = map
   default = {
      p-subnet-1 = {
         az = "use1-az2"
         cidr = "10.0.2.0/24"
      }
      p-subnet-2 = {
         az = "use1-az3"
         cidr = "10.0.3.0/24"
      }
   }
}

variable "private_subnet_name" {
  description = "The Name of the Private Subnet"
  type        = string
  default     = "mzhu2000 Private Subnet"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
