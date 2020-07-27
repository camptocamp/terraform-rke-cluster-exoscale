resource "exoscale_security_group" "this" {
  name = format("%s-nodes", var.name)
}

resource "exoscale_security_group_rule" "allow_sdn_between_all_nodes" {
  security_group_id      = exoscale_security_group.this.id
  type                   = "INGRESS"
  protocol               = "UDP"
  start_port             = 4789
  end_port               = 4789
  user_security_group_id = exoscale_security_group.this.id
}

resource "exoscale_security_group_rule" "allow_etcd_between_master_nodes" {
  security_group_id      = module.master_nodes.security_group_id
  type                   = "INGRESS"
  protocol               = "TCP"
  start_port             = 2380
  end_port               = 2380
  user_security_group_id = module.master_nodes.security_group_id
}

resource "exoscale_security_group_rule" "allow_api_from_all_nodes" {
  security_group_id      = module.master_nodes.security_group_id
  type                   = "INGRESS"
  protocol               = "TCP"
  start_port             = 443
  end_port               = 443
  user_security_group_id = exoscale_security_group.this.id
}

resource "exoscale_security_group_rule" "allow_udp_dns_from_all_nodes" {
  security_group_id      = module.master_nodes.security_group_id
  type                   = "INGRESS"
  protocol               = "UDP"
  start_port             = 8053
  end_port               = 8053
  user_security_group_id = exoscale_security_group.this.id
}

resource "exoscale_security_group_rule" "allow_tcp_dns_from_all_nodes" {
  security_group_id      = module.master_nodes.security_group_id
  type                   = "INGRESS"
  protocol               = "TCP"
  start_port             = 8053
  end_port               = 8053
  user_security_group_id = exoscale_security_group.this.id
}

resource "exoscale_security_group_rule" "allow_kubelet_from_master_nodes" {
  security_group_id      = exoscale_security_group.this.id
  type                   = "INGRESS"
  protocol               = "TCP"
  start_port             = 10250
  end_port               = 10250
  user_security_group_id = module.master_nodes.security_group_id
}
