
# Creating ACR

data "azurerm_subnet" "pe_subnet" {
  name                 = "${var.private_endpoint_subnet}"
  virtual_network_name = "${var.private_endpoint_vnet_01_name}"
  resource_group_name  = "${var.resource_group_name}"
}

resource "azurerm_container_registry" "acr" {
  name                          = "${var.acr_name}"
  resource_group_name           = "${var.resource_group_name}"
  location                      = "${var.Location}"
  sku                           = "${var.acr_sku}"
  public_network_access_enabled = false
}

# Creating a private endpoint for mysql

resource "azurerm_private_endpoint" "private_endpoint" {
  depends_on          = [azurerm_container_registry.acr]
  name                = "${var.acr_name}-pe"
  location            = "${var.Location}"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = data.azurerm_subnet.pe_subnet.id

  private_service_connection {
    name                              = "${var.acr_name}-privateserviceconnection"
    private_connection_resource_id    = azurerm_container_registry.acr.id
    subresource_names                 = ["registry"]
    is_manual_connection              = false
  }
}