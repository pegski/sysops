provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_key_pair" "terraform-deployer" {
  key_name = "${var.key_name}"
  public_key = "${file("./ssh/terraform-deployer.pub")}"
}

module "vpc" {
  source      = "./vpc"
  region      = "${var.region}"
  env         = "${var.env}"
}
