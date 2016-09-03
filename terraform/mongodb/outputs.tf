output "mongodb url" {
  value = ["${format("mongodb://%s:27017", aws_instance.mongodbnodes.*.public_dns)}"]
}

output "mongodbnodes public ipaddresses" {
  value = ["${aws_instance.mongodbnodes.*.public_ip}"]
}

output "mongodbnodes private ipaddresses" {
  value = ["${aws_instance.mongodbnodes.*.private_ip}"]
}
