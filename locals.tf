locals {
  domain              = format("%s.%s", var.name, var.base_domain)
  api_external_domain = format("api.%s", local.domain)
  api_internal_domain = format("api-int.%s", local.domain)
  console_domain      = format("console.%s", local.domain)
  applications_domain = format("apps.%s", local.domain)
}
