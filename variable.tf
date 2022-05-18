# Profile is default
variable "profile" {
  type    = string
  default = "default"
}

#  Region us-east-1
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

#  availablity zone us-east-1
variable "aws_az" {
  type    = string
  default = "us-east-1a"
}

# External IP
variable "external_ip" {
  type    = string
  default = "0.0.0.0/0"
}

# instance type
variable "instance-type" {
  type    = string
  default = "t2.micro"
}


# Number of instances
variable "instance_count" {
  type    = number
  default = 2
}