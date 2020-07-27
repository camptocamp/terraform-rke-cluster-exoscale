output "instances" {
  value = [
    for i in range(length(aws_route53_record.this)) :
    {
      hostname   = aws_route53_record.this[i].fqdn
      ip_address = exoscale_compute.this[i].ip_address
    }
  ]
}

output "security_group_id" {
  value = exoscale_security_group.this.id
}
