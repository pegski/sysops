output "public ip" {
  value = ["${aws_instance.dockernodes.*.public_ip}"]
}

output "private ip" {
  value = ["${aws_instance.dockernodes.*.private_ip}"]
}
