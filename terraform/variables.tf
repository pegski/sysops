variable "access_key" {
  type = "string"
}

variable "secret_key" {
  type = "string"
}

# the name of the AWS keypair (will be created in ec2), make sure you own the
# private key of this keypar
variable "key_name" {
  type    = "string"
  default = "merlijn"
}

# path to the local public key of the AWS keypair which will be uploaded to ec2
variable "public_key_path" {
  type    = "string"
}

variable "region" {
  type    = "string"
  default = "eu-west-1"
}

variable "env" {
  type        = "string"
  default     = "dev"
  description = "The environment of this infrastructure. Choose from dev, acc and prod"
}

variable "zones" {
  type    = "map"
  default = {
    zone0 = "eu-west-1a"
    zone1 = "eu-west-1b"
    zone2 = "eu-west-1c"
  }
}
