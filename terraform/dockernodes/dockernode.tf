resource "aws_security_group" "docker" {
  name        = "docker_security_group"
  description = "Allowing access to docker ports "
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    self      = true
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "dockernodes" {
  # Loop the amount of instances
  count = "${var.dockernode_count}"

  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.nano"
  key_name      = "${var.key_name}"

  vpc_security_group_ids = [
    "${var.default_sg_id}",
    "${aws_security_group.docker.id}"
  ]

  subnet_id = "${var.subnet_id_zones[count.index]}"

  tags {
    env   = "${var.env}"
    role = "dockernodes"
    Name  = "${format("dockernode-%02d", count.index + 1)}"
    sshUser = "ubuntu"
  }
}
