resource "exoscale_affinity" "this" {
  count = ceil(var.instance_count / 8)

  name = format("%s-%d", var.name, count.index)
  type = "host anti-affinity"
}


resource "exoscale_instance_pool" "this" {
  zone = var.zone
  name = var.name
  template_id = var.template_id
  size = var.instance_count
  service_offering = var.size
  disk_size = var.disk_size
  key_pair = var.key_pair

#  affinity_group_ids = [
#    exoscale_affinity.this[floor(count.index / 8)].id
#  ]

  security_group_ids = concat(var.security_group_ids, [exoscale_security_group.this.id])

  timeouts {
    delete = "10m"
  }
}

data "exoscale_compute" "this" {
  count = var.instance_count
  depends_on = [exoscale_instance_pool.this]

  hostname = sort(exoscale_instance_pool.this.virtual_machines)[count.index]
}
