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


resource "aws_route53_record" "api_external" {
  zone_id = aws_route53_zone.this.id
  name    = trimsuffix(local.api_external_domain, local.domain)
  type    = "A"
  ttl     = "15"

  records = [
    exoscale_nlb.masters.ip_address
  ]

  set_identifier  = format("%s-api-external", var.name)
}

resource "aws_route53_record" "api_internal" {
  zone_id = aws_route53_zone.this.id
  name    = trimsuffix(local.api_internal_domain, local.domain)
  type    = "A"
  ttl     = "15"

  records = [
    exoscale_nlb.masters.ip_address
  ]

  set_identifier  = format("%s-api-internal", var.name)
}

resource "aws_route53_record" "console" {
  zone_id = aws_route53_zone.this.id
  name    = trimsuffix(local.console_domain, local.domain)
  type    = "A"
  ttl     = "15"

  records = [
    exoscale_nlb.masters.ip_address
  ]

  set_identifier  = format("%s-console", var.name)
}

resource "aws_route53_record" "applications" {
  zone_id = aws_route53_zone.this.id
  name    = format("*.%s", trimsuffix(local.applications_domain, local.domain))
  type    = "A"
  ttl     = "15"

  records = [
    exoscale_nlb.routers.ip_address
  ]

  set_identifier  = format("%s-applications", var.name)
}
