

resource "azurerm_storage_account" "st01" {
  name                     = "${var.st_name}"
  resource_group_name      = "${var.resource_group_name}"
  location                 = "${var.Location}"
  account_tier             = "Standard"
  account_replication_type = "${var.replication_type}" 
}

