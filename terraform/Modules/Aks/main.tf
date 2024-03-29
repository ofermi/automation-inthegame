
resource "azurerm_kubernetes_cluster" "aks" {
  name                    = "${var.aks_name}"
  location                = "${var.Location}"
  resource_group_name     = "${var.resource_group_name}"
  dns_prefix              = "${var.aks_name}"
  private_cluster_enabled = true

  

  default_node_pool {
  name                  = "apppool"
  availability_zones    = ["1", "2", "3"]
  vm_size               = "${var.aks_node_pool_vm_size}"
  os_disk_size_gb       = "${var.aks_os_disk_size_gb}"
  vnet_subnet_id        = "${var.aks_sub_id}"
  enable_auto_scaling   = true
  min_count             = "1"  
  max_count             = "2"
  node_count            = "${var.node_count}"
  max_pods              = "30"
  type                  = "VirtualMachineScaleSets" 
  }

  network_profile {
    network_plugin          = "azure"
    load_balancer_sku       = "Standard"
    network_policy          = "calico"
    
  }

  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed            = true
      azure_rbac_enabled = true
    }
  }

  identity {
    type = "SystemAssigned"
  }
}

#add aditional pool
resource "azurerm_kubernetes_cluster_node_pool" "nodepool1" {
  name                  = "nodepool1"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  os_disk_size_gb       = "${var.aks_os_disk_size_gb}"
  vm_size               = "Standard_B2s"
  node_count            = 1
  availability_zones    = ["1", "2", "3"]
} 



locals {
  private_dns_zone_name = join(".", slice(split(".", azurerm_kubernetes_cluster.aks.private_fqdn), 1, length(split(".", azurerm_kubernetes_cluster.aks.private_fqdn))))
#  private_dns_zone_id   = "${data.azurerm_subscription.current.id}/resourceGroups/${azurerm_kubernetes_cluster.aks.node_resource_group}/providers/Microsoft.Network/privateDnsZones/${local.private_dns_zone_name}"
}


resource "azurerm_private_dns_zone_virtual_network_link" "link_to_hub_vnet" {
name = "link_to_hub_vnet"
private_dns_zone_name = local.private_dns_zone_name
#private_dns_zone_name = azurerm_private_dns_zone.aks_private_dns_zone.name
#resource_group_name   = "${var.aks_resource_group_name}"
resource_group_name   =  azurerm_kubernetes_cluster.aks.node_resource_group       
virtual_network_id    = "${var.vnet_Hub_id}"
depends_on = [azurerm_kubernetes_cluster.aks]
}

 # Add role assignment on RG for connect AKS to VNET


data  "azurerm_resource_group" "Resource_Group_01" {
  name     = "${var.resource_group_name}"
 }
 
resource "azurerm_role_assignment" "role_AKSpool" {
  scope                            = data.azurerm_resource_group.Resource_Group_01.id
  role_definition_name             = "Contributor"
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
  skip_service_principal_aad_check = true
   depends_on = [azurerm_kubernetes_cluster.aks]
}
# data "azurerm_user_assigned_identity" "managed_identity" {
#   resource_group_name = azurerm_kubernetes_cluster.aks.node_resource_group
#   name                = "${var.aks_name}-agentpool"
#   depends_on = [azurerm_kubernetes_cluster.aks]
#   }

# resource "azurerm_role_assignment" "role_serive_principle" {
#   scope                            = data.azurerm_resource_group.Resource_Group_01.id
#   role_definition_name             = "Contributor"
#   principal_id                     = data.azurerm_user_assigned_identity.managed_identity.id
#   skip_service_principal_aad_check = true
#   depends_on = [data.azurerm_user_assigned_identity.managed_identity]
# }