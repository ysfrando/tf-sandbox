variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"

  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
    error_message = "Bucket name must be between 3 and 63 characters."
  }
}

variable "environment" {
  type        = string
  description = "Environment (prod, dev, staging)"

  validation {
    condition     = contains(["prod", "dev", "staging"], var.environment)
    error_message = "Environment must be prod, dev, or staging."
  }
}

variable "project_name" {
  type        = string
  description = "Name of the project"

  validation {
    condition     = length(var.project_name) >= 3 && length(var.project_name) <= 63
    error_message = "Project name must be between 3 and 63 characters."
  }
}

variable "vpc_id" {
  type = string
}

variable "allowed_ports" {
  type    = list(number)
  default = [22, 80, 443]
}

variable "allowed_cidrs" {
  type    = list(string)
  default = ["192.168.1.0/24"]
}

variable "allowed_security_groups" {
  type    = list(string)
  default = []
}