locals {
  hostnames = [
    for i in range(var.instance_count) :
    format("%s-%d", var.hostname_prefix, i)
  ]

  fqdns = [
    for i in range(var.instance_count) :
    format("%s.%s", local.hostnames[i], var.domain)
  ]
}
