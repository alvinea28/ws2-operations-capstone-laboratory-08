# AgentAlvine | D2.7 capstone: the caller adds app; the module adds only an output.
# MOCK ONLY. Plans and synthetic IDs are contract evidence, not Azure integration.
mock_provider "azurerm" {
  source          = "./tests/mocks"
  override_during = plan
}

override_resource {
  target          = azurerm_subnet.this["web"]
  override_during = plan
  values = {
    id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-ws2-mock/providers/Microsoft.Network/virtualNetworks/vnet-ws2-mock/subnets/web"
  }
}

override_resource {
  target          = azurerm_subnet.this["data"]
  override_during = plan
  values = {
    id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-ws2-mock/providers/Microsoft.Network/virtualNetworks/vnet-ws2-mock/subnets/data"
  }
}

override_resource {
  target          = module.security.azurerm_subnet_network_security_group_association.this["web"]
  override_during = plan
  values = {
    id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-ws2-mock/providers/Microsoft.Network/virtualNetworks/vnet-ws2-mock/subnets/web"
  }
}

override_resource {
  target          = module.security.azurerm_subnet_network_security_group_association.this["data"]
  override_during = plan
  values = {
    id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-ws2-mock/providers/Microsoft.Network/virtualNetworks/vnet-ws2-mock/subnets/data"
  }
}

variables {
  name                = "vnet-ws2-mock"
  resource_group_name = "rg-ws2-mock"
  location            = "westeurope"
  address_space       = ["10.42.0.0/16"]
  subnets = {
    web  = { address_prefixes = ["10.42.1.0/24"] }
    data = { address_prefixes = ["10.42.2.0/24"] }
  }
  tags = {
    owner       = "workshop-team"
    environment = "dev"
    cost_center = "training"
    workshop    = "ws2"
  }
}

run "original_two_subnets" {
  command = plan

  assert {
    condition = output.subnet_address_prefixes == tomap({
      web  = tolist(["10.42.1.0/24"])
      data = tolist(["10.42.2.0/24"])
    })
    error_message = "The additive prefix output must also work with unchanged v1.0.0 caller inputs."
  }

  assert {
    condition     = output.association_ids == output.subnet_ids && toset(keys(output.subnet_ids)) == toset(["data", "web"])
    error_message = "The previous two-subnet output contract must remain intact."
  }
}

run "named_app_subnet_addition" {
  command = plan
  variables {
    subnets = merge(var.subnets, { app = { address_prefixes = ["10.42.3.0/24"] } })
  }

  override_resource {
    target          = azurerm_subnet.this["app"]
    override_during = plan
    values = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-ws2-mock/providers/Microsoft.Network/virtualNetworks/vnet-ws2-mock/subnets/app"
    }
  }

  override_resource {
    target          = module.security.azurerm_subnet_network_security_group_association.this["app"]
    override_during = plan
    values = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-ws2-mock/providers/Microsoft.Network/virtualNetworks/vnet-ws2-mock/subnets/app"
    }
  }

  assert {
    condition = (
      toset(keys(azurerm_subnet.this)) == toset(["app", "data", "web"]) &&
      toset(keys(output.subnet_ids)) == toset(["app", "data", "web"]) &&
      toset(keys(output.association_ids)) == toset(["app", "data", "web"]) &&
      output.association_ids == output.subnet_ids
    )
    error_message = "Adding the app input key must add exactly that subnet and association, retaining data and web."
  }

  assert {
    condition = output.subnet_address_prefixes == tomap({
      app  = tolist(["10.42.3.0/24"])
      data = tolist(["10.42.2.0/24"])
      web  = tolist(["10.42.1.0/24"])
    })
    error_message = "Expose the complete map of prefix lists, including the caller-supplied app subnet."
  }

  assert {
    condition = (
      output.vnet_id == run.original_two_subnets.vnet_id &&
      output.nsg_id == run.original_two_subnets.nsg_id &&
      output.subnet_ids["web"] == run.original_two_subnets.subnet_ids["web"] &&
      output.subnet_ids["data"] == run.original_two_subnets.subnet_ids["data"] &&
      output.association_ids["web"] == run.original_two_subnets.association_ids["web"] &&
      output.association_ids["data"] == run.original_two_subnets.association_ids["data"]
    )
    error_message = "Existing stable keys and their fixture identities must be unchanged by the additive input."
  }

  assert {
    condition     = azurerm_subnet.this["app"].name == "app" && azurerm_subnet.this["app"].default_outbound_access_enabled == false
    error_message = "The additional named subnet must receive the same safe outbound default."
  }
}
