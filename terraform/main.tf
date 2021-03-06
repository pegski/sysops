provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_key_pair" "terraform-deployer" {
  key_name = "${var.key_name}"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

module "vpc" {
  source      = "./vpc"
  region      = "${var.region}"
  env         = "${var.env}"
}

module "loadbalancers" {
  source = "./loadbalancers"

  env             = "${var.env}"
  region          = "${var.region}"
  zones           = "${var.zones}"
  key_name        = "${aws_key_pair.terraform-deployer.id}"

  vpc_id          = "${module.vpc.vpc_id}"
  default_sg_id   = "${module.vpc.default_sg_id}"
  subnet_id_zones = "${module.vpc.subnet_id_zones}"
}

module "dockernodes" {
  source = "./dockernodes"

  env             = "${var.env}"
  region          = "${var.region}"
  zones           = "${var.zones}"
  key_name        = "${aws_key_pair.terraform-deployer.id}"

  vpc_id          = "${module.vpc.vpc_id}"
  default_sg_id   = "${module.vpc.default_sg_id}"
  subnet_id_zones = "${module.vpc.subnet_id_zones}"
}

module "mongodbnodes" {
  source = "./mongodb"

  env             = "${var.env}"
  region          = "${var.region}"
  zones           = "${var.zones}"
  key_name        = "${aws_key_pair.terraform-deployer.id}"

  vpc_id           = "${module.vpc.vpc_id}"
  vpc_private_cidr = "${module.vpc.vpc_private_cidr}"
  default_sg_id    = "${module.vpc.default_sg_id}"
  subnet_id_zones  = "${module.vpc.subnet_id_zones}"
}

module "rediscluster" {
  source = "./redis"

  env              = "${var.env}"
  region           = "${var.region}"
  vpc_id           = "${module.vpc.vpc_id}"
  vpc_private_cidr = "${module.vpc.vpc_private_cidr}"
  subnet_id_zones  = "${module.vpc.subnet_id_zones}"

  cache_name = "redis-cache"
  engine_version = "2.8.22"
  instance_type = "cache.t2.micro"
  maintenance_window = "sun:05:00-sun:06:00"

}
