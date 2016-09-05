output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "vpc_private_cidr" {
  value = "${aws_vpc.main.cidr_block}"
}

output "default_sg_id" {
  value = "${aws_security_group.default.id}"
}

output "subnet_id_zones" {
  value = ["${aws_subnet.default.*.id}"]
}
