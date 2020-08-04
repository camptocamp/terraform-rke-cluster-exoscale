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

variable "node_groups" {
  type = map(object({
    name           = string
    instance_count = number
    template_id    = string
    size           = string
    disk_size      = number
  }))
}

variable "service_accounts" {
  type = map(object({
    name = string
  }))
}

variable "etcd_snapshots" {
  type = object({
    interval_hours = number
    retention      = number
    enabled        = bool
    s3             = object({
      access_key  = string
      secret_key  = string
      bucket_name = string
      region      = string
      endpoint    = string
    })
  })
}

variable "tags" {
  type = map(string)
}
