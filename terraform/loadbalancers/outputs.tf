output "loadbalancer_stats_url" {
  value = "${format("http://%s:8890", aws_instance.haproxy.public_ip)}"
}
