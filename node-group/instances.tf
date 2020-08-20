resource "exoscale_instance_pool" "this" {
  zone = var.zone
  name = var.name
  template_id = var.template_id
  size = var.instance_count
  service_offering = var.size
  disk_size = var.disk_size
  key_pair = var.key_pair

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
