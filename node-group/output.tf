output "instance_pool" {
  value = exoscale_instance_pool.this
}

output "instances" {
  value = data.exoscale_compute.this
}

output "security_group_id" {
  value = exoscale_security_group.this.id
}
