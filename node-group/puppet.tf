#module "puppet" {
#  source = "git::ssh://git@github.com/camptocamp/terraform-puppet-node.git"
#
#  instance_count = var.instance_count
#
#  instances = [
#    for i in range(var.instance_count) :
#    {
#      hostname = local.fqdns[i]
#
#      connection = {
#        host        = exoscale_compute.this[i].ip_address
#        user        = "terraform"
#        private_key = var.provisioner_ssh_key
#      }
#    }
#  ]
#
#  server_address    = var.puppet_server
#  ca_server_address = var.puppet_ca_server
#  environment       = var.puppet_environment
#  role              = var.puppet_role
#  autosign_psk      = var.puppet_psk
#}
