# From Openshift?
output "api_external_domain" {
  value = local.api_external_domain
}

output "api_internal_domain" {
  value = local.api_internal_domain
}

output "console_domain" {
  value = local.console_domain
}

output "applications_domain" {
  value = local.applications_domain
}

output "security_group_id" {
  value = exoscale_security_group.this.id
}



output "cluster" {
  value = rke_cluster.this
}

output "route53_zone" {
  value = aws_route53_zone.this
}

output "masters_lb" {
  value = exoscale_nlb.masters
}

output "routers_lb" {
  value = exoscale_nlb.routers
}
