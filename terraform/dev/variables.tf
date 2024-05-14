variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "aws_profile" {
  type    = string
  default = "654654549333_AdministratorAccess"
}

variable "tag_name" {
  type    = string
  default = "helloworld_dev"
}

variable "tag_name_kebab" {
  type    = string
  default = "helloworld-dev"
}

variable "availability_zone_1a" {
  type    = string
  default = "ap-northeast-1a"
}

variable "availability_zone_1c" {
  type    = string
  default = "ap-northeast-1c"
}
