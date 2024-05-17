variable "tag_name_kebab" {
  type = string
}

variable "public_subnet_1a_0_id" {
  type = string

}

variable "vpc_id" {
  type = string
}

variable "public_subnet" {
  type = string
}

variable "private_subnets_cidr_blocks" {
  type = list(string)
}

variable "private_route_table_ids" {
  type = list(string)
}
