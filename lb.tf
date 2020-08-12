resource "exoscale_nlb" "masters" {
  zone = var.zone
  name = "master_nodes"
}

resource "exoscale_nlb_service" "console" {
  zone = var.zone
  name = "api_external"
  nlb_id = exoscale_nlb.masters.id
  instance_pool_id = module.master_nodes.instance_pool.id
  protocol = "tcp"
  port = 6443
  target_port = 6443
  strategy = "round-robin"

  healthcheck {
    port = 6443
    mode = "tcp"
    interval = 10
    timeout = 3
    retries = 2
  }
}


resource "exoscale_nlb" "routers" {
  zone = var.zone
  name = "router_nodes"
}

resource "exoscale_nlb_service" "apps-http" {
  zone = var.zone
  name = "apps-http"
  nlb_id = exoscale_nlb.routers.id
  instance_pool_id = module.router_nodes.instance_pool.id
  protocol = "tcp"
  port = 80
  target_port = 80
  strategy = "round-robin"

  healthcheck {
    port = 80
    mode = "tcp"
    interval = 10
    timeout = 3
    retries = 2
  }
}

resource "exoscale_nlb_service" "apps-https" {
  zone = var.zone
  name = "apps-https"
  nlb_id = exoscale_nlb.routers.id
  instance_pool_id = module.router_nodes.instance_pool.id
  protocol = "tcp"
  port = 443
  target_port = 443
  strategy = "round-robin"

  healthcheck {
    port = 443
    mode = "tcp"
    interval = 10
    timeout = 3
    retries = 2
  }
}
