locals {
  resource_group_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}"
  github_api_id     = "/subscriptions/${var.subscription_id}/providers/Microsoft.Web/locations/${var.location}/managedApis/github"
  tags = {
    workshop = "ws2"
    example  = "monitor-feedback"
  }
}

# The connection must be authorized by its owner in Azure's trusted portal UI.
# Terraform never receives a GitHub token, password or authorization callback.
module "github" {
  source  = "Azure/avm-res-web-connection/azurerm"
  version = "0.1.0"

  name                = "${var.name}-github"
  display_name        = "WS2 GitHub issue connection"
  resource_group_name = var.resource_group_name
  managed_api_id      = local.github_api_id
  parameter_values    = {}
  enable_telemetry    = false
  tags                = local.tags
}

module "workflow" {
  source  = "Azure/avm-res-logic-workflow/azurerm"
  version = "0.1.2"

  name                 = "${var.name}-logic"
  location             = var.location
  resource_group_id    = local.resource_group_id
  resource_group_name  = var.resource_group_name
  enable_telemetry     = false
  logic_app_definition = jsondecode(file("${path.module}/workflow.json"))
  workflow_parameters = {
    github_owner      = { value = var.github_owner }
    github_repository = { value = var.github_repository }
    "$connections" = {
      value = {
        github = {
          connectionId   = module.github.resource_id
          connectionName = "${var.name}-github"
          id             = local.github_api_id
        }
      }
    }
  }
  tags = local.tags
}

# Callback URLs contain authorization material. They stay in the protected
# execution/state boundary and are deliberately not exposed as an output.
data "azapi_resource_action" "callback" {
  type                   = "Microsoft.Logic/workflows/triggers@2016-06-01"
  resource_id            = "${module.workflow.resource_id}/triggers/manual"
  action                 = "listCallbackUrl"
  method                 = "POST"
  response_export_values = ["value"]
}

resource "azurerm_monitor_action_group" "feedback" {
  name                = "${var.name}-ag"
  resource_group_name = var.resource_group_name
  short_name          = "ws2feedback"
  tags                = local.tags

  logic_app_receiver {
    name                    = "create-github-issue"
    resource_id             = module.workflow.resource_id
    callback_url            = sensitive(data.azapi_resource_action.callback.output.value)
    use_common_alert_schema = true
  }
}

resource "azurerm_monitor_activity_log_alert" "workload" {
  name                = "${var.name}-alert"
  resource_group_name = var.resource_group_name
  location            = "global"
  scopes              = [var.workload_resource_id]
  description         = "Controlled workshop VNet write notification, not a threat detection claim."
  tags                = local.tags

  criteria {
    category       = "Administrative"
    operation_name = "Microsoft.Network/virtualNetworks/write"
    status         = "Succeeded"
  }

  action {
    action_group_id = azurerm_monitor_action_group.feedback.id
  }
}
