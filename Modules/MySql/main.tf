

# Creating Mysql server
resource "azurerm_mysql_server" "MySqlServer01" {
  name                = "${var.mysql_name}"
  location            = "${var.Location}"
  resource_group_name = "${var.resource_group_name}"

  sku_name = "${var.sku_mysql_name}"

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "${var.mysql_admin_login}"
  administrator_login_password = "${var.mysql_admin_pass}"
  version                      = "5.7"
  ssl_enforcement              = "Enabled"
}


# Creating a private endpoint for mysql

data "azurerm_subnet" "pe_subnet" {
  name                 = "${var.pe_subnet}"
  virtual_network_name = "${var.vnet_01_name}"
  resource_group_name  = "${var.resource_group_name}"
}


resource "azurerm_private_endpoint" "private_endpoint" {
  depends_on          = [azurerm_mysql_server.MySqlServer01]
  name                = "${var.mysql_name}-pe"
  location            = "${var.Location}"
  resource_group_name = "${var.resource_group_name}"
  subnet_id           = data.azurerm_subnet.pe_subnet.id

  private_service_connection {
    name                              = "${var.mysql_name}-privateserviceconnection"
    private_connection_resource_id    = azurerm_mysql_server.MySqlServer01.id
    subresource_names                 = ["mysqlServer"]
    is_manual_connection              = false
  }
}

# Creating Mysql database
resource "azurerm_mysql_database" "mysqldb01" {
  name                = "${var.mysql_name}"
  resource_group_name = "${var.resource_group_name}"
  server_name         = azurerm_mysql_server.MySqlServer01.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}


