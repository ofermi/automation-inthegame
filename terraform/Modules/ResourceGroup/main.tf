


resource "azurerm_resource_group" "Resource_Group_01" {
  name     = "${var.resource_group_name}"
  location = "${var.Location}"
}

