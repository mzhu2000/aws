variable "dynamodb_should_be_created" {
  description = "Should the Dynamodb be created?"
  type        = bool
  default     = true
}

variable "dynamodb_table" {
  description = "The Name of the Dynamodb Table"
  type        = string
  default     = "mzhu2000-terraform-locks"
}
