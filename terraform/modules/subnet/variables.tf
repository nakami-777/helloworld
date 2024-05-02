variable "tag_name" {
  type = string
}

variable "default_availability_zone" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_name" {
  type    = string
  default = "private_subnet"
}

variable "public_subnet_name" {
  type    = string
  default = "public_subnet"
}

variable "public_subnet_0_cidr" {
  type = string
}

variable "private_subnet_0_cidr" {
  type = string
}

variable "private_subnet_1_cidr" {
  type = string
}
