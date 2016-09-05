# define the vpc
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags {
    Name = "pegski-vpc"
    Env = "${var.env}"
  }
}

# create an internet gateway
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "Default vpc gateway"
  }
}

# define default route for the internet gateway
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# Create the subnets for the availibility zones
resource "aws_subnet" "default" {
  count                   = "3"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${var.cidr_blocks[count.index]}"
  availability_zone       = "${lookup(var.zones, "zone${count.index}")}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.env} subnet for ${lookup(var.zones, "zone${count.index}")}"
  }
}

# Our default security group
resource "aws_security_group" "default" {
  name        = "default_security_group"
  description = "Default SSH and HTTP only from whitelisted cidr blocks"
  vpc_id      = "${aws_vpc.main.id}"

  # Allow all traffic from instances attached to same sceurity group
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    self        = true
  }

  # SSH from the whitelisted CIDR blocks
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${split(",", var.whitelisted_cidrs)}"]
  }

  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
