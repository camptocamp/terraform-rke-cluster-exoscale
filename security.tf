resource "exoscale_security_group" "this" {
  name = format("%s-nodes", var.name)
}


# Inbound: SSH
resource "exoscale_security_group_rule" "allow_ssh_from_everywhere" {
  security_group_id      = exoscale_security_group.this.id
  type                   = "INGRESS"
  protocol               = "TCP"
  cidr                   = "0.0.0.0/0"
  start_port             = 22
  end_port               = 22
}


# Inbound: Control Plane
resource "exoscale_security_group_rule" "allow_controlplane_from_everywhere" {
  security_group_id      = exoscale_security_group.this.id
  type                   = "INGRESS"
  protocol               = "TCP"
  cidr                   = "0.0.0.0/0"
  start_port             = 6443
  end_port               = 6443
}

# Inbound: Node Ports
resource "exoscale_security_group_rule" "allow_nodeports_from_everywhere" {
  security_group_id      = exoscale_security_group.this.id
  type                   = "INGRESS"
  protocol               = "TCP"
  cidr                   = "0.0.0.0/0"
  start_port             = 30000
  end_port               = 32768
}


# Open everything between nodes

resource "exoscale_security_group_rule" "allow_udp_between_all_nodes" {
  security_group_id      = exoscale_security_group.this.id
  type                   = "INGRESS"
  protocol               = "UDP"
  start_port             = 1024
  end_port               = 65535
  user_security_group_id = exoscale_security_group.this.id
}

resource "exoscale_security_group_rule" "allow_tcp_between_all_nodes" {
  security_group_id      = exoscale_security_group.this.id
  type                   = "INGRESS"
  protocol               = "TCP"
  start_port             = 1024
  end_port               = 65535
  user_security_group_id = exoscale_security_group.this.id
}


## Docker daemon
#resource "exoscale_security_group_rule" "allow_docker_from_all_nodes" {
#  security_group_id      = module.master_nodes.security_group_id
#  type                   = "INGRESS"
#  protocol               = "UDP"
#  start_port             = 2376
#  end_port               = 2376
#  user_security_group_id = exoscale_security_group.this.id
#}
#
#
## Etcd
#resource "exoscale_security_group_rule" "allow_etcd_client_from_masters" {
#  security_group_id      = module.master_nodes.security_group_id
#  type                   = "INGRESS"
#  protocol               = "UDP"
#  start_port             = 2379
#  end_port               = 2379
#  user_security_group_id = module.master_nodes.security_group_id
#}
#
#resource "exoscale_security_group_rule" "allow_etcd_peer_masters" {
#  security_group_id      = module.master_nodes.security_group_id
#  type                   = "INGRESS"
#  protocol               = "UDP"
#  start_port             = 2380
#  end_port               = 2380
#  user_security_group_id = module.master_nodes.security_group_id
#}
#
#
## SDN between nodes
#resource "exoscale_security_group_rule" "allow_sdn_between_all_nodes" {
#  security_group_id      = exoscale_security_group.this.id
#  type                   = "INGRESS"
#  protocol               = "UDP"
#  start_port             = 8472
#  end_port               = 8472
#  user_security_group_id = exoscale_security_group.this.id
#}
#
## SDN to etcd
#resource "exoscale_security_group_rule" "allow_sdn_etcd_to_itself" {
#  security_group_id      = module.master_nodes.security_group_id
#  type                   = "INGRESS"
#  protocol               = "UDP"
#  start_port             = 9099
#  end_port               = 9099
#  user_security_group_id = module.master_nodes.security_group_id
#}
#
## Kubelet
#resource "exoscale_security_group_rule" "allow_controlplane_to_etcd" {
#  security_group_id      = module.master_nodes.security_group_id
#  type                   = "INGRESS"
#  protocol               = "UDP"
#  start_port             = 10250
#  end_port               = 10250
#  user_security_group_id = module.master_nodes.security_group_id
#}
