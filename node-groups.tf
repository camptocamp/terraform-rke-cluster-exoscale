module "master_nodes" {
  source = "./node-group"

  providers = {
    exoscale = exoscale
    aws      = aws
  }

  name           = format("%s-master-nodes", var.name)
  instance_count = var.node_groups.master_nodes.instance_count
  zone           = var.zone
  template_id    = var.node_groups.master_nodes.template_id
  size           = var.node_groups.master_nodes.size
  disk_size      = var.node_groups.master_nodes.disk_size
  key_pair       = var.key_pair

  provisioner_ssh_key = var.provisioner_ssh_key

  security_group_ids = concat(var.security_group_ids, [exoscale_security_group.this.id])

  tags = var.tags
}

module "router_nodes" {
  source = "./node-group"

  providers = {
    exoscale = exoscale
    aws      = aws
  }

  name           = format("%s-is-router-nodes", var.name)
  instance_count = var.node_groups.router_nodes.instance_count
  zone           = var.zone
  template_id    = var.node_groups.router_nodes.template_id
  size           = var.node_groups.router_nodes.size
  disk_size      = var.node_groups.router_nodes.disk_size
  key_pair       = var.key_pair

  provisioner_ssh_key = var.provisioner_ssh_key

  security_group_ids = concat(var.security_group_ids, [exoscale_security_group.this.id])

  tags = var.tags
}

module "worker_nodes" {
  source = "./node-group"

  providers = {
    exoscale = exoscale
    aws      = aws
  }

  name           = format("%s-is-worker-nodes", var.name)
  instance_count = var.node_groups.worker_nodes.instance_count
  zone           = var.zone
  template_id    = var.node_groups.worker_nodes.template_id
  size           = var.node_groups.worker_nodes.size
  disk_size      = var.node_groups.worker_nodes.disk_size
  key_pair       = var.key_pair

  provisioner_ssh_key = var.provisioner_ssh_key

  security_group_ids = concat(var.security_group_ids, [exoscale_security_group.this.id])

  tags = var.tags
}
