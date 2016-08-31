resource "aws_security_group" "web" {
  name        = "web_security_group"
  description = "Allowing access to web ports "
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    self      = true
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    self      = true
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "haproxy" {
  # Loop the amount of instances
  count = "${var.haproxy_count}"

  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.nano"
  key_name      = "${var.key_name}"

  vpc_security_group_ids = [
    "${var.default_sg_id}",
    "${aws_security_group.web.id}"
  ]

  subnet_id = "${var.subnet_id_zones[count.index]}"
  user_data = "${file("${path.module}/../cloud-config/cloud-config.yml")}"

  tags {
    Env   = "${var.env}"
    Group = "haproxy"
    Name  = "${format("haproxy-%02d", count.index + 1)}"
    sshUser = "merlijn"
  }
}
