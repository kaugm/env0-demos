variable "vpc_id" {
  type = string
  default = "vpc-0c897a2a53d947af6"
}

# Add more policies to list to be applied
variable "managed_policy_arns" {
  description = "List of AWS managed policy ARNs to attach to the EC2 IAM role"
  type        = list(string)
  default     = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
}

# Add more egress rules to be applied
variable "egress_rules" {
  description = "List of egress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["10.10.10.11/32"]
    }
  ]
}
