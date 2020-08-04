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

variable "etcd_snapshots_interval_hours" {
  type = number
  default = 6
}

variable "etcd_snapshots_retention" {
  type = number
  default = 28
}

variable "etcd_snapshots_enabled" {
  type    = bool
  default = false
}

variable "etcd_snapshots_s3_access_key" {
  type    = string
  default = ""
}

variable "etcd_snapshots_s3_secret_key" {
  type    = string
  default = ""
}

variable "etcd_snapshots_s3_bucket_name" {
  type    = string
  default = ""
}

variable "etcd_snapshots_s3_region" {
  type    = string
  default = ""
}

variable "etcd_snapshots_s3_endpoint" {
  type    = string
  default = ""
}

variable "tags" {
  type = map(string)
}
