output "vnet_id" {
  description = "Azure resource ID of the virtual network."
  value       = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  description = "Subnet resource IDs keyed by the caller's stable subnet names."
  value       = tomap({ for name, subnet in azurerm_subnet.this : name => subnet.id })
}

output "nsg_id" {
  description = "Azure resource ID of the composed network security group."
  value       = module.security.nsg_id
}

output "association_ids" {
  description = "NSG association IDs keyed by subnet name; Azure uses the subnet ID for each association."
  value       = module.security.association_ids
}

# AgentAlvine | D2.7: additive output only. The caller, not this module, adds app.
output "subnet_address_prefixes" {
  description = "IPv4 address-prefix lists keyed by stable subnet names; added in v1.1.0 without changing existing inputs, outputs or resource addresses."
  value       = tomap({ for name, subnet in azurerm_subnet.this : name => tolist(subnet.address_prefixes) })
}
