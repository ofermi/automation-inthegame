
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



# resource "azurerm_subnet" "Lb_External" {
#   name                 = "Lb_External_IP"
#   resource_group_name  = "${var.resource_group_name}"
# #  virtual_network_name = azurerm_virtual_network.vnet01.name
#   virtual_network_name = azurerm_virtual_network.aks_vnet01.name
#   address_prefixes     = ["${var.lb_subnet_cidr_address_space}"]
# }



# Creating Vnet peering between VM Vnet to AKS Vnet
resource "azurerm_virtual_network_peering" "VM-to-Aks" {
  name                      = "peer-vm-to-Vnet-${var.Environment}"
  resource_group_name       = "${var.resource_group_name_vm}"
  virtual_network_name      = "${var.vnet_name_vm}"
  remote_virtual_network_id = azurerm_virtual_network.aks_vnet01.id
  depends_on               = [azurerm_virtual_network.aks_vnet01]
}
data "azurerm_virtual_network" "vm_vnet" {
  name                = "${var.vnet_name_vm}"
  resource_group_name = "${var.resource_group_name_vm}"
}
resource "azurerm_virtual_network_peering" "Aks-to-VM" {
  name                      = "peer-Vnet-${var.Environment}-to-vm"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${var.aks_vnet_01_name}"
  remote_virtual_network_id = data.azurerm_virtual_network.vm_vnet.id
   depends_on               = [azurerm_virtual_network.aks_vnet01]
}

########  peerint AKS to HUB
# resource "azurerm_virtual_network_peering" "HUB-to-Aks" {
#   name                      = "peer-Hub-to-Vnet-${var.Environment}"
#   resource_group_name       = "${var.resource_group_name_Hub}"
#   virtual_network_name      = "${var.vnet_name_Hub}"
#   remote_virtual_network_id = azurerm_virtual_network.aks_vnet01.id
#   depends_on               = [azurerm_virtual_network.aks_vnet01]
# }
# data "azurerm_virtual_network" "Hub_vnet" {
#   name                = "${var.vnet_name_Hub}"
#   resource_group_name = "${var.resource_group_name_Hub}"
# }
# resource "azurerm_virtual_network_peering" "Aks-to-HUB" {
#   name                      = "peer-Vnet-${var.Environment}-to-Hub"
#   resource_group_name       = "${var.resource_group_name}"
#   virtual_network_name      = "${var.aks_vnet_01_name}"
#   remote_virtual_network_id = data.azurerm_virtual_network.Hub_vnet.id
#    depends_on               = [azurerm_virtual_network.aks_vnet01]
# }