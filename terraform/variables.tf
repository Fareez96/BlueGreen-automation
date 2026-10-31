variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "my_ip" {
  type        = string
  description = "Your public IP in CIDR form, e.g. 203.0.113.5/32"
}

variable "project_name" {
  type    = string
  default = "bluegreen"
}
