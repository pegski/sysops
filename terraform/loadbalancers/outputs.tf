output "loadbalancer_stats_url" {
  value = "${format("http://%s:8890", aws_instance.haproxy.public_dns)}"
}

output "public dns" {
  value = "${aws_instance.haproxy.public_dns}"
}

output "public ip" {
  value = "${aws_instance.haproxy.public_ip}"
}

output "private ip" {
  value = "${aws_instance.haproxy.private_ip}"
}
