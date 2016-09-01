variable "env" {}
variable "region" {}
variable "key_name" {}

variable "vpc_id" {}
variable "default_sg_id" {}
variable "subnet_id_zones" {
  type = "list"
}

variable "amis" {
  type    = "map"
  default = {
    #    eu-west-1 = "ami-ee6b189d" 16.04 LTS needs fixing for python2.7 missing
    eu-west-1 = "ami-55452e26" # 14.04 LTS

  }
}

variable "zones" {
  type    = "map"
  default = {
    zone0 = "eu-west-1a"
    zone1 = "eu-west-1b"
    zone2 = "eu-west-1c"
  }
}

variable "dockernode_count" {
  type    = "string"
  default = "1"
}
