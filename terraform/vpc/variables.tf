variable "env" {}
variable "region" {}

variable "zones" {
  type    = "map"
  default = {
    zone0 = "eu-west-1a"
    zone1 = "eu-west-1b"
    zone2 = "eu-west-1c"
  }
}

variable "cidr_blocks" {
  type    = "list"
  default = [
      "10.0.0.0/22",
      "10.0.8.0/22",
      "10.0.16.0/22"
  ]
}

# 82.75.14.60/32 merlijn
variable "whitelisted_cidrs" {
  type        = "string"
  default     = "82.75.14.60/32"
  description = "Comma-separated list of cidr blocks"
}
