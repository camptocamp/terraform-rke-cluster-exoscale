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

  # workers
  dynamic "nodes" {
    for_each = module.is_worker_nodes.instances
    content {
      address           = nodes.value.ip_address
      hostname_override = nodes.value.hostname
      user              = "rancher"
      role              = ["worker"]
      ssh_key           = var.provisioner_ssh_key
    }
  }

  #services {
  #  etcd {
  #    snapshot = var.etcd_snapshots_enabled

  #    backup_config {
  #      interval_hours = var.etcd_snapshots_interval_hours
  #      retention = var.etcd_snapshots_retention

  #      s3_backup_config {
  #        access_key = var.etcd_snapshots_s3_access_key
  #        secret_key = var.etcd_snapshots_s3_secret_key
  #        bucket_name = var.etcd_snapshots_s3_bucket_name
  #        region = var.etcd_snapshots_s3_region
  #        endpoint = var.etcd_snapshots_s3_endpoint
  #      }
  #    }
  #  }
  #}

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
