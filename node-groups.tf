module "master_nodes" {
  source = "./node-group"

  providers = {
    exoscale = exoscale
    aws      = aws
  }

  name           = format("%s-master-nodes", var.name)
  instance_count = var.node_groups.master_nodes.instance_count
  zone           = var.zone
  name_prefix    = format("%s-%s", var.name, var.node_groups.master_nodes.name)
  template_id    = var.node_groups.master_nodes.template_id
  size           = var.node_groups.master_nodes.size
  disk_size      = var.node_groups.master_nodes.disk_size
  key_pair       = var.key_pair

  hostname_prefix = var.node_groups.master_nodes.name
  domain          = local.domain

  dns_zone_id = aws_route53_zone.this.zone_id
  dns_ttl     = var.dns_ttl

  provisioner_ssh_key = var.provisioner_ssh_key

  security_group_ids = concat(var.security_group_ids, [exoscale_security_group.this.id])

  tags = var.tags
}

module "is_worker_nodes" {
  source = "./node-group"

  providers = {
    exoscale = exoscale
    aws      = aws
  }

  name           = format("%s-is-worker-nodes", var.name)
  instance_count = var.node_groups.is_worker_nodes.instance_count
  zone           = var.zone
  name_prefix    = format("%s-%s", var.name, var.node_groups.is_worker_nodes.name)
  template_id    = var.node_groups.is_worker_nodes.template_id
  size           = var.node_groups.is_worker_nodes.size
  disk_size      = var.node_groups.is_worker_nodes.disk_size
  key_pair       = var.key_pair

  hostname_prefix = var.node_groups.is_worker_nodes.name
  domain          = local.domain

  dns_zone_id = aws_route53_zone.this.zone_id
  dns_ttl     = var.dns_ttl

  provisioner_ssh_key = var.provisioner_ssh_key

  security_group_ids = concat(var.security_group_ids, [exoscale_security_group.this.id])

  tags = var.tags
}
