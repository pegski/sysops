variable "env" {}
variable "region" {}

variable "vpc_id" {}
variable "vpc_private_cidr" {}
variable "subnet_id_zones" {
  type = "list"
}
variable "cache_name" {}

variable "engine_version" {
  default = "2.8.22"
}

variable "instance_type" {
  default = "cache.t2.micro"
}

variable "maintenance_window" {
  default = "sun:05:00-sun:06:00"
}
