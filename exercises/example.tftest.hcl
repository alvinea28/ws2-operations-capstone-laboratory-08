# No variables block: this test deliberately consumes the actual CLI example file.
mock_provider "azurerm" {
  source          = "./tests/mocks"
  override_during = plan
}

run "actual_app_example" {
  command = plan
  assert {
    condition     = toset(keys(output.subnet_ids)) == toset(["web", "data", "app"])
    error_message = "The actual example must create the app subnet beside web/data."
  }
  assert {
    condition     = output.subnet_address_prefixes["app"] == tolist(["10.42.3.0/24"])
    error_message = "The actual example's app CIDR must be returned by the new output."
  }
  assert {
    condition     = toset(keys(output.association_ids)) == toset(keys(output.subnet_ids))
    error_message = "Every actual example subnet needs its NSG association."
  }
}
