



data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                        = "${var.key_vault_name}"
  location                    = "${var.Location}"
  resource_group_name         = "${var.resource_group_name}"
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard" 
}
