
# This module include 2 Vnets, 5 Subnets, nsg, and nsg association to main vnet's subnets
# resource "azurerm_virtual_network" "vnet01" {
#   name                = "${var.vnet_01_name}"
#   location            = "${var.Location}"
#   resource_group_name = "${var.resource_group_name}"
#   address_space       = [var.cidr_address_space]
# }
# Creating AKS Vnet
resource "azurerm_virtual_network" "aks_vnet01" {
  name                = "${var.aks_vnet_01_name}"
  location            = "${var.Location}"
  resource_group_name = "${var.resource_group_name}"
  address_space       = ["${var.aks_cidr_address_space}"]
}

# Creating AKS Subnet
resource "azurerm_subnet" "aks_subnet" {
  name                 = "${var.aks_subnet_name}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = azurerm_virtual_network.aks_vnet01.name
  address_prefixes     = ["${var.aks_subnet_cidr_address_space}"]
  enforce_private_link_endpoint_network_policies  = true
}
#Creating main Vnet Subnets
resource "azurerm_subnet" "spoke_subnet" {
  name                 = "${var.spoke_subnet}"
  resource_group_name  = "${var.resource_group_name}"
#  virtual_network_name = azurerm_virtual_network.vnet01.name
  virtual_network_name = azurerm_virtual_network.aks_vnet01.name
  address_prefixes     = ["${var.spoke_subnet_cidr_address_space}"]
}

 resource "azurerm_subnet" "pe_subnet" {
  name                 = "${var.pe_subnet_name}"
  resource_group_name  = "${var.resource_group_name}"
#  virtual_network_name = azurerm_virtual_network.vnet01.name
  virtual_network_name = azurerm_virtual_network.aks_vnet01.name
  address_prefixes     = ["${var.pe_subnet_cidr_address_space}"]
}



resource "azurerm_subnet" "Lb_External" {
  name                 = "Lb_External_IP"
  resource_group_name  = "${var.resource_group_name}"
#  virtual_network_name = azurerm_virtual_network.vnet01.name
  virtual_network_name = azurerm_virtual_network.aks_vnet01.name
  address_prefixes     = ["${var.lb_subnet_cidr_address_space}"]
}



# NSG
# resource "azurerm_network_security_group" "nsg" {
#   name                = "${var.nsg_name}"
#   location            = "${var.Location}"
#   resource_group_name = "${var.resource_group_name}"

# }

# # NSG Rules
# resource "azurerm_network_security_rule" "Allow_MainHub" {
#   name                        = "Allow_MainHub"
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_ranges     = ["3268", "22", "3389", "7005", "7006", "1433", "3269", "88", "135", "636", "389", "443", "445", "464", "53", "123", "139", "40000-65535", "9524", "80"]
#   source_address_prefixes     = ["10.96.0.0/21", "10.86.207.0/25", "10.86.208.0/20", "10.96.14.0/24", "10.96.15.0/24", "10.96.17.0/24", "10.96.18.0/24"]
#   destination_address_prefix  = var.cidr_address_space
#   resource_group_name         = "${var.resource_group_name}"
#   network_security_group_name = "${var.nsg_name}"
#   depends_on                  = [azurerm_network_security_group.nsg]
# }

# resource "azurerm_network_security_rule" "Allow_Sapiens" {
#   name                        = "Allow_Sapiens"
#   priority                    = 110
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_ranges     = [3389,1433]
#   source_address_prefix       = "10.245.0.0/16"
#   destination_address_prefix  = var.cidr_address_space
#   resource_group_name         = "${var.resource_group_name}"
#   network_security_group_name = "${var.nsg_name}"
#   depends_on                  = [azurerm_network_security_group.nsg]
# }

# resource "azurerm_network_security_rule" "Allow_Subnets" {
#   name                        = "Allow_Subnets"
#   priority                    = 130
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = var.aks_cidr_address_space
#   resource_group_name         = "${var.resource_group_name}"
#   network_security_group_name = "${var.nsg_name}"
#   depends_on                  = [azurerm_network_security_group.nsg]
# }

# resource "azurerm_network_security_rule" "Allow_MoveIT" {
#   name                        = "Allow_MoveIT"
#   priority                    = 150
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_ranges     = [445,22]
#   source_address_prefix       = "10.91.198.99"
#   destination_address_prefix  = var.cidr_address_space
#   resource_group_name         = "${var.resource_group_name}"
#   network_security_group_name = "${var.nsg_name}"
#   depends_on                  = [azurerm_network_security_group.nsg]
# }

# resource "azurerm_network_security_rule" "Deny_All" {
#   name                        = "Deny_All"
#   priority                    = 4000
#   direction                   = "Inbound"
#   access                      = "Deny"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = "${var.resource_group_name}"
#   network_security_group_name = "${var.nsg_name}"
#   depends_on                  = [azurerm_network_security_group.nsg]
# }

# # NSG association
# resource "azurerm_subnet_network_security_group_association" "nsg_association_App_subnet" {
#   subnet_id                 = azurerm_subnet.App_subnet.id
#   network_security_group_id = azurerm_network_security_group.nsg.id
# }

# resource "azurerm_subnet_network_security_group_association" "nsg_association_DB_subnet" {
#   subnet_id                 = azurerm_subnet.DB_subnet.id
#   network_security_group_id = azurerm_network_security_group.nsg.id
# }

# resource "azurerm_subnet_network_security_group_association" "nsg_association_SFTP_subnet" {
#   subnet_id                 = azurerm_subnet.SFTP_subnet.id
#   network_security_group_id = azurerm_network_security_group.nsg.id
# }

# Creating Vnet peering between main Vnet to AKS Vnet
resource "azurerm_virtual_network_peering" "main-to-Aks" {
  name                      = "peer-Hub-to-Vnet-${var.Environment}"
  resource_group_name       = "${var.resource_group_name_Hub}"
  virtual_network_name      = "${var.vnet_name_Hub}"
  remote_virtual_network_id = azurerm_virtual_network.aks_vnet01.id
  depends_on               = [azurerm_virtual_network.aks_vnet01]
}
data "azurerm_virtual_network" "Hub_vnet" {
  name                = "${var.vnet_name_Hub}"
  resource_group_name = "${var.resource_group_name_Hub}"
}
resource "azurerm_virtual_network_peering" "Aks-to-main" {
  name                      = "peer-Vnet-${var.Environment}-to-Hub"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${var.aks_vnet_01_name}"
  remote_virtual_network_id = data.azurerm_virtual_network.Hub_vnet.id
   depends_on               = [azurerm_virtual_network.aks_vnet01]
}