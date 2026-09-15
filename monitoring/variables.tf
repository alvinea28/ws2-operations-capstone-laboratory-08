variable "tenant_id" {
  type        = string
  description = "Your approved tenant GUID, supplied privately."
}

variable "subscription_id" {
  type        = string
  description = "Your approved subscription GUID, supplied privately."
}

variable "resource_group_name" {
  type        = string
  description = "Existing approved RG; this configuration never owns the group."
}

variable "location" {
  type        = string
  description = "Approved region supporting the Logic Apps GitHub connector."
}

variable "name" {
  type        = string
  description = "Unique disposable monitoring prefix, not an existing shared integration."

  validation {
    condition     = can(regex("^ws2-monitor-[a-z0-9][a-z0-9-]{1,25}$", var.name))
    error_message = "Use a unique ws2-monitor- name."
  }
}

variable "github_owner" {
  type        = string
  description = "Your authorized GitHub repository owner. No token is accepted as an input."

  validation {
    condition     = can(regex("^[A-Za-z0-9][A-Za-z0-9-]{0,38}$", var.github_owner))
    error_message = "Supply a GitHub owner name, not a URL or credential."
  }
}

variable "github_repository" {
  type        = string
  description = "Your private exercise repository name, without owner or URL."

  validation {
    condition     = can(regex("^[A-Za-z0-9][A-Za-z0-9._-]{0,99}$", var.github_repository))
    error_message = "Supply a repository name only."
  }
}

variable "workload_resource_id" {
  type        = string
  description = "The one approved lab VNet to monitor; this root does not create or own it."

  validation {
    condition     = startswith(lower(var.workload_resource_id), lower("/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/"))
    error_message = "Monitor only a VNet in this explicitly selected lab subscription and RG."
  }
}
