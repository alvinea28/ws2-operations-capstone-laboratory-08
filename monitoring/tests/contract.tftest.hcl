# Authoring contracts only. OAuth authorization and real issue delivery need live proof.
mock_provider "azapi" {
  mock_data "azapi_resource_action" {
    defaults = {
      output = { value = "https://example.invalid/workshop-callback" }
    }
  }
}
mock_provider "azurerm" {}
mock_provider "modtm" {}
mock_provider "random" {}

variables {
  tenant_id            = "00000000-0000-0000-0000-000000000000"
  subscription_id      = "00000000-0000-0000-0000-000000000000"
  resource_group_name  = "rg-monitor-contract"
  location             = "eastus"
  name                 = "ws2-monitor-contract"
  github_owner         = "example"
  github_repository    = "workshop-copy"
  workload_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-monitor-contract/providers/Microsoft.Network/virtualNetworks/ws2-avm-contract"
}

run "one_workload_and_no_raw_alert_values" {
  command = plan

  assert {
    condition     = length(azurerm_monitor_activity_log_alert.workload.scopes) == 1
    error_message = "Do not monitor unrelated subscriptions or workloads."
  }

  assert {
    condition     = !strcontains(jsonencode(jsondecode(file("${path.module}/workflow.json")).actions.Create_issue.inputs.body), "triggerBody")
    error_message = "Do not copy raw alert payloads into GitHub issues."
  }
}

run "reject_wrong_workload_scope" {
  command = plan

  variables {
    workload_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/shared-rg/providers/Microsoft.Network/virtualNetworks/shared"
  }

  expect_failures = [var.workload_resource_id]
}
