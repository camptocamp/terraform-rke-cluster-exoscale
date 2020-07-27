data "aws_route53_zone" "base" {
  name = var.base_domain
}

resource "aws_route53_zone" "this" {
  name              = local.domain
  delegation_set_id = var.delegation_set_id
}

resource "aws_route53_record" "name_servers" {
  zone_id = data.aws_route53_zone.base.zone_id
  name    = var.name
  type    = "NS"
  ttl     = 172800
  records = aws_route53_zone.this.name_servers
}

resource "aws_route53_health_check" "master_nodes" {
  count = length(module.master_nodes.instances)

  ip_address        = module.master_nodes.instances[count.index].ip_address
  port              = 443
  type              = "HTTPS"
  resource_path     = "/healthz"
  failure_threshold = "2"
  request_interval  = "10"
  measure_latency   = "true"
}

resource "aws_route53_health_check" "is_worker_nodes" {
  count = length(module.is_worker_nodes.instances)

  ip_address        = module.is_worker_nodes.instances[count.index].ip_address
  port              = 80
  type              = "HTTP"
  resource_path     = "/_______internal_router_healthz"
  failure_threshold = "2"
  request_interval  = "10"
  measure_latency   = "true"
}

resource "aws_route53_record" "api_external" {
  count = length(module.master_nodes.instances)

  zone_id = aws_route53_zone.this.id
  name    = trimsuffix(local.api_external_domain, local.domain)
  type    = "A"
  ttl     = "15"

  records = [
    module.master_nodes.instances[count.index].ip_address
  ]

  health_check_id = aws_route53_health_check.master_nodes[count.index].id
  set_identifier  = format("%s-api-external-%d", var.name, count.index)

  weighted_routing_policy {
    weight = 10
  }
}

resource "aws_route53_record" "api_internal" {
  count = length(module.master_nodes.instances)

  zone_id = aws_route53_zone.this.id
  name    = trimsuffix(local.api_internal_domain, local.domain)
  type    = "A"
  ttl     = "15"

  records = [
    module.master_nodes.instances[count.index].ip_address
  ]

  health_check_id = aws_route53_health_check.master_nodes[count.index].id
  set_identifier  = format("%s-api-internal-%d", var.name, count.index)

  weighted_routing_policy {
    weight = 10
  }
}

resource "aws_route53_record" "console" {
  count = length(module.master_nodes.instances)

  zone_id = aws_route53_zone.this.id
  name    = trimsuffix(local.console_domain, local.domain)
  type    = "A"
  ttl     = "15"

  records = [
    module.master_nodes.instances[count.index].ip_address
  ]

  health_check_id = aws_route53_health_check.master_nodes[count.index].id
  set_identifier  = format("%s-console-%d", var.name, count.index)

  weighted_routing_policy {
    weight = 10
  }
}

resource "aws_route53_record" "applications" {
  count = length(module.is_worker_nodes.instances)

  zone_id = aws_route53_zone.this.id
  name    = format("*.%s", trimsuffix(local.applications_domain, local.domain))
  type    = "A"
  ttl     = "15"

  records = [
    module.is_worker_nodes.instances[count.index].ip_address
  ]

  health_check_id = aws_route53_health_check.is_worker_nodes[count.index].id
  set_identifier  = format("%s-applications-%d", var.name, count.index)

  weighted_routing_policy {
    weight = 10
  }
}
