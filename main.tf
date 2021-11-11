

terraform {
  backend "azurerm" {
    resource_group_name  = "githubrunterraform"
    
    storage_account_name = "storeterraformstatefile"
    container_name       = "tfstatedevops"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
#   version = "2.80.0
  features {}
}

# Modules
resource "azurerm_private_dns_zone_virtual_network_link" "link_to_hub_vnet" {
name = "link_to_hub_vnet"
private_dns_zone_name = "6633671e-9ea9-48f7-a6b5-b5f56c30e602.privatelink.eastus.azmk8s.io"
resource_group_name   =  "MC_itg-cellcom-prod-rg_itg-cellcom-prod-aks_eastus"
virtual_network_id    = "/subscriptions/3acbc334-72a0-4b2d-b3bb-8498810f4955/resourceGroups/Best_practice/providers/Microsoft.Network/virtualNetworks/Best_practice-vnet"
}