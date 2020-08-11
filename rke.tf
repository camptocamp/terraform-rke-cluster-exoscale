resource "rke_cluster" "this" {
  # master
  dynamic "nodes" {
    for_each = module.master_nodes.instances
    content {
      address           = nodes.value.ip_address
      hostname_override = nodes.value.hostname
      user              = "rancher"
      role              = ["controlplane", "etcd"]
      ssh_key           = var.provisioner_ssh_key
    }
  }

  # routers
  dynamic "nodes" {
    for_each = module.router_nodes.instances
    content {
      address           = nodes.value.ip_address
      hostname_override = nodes.value.hostname
      user              = "rancher"
      role              = ["worker"]
      ssh_key           = var.provisioner_ssh_key
      labels            = {
        app = "ingress"
      }
    }
  }

  # workers
  dynamic "nodes" {
    for_each = module.worker_nodes.instances
    content {
      address           = nodes.value.ip_address
      hostname_override = nodes.value.hostname
      user              = "rancher"
      role              = ["worker"]
      ssh_key           = var.provisioner_ssh_key
    }
  }

  ingress {
    provider = "nginx"
    node_selector = {
      app = "ingress"
    }
  }

  services {
    etcd {
      snapshot = var.etcd_snapshots.enabled

      backup_config {
        interval_hours = var.etcd_snapshots.interval_hours
        retention = var.etcd_snapshots.retention

        s3_backup_config {
          access_key  = var.etcd_snapshots.s3.access_key
          secret_key  = var.etcd_snapshots.s3.secret_key
          bucket_name = var.etcd_snapshots.s3.bucket_name
          region      = var.etcd_snapshots.s3.region
          endpoint    = var.etcd_snapshots.s3.endpoint
        }
      }
    }
  }

  network {
    plugin = "canal"
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
