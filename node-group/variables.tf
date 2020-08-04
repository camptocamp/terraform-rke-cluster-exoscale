variable "name" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "zone" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "template_id" {
  type = string
}

variable "size" {
  type = string
}

variable "disk_size" {
  type = number
}

variable "key_pair" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "hostname_prefix" {
  type = string
}

variable "domain" {
  type = string
}

variable "dns_zone_id" {
  type = string
}

variable "dns_ttl" {
  type = number
}

variable "provisioner_ssh_key" {
  type = string
}

variable "tags" {
  type = map(string)
}
