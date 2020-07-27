resource "rke_cluster" "rke_cluster" {
  # master
  dynamic "nodes" {
    for_each = module.master_nodes.instances
    content {
      address = nodes.value.ip_address
      user    = "terraform"
      role    = ["controlplane", "etcd"]
      ssh_key = var.provisioner_ssh_key
    }
  }

  # workers
  dynamic "nodes" {
    for_each = module.is_worker_nodes.instances
    content {
      address = nodes.value.ip_address
      user    = "terraform"
      role    = ["worker"]
      ssh_key = var.provisioner_ssh_key
    }
  }

  upgrade_strategy {
    drain = true
    max_unavailable_worker = "20%"
  }
}
