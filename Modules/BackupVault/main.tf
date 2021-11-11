

resource "azurerm_recovery_services_vault" "backupvault" {
  name                = "${var.backup_vault_name}"
  location            = "${var.Location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "Standard"
}