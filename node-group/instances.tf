resource "exoscale_affinity" "this" {
  count = ceil(var.instance_count / 8)

  name = format("%s-%d", var.name, count.index)
  type = "host anti-affinity"
}

resource "exoscale_compute" "this" {
  count = var.instance_count

  zone         = var.zone
  display_name = format("%s-%d", var.name_prefix, count.index)
  hostname     = local.hostnames[count.index]
  reverse_dns  = format("%s.", local.fqdns[count.index])
  template_id  = var.template_id
  size         = var.size
  disk_size    = var.disk_size
  key_pair     = var.key_pair

  affinity_group_ids = [
    exoscale_affinity.this[floor(count.index / 8)].id
  ]

  security_group_ids = concat(var.security_group_ids, [exoscale_security_group.this.id])

  tags = var.tags
}
