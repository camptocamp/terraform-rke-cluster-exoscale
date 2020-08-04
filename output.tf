# From Openshift?
output "api_external_domain" {
  value = local.api_external_domain
}

output "api_internal_domain" {
  value = local.api_internal_domain
}

output "console_domain" {
  value = local.console_domain
}

output "applications_domain" {
  value = local.applications_domain
}

output "security_group_id" {
  value = exoscale_security_group.this.id
}

output "node_groups" {
  value = {
    master_nodes = {
      name = var.node_groups.master_nodes.name

      instances = [
        for index in range(length(module.master_nodes.instances)) :
        merge(module.master_nodes.instances[index], {
          route53_record = {
            for record in [aws_route53_record.api_external[index], aws_route53_record.api_internal[index], aws_route53_record.console[index]] :
            record.name =>
            {
              health_check_id = record.health_check_id
              record_fqdn     = record.fqdn
              set_identifier  = record.set_identifier
              zone            = local.domain
            }
          }
        })
      ]

      security_group_id = module.master_nodes.security_group_id
    }

    is_worker_nodes = {
      name = var.node_groups.is_worker_nodes.name

      instances = [
        for instance in module.is_worker_nodes.instances :
        instance
      ]

      security_group_id = module.is_worker_nodes.security_group_id
    }

  }
}


output "cluster" {
  value = rke_cluster.this
}
