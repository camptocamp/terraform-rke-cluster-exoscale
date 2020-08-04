resource "rke_cluster" "this" {
  # master
  dynamic "nodes" {
    for_each = module.master_nodes.instances
    content {
      address = nodes.value.ip_address
      user    = "rancher"
      role    = ["controlplane", "etcd"]
      ssh_key = var.provisioner_ssh_key
    }
  }

  # workers
  dynamic "nodes" {
    for_each = module.is_worker_nodes.instances
    content {
      address = nodes.value.ip_address
      user    = "rancher"
      role    = ["worker"]
      ssh_key = var.provisioner_ssh_key
    }
  }

  addons_include = [
    "https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml",
    "https://gist.githubusercontent.com/superseb/499f2caa2637c404af41cfb7e5f4a938/raw/930841ac00653fdff8beca61dab9a20bb8983782/k8s-dashboard-user.yml",
  ]

  upgrade_strategy {
    drain = true
    max_unavailable_worker = "20%"
  }
}
