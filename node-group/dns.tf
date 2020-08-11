#resource "aws_route53_record" "this" {
#  for_each = data.exoscale_compute.this
#
#  zone_id = var.dns_zone_id
#  name    = each.value.hostname
#  type    = "A"
#  ttl     = var.dns_ttl
#
#  records = [
#    each.value.ip_address
#  ]
#}
