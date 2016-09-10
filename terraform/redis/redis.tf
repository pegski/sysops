resource "aws_security_group" "redis" {
  name        = "redis_security_group"
  description = "Allowing access to redis cluster"
  vpc_id      = "${var.vpc_id}"

}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.cache_name}"
  engine               = "redis"
  engine_version       = "${var.engine_version}"
  maintenance_window   = "${var.maintenance_window}"
  node_type            = "${var.instance_type}"
  num_cache_nodes      = "1"
  parameter_group_name = "default.redis2.8"
  port                 = "6379"
  subnet_group_name    = "${aws_elasticache_subnet_group.default.name}"
  security_group_ids   = ["${aws_security_group.redis.id}"]

  tags {
    Name = "CacheCluster"
    env   = "${var.env}"
    role = "redisnode"
    Name  = "${format("redis-%02d", count.index + 1)}"
  }
}

resource "aws_elasticache_subnet_group" "default" {
  name        = "${var.cache_name}-subnet-group"
  description = "Private subnets for the ElastiCache instances"
  subnet_ids  = ["${var.subnet_id_zones}"]
}


