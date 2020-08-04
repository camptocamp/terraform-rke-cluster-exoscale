variable "name" {
  type = string
}

variable "base_domain" {
  type = string
}

variable "delegation_set_id" {
  type = string
}

variable "zone" {
  type = string
}

variable "key_pair" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "dns_ttl" {
  type = number
}

variable "provisioner_ssh_key" {
  type = string
}

#variable "puppet_server" {
#  type = string
#}
#
#variable "puppet_ca_server" {
#  type = string
#}
#
#variable "puppet_environment" {
#  type = string
#}
#
#variable "puppet_psk" {
#  type = string
#}

variable "node_groups" {
  type = map(object({
    name           = string
    instance_count = number
    template_id    = string
    size           = string
    disk_size      = number

#    puppet_role = string
  }))
}

variable "service_accounts" {
  type = map(object({
    name = string
  }))
}

variable "tags" {
  type = map(string)
}
