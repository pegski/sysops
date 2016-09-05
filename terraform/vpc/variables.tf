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
      "10.0.1.0/23",
      "10.0.10.0/23",
      "10.0.12.0/23"
  ]
}

# 82.75.14.60/32 merlijn
# 37.44.9.70/32 merlijn, work
# 188.203.210.214/32 merlijn, swimmingpool
variable "whitelisted_cidrs" {
  type        = "string"
  default     = "82.75.14.60/32,37.44.9.70/32,188.203.210.214/32"
  description = "Comma-separated list of cidr blocks"
}
