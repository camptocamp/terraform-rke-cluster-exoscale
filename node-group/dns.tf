resource "aws_route53_record" "this" {
  count = var.instance_count

  zone_id = var.dns_zone_id
  name    = local.hostnames[count.index]
  type    = "A"
  ttl     = var.dns_ttl

  records = [
    exoscale_compute.this[count.index].ip_address
  ]
}
