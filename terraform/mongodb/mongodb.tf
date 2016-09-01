resource "aws_security_group" "mongodb" {
  name        = "mongodb_security_group"
  description = "Allowing access to mongodb ports "
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port = 27017
    to_port   = 27017
    protocol  = "tcp"
    self      = true
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "mongodbnodes" {
  # Loop the amount of instances
  count = "${var.mongodbnodes_count}"

  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"

  vpc_security_group_ids = [
    "${var.default_sg_id}",
    "${aws_security_group.mongodb.id}"
  ]

  subnet_id = "${var.subnet_id_zones[count.index]}"

  tags {
    env   = "${var.env}"
    role = "mongodbnodes"
    Name  = "${format("mongodbnode-%02d", count.index + 1)}"
    sshUser = "ubuntu"
  }
}
