variable "ssh_key_name" {
  description = "The name of the SSH key pair to use for instances"
  type        = string
  default     = "Devops_key"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  default     = "ami-00bb6a80f01f03502"
}

