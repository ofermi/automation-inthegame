

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
module "main_resource_group" {
    source              = "./Modules/ResourceGroup"
    resource_group_name = "${var.Project}-${var.Customer}-${var.Env}-rg"
    Location            = "${var.Location}"
}

module "main_vnet" {
    source                           = "./Modules/Vnet"
#    vnet_01_name                    = "${var.Project}-${var.Customer}-${var.Env}-spoke-vnet"
    aks_vnet_01_name                 = "${var.Project}-${var.Customer}-${var.Env}-aks-vnet"
    spoke_subnet                     = "${var.Project}-${var.Customer}-${var.Env}-3-spoke-subnet"
    aks_subnet_name                  = "${var.Project}-${var.Customer}-${var.Env}-3-aks-subnet"
    pe_subnet_name                   = "${var.Project}-${var.Customer}-${var.Env}-3-pe-subnet"
    Location                         = "${var.Location}"
    Environment                      = "${var.Env}"
#    cidr_address_space              = "${var.cidr_address_space}"
    aks_cidr_address_space           = "${var.cidr_address_space}"
    aks_subnet_cidr_address_space    = "${var.aks_sub_cidr_address_space}"
    spoke_subnet_cidr_address_space  = "${var.spoke_sub_cidr_address_space}"
    pe_subnet_cidr_address_space     = "${var.pe_sub_cidr_address_space}"
    lb_subnet_cidr_address_space     = "${var.lb_sub_cidr_address_space}"
    resource_group_name              = "${var.Project}-${var.Customer}-${var.Env}-rg"
    nsg_name                         = "${var.Project}-${var.Customer}-${var.Env}-nsg"
    resource_group_name_Hub          = "${var.rg_hub_name}"
    vnet_name_Hub                    = "${var.vnet_hub}"
    depends_on                       = [module.main_resource_group]
}



module "storageaccount1" {
    source              = "./Modules/StorageAccount"
    Location            = "${var.Location}"
    resource_group_name = "${var.Project}-${var.Customer}-${var.Env}-rg"
    st_name             = "admin${var.Customer}3${var.Env}"
    replication_type    = "LRS"      
    depends_on          = [module.main_resource_group]
}

module "storageaccount2" {
    source              = "./Modules/StorageAccount"
    Location            = "${var.Location}"
    resource_group_name = "${var.Project}-${var.Customer}-${var.Env}-rg"
    st_name             = "live${var.Customer}3${var.Env}" 
    replication_type    = "LRS"      
    depends_on          = [module.main_resource_group]
}

data "azurerm_virtual_network" "Hub_vnet" {
  name                = "${var.vnet_hub}"
  resource_group_name = "${var.rg_hub_name}"
}

module "Aks1" {
    aks_name                = "${var.Project}-${var.Customer}-${var.Env}-aks" 
    aks_node_pool_vm_size   = "Standard_D4s_v3" #User required to change for each project (from azure size list)
    aks_os_disk_size_gb     = "128" #User required to change for each project
    node_count              = "1" #User required to change for each project
    aks_subnet              = "${var.Project}-${var.Customer}-${var.Env}-aks-subnet" #User required to change for each project (generally should be for AKS_subnet)
    aks_sub_id              =  module.main_vnet.aks-subnet-id
    source                  = "./Modules/Aks"
    aks_vnet_01_name        = "${var.Project}-${var.Customer}-${var.Env}-spoke-vnet"
    #acr_name                = "${var.Project}-${var.Customer}${var.Env}acr01"
    Location                = "${var.Location}"
    resource_group_name     = "${var.Project}-${var.Customer}-${var.Env}-rg"
    vnet_Hub_id             = data.azurerm_virtual_network.Hub_vnet.id
#    dns_name                = "inthegame-prod-aks1-private-dns"
#    aks_resource_group_name = "MC_${var.Project}-${var.Customer}-${var.Env}-rg_${var.Project}-${var.Customer}-${var.Env}-1-aks_${var.Location}"  
    depends_on              = [module.main_vnet, module.main_resource_group]
}


# module "Aks2" {
#     aks_name                = "${var.Project}-${var.Customer}-${var.Env}-2-aks" 
#     aks_node_pool_vm_size   = "Standard_D4s_v3" #User required to change for each project (from azure size list)
#     aks_os_disk_size_gb     = "128" #User required to change for each project
#     node_count              = "1" #User required to change for each project
#     aks_subnet              = "${var.Project}-${var.Customer}-${var.Env}-3-aks-subnet" #User required to change for each project (generally should be for AKS_subnet)
#     aks_sub_id              =  module.main_vnet.aks-subnet-id
#     source                  = "./Modules/Aks"
#     aks_vnet_01_name        = "${var.Project}-${var.Customer}-${var.Env}-spoke-vnet"
#     #acr_name                = "${var.Project}-${var.Customer}${var.Env}acr01"
#     Location                = "${var.Location}"
#     resource_group_name     = "${var.Project}-${var.Customer}-${var.Env}-rg"
#     vnet_Hub_id             = data.azurerm_virtual_network.Hub_vnet.id
#     dns_name                = "inthegame-prod-aks2-private-dns"
#     aks_resource_group_name = "MC_${var.Project}-${var.Customer}-${var.Env}-rg_${var.Project}-${var.Customer}-${var.Env}-2-aks_${var.Location}"
#     depends_on              = [module.main_vnet, module.main_resource_group]
# }

# module "Aks3" {
#     aks_name                = "${var.Project}-${var.Customer}-${var.Env}-3-aks" 
#     aks_node_pool_vm_size   = "Standard_D4s_v3" #User required to change for each project (from azure size list)
#     aks_os_disk_size_gb     = "128" #User required to change for each project
#     node_count              = "1" #User required to change for each project
#     aks_subnet              = "${var.Project}-${var.Customer}-${var.Env}-3-aks-subnet" #User required to change for each project (generally should be for AKS_subnet)
#     aks_sub_id              =  module.main_vnet.aks-subnet-id
#     source                  = "./Modules/Aks"
#     aks_vnet_01_name        = "${var.Project}-${var.Customer}-${var.Env}-spoke-vnet"
#     #acr_name                = "${var.Project}-${var.Customer}${var.Env}acr01"
#     Location                = "${var.Location}"
#     resource_group_name     = "${var.Project}-${var.Customer}-${var.Env}-rg"
#     vnet_Hub_id             =  data.azurerm_virtual_network.Hub_vnet.id
#     dns_name                = "inthegame-prod-aks2-private-dns"
#     aks_resource_group_name = "MC_${var.Project}-${var.Customer}-${var.Env}-rg_${var.Project}-${var.Customer}-${var.Env}-3-aks_${var.Location}"
#     depends_on              = [module.main_vnet, module.main_resource_group]
# }

# module "Aks4" {
#     aks_name                = "${var.Project}-${var.Customer}-${var.Env}-4-aks" 
#     aks_node_pool_vm_size   = "Standard_D4s_v3" #User required to change for each project (from azure size list)
#     aks_os_disk_size_gb     = "128" #User required to change for each project
#     node_count              = "1" #User required to change for each project
#     aks_subnet              = "${var.Project}-${var.Customer}-${var.Env}-3-aks-subnet" #User required to change for each project (generally should be for AKS_subnet)
#     aks_sub_id              =  module.main_vnet.aks-subnet-id
#     source                  = "./Modules/Aks"
#     aks_vnet_01_name        = "${var.Project}-${var.Customer}-${var.Env}-spoke-vnet"
#     #acr_name                = "${var.Project}-${var.Customer}${var.Env}acr01"
#     Location                = "${var.Location}"
#     resource_group_name     = "${var.Project}-${var.Customer}-${var.Env}-rg"
#     vnet_Hub_id             = data.azurerm_virtual_network.Hub_vnet.id
#     dns_name                = "inthegame-prod-aks2-private-dns"
#     aks_resource_group_name = "MC_${var.Project}-${var.Customer}-${var.Env}-rg_${var.Project}-${var.Customer}-${var.Env}-4-aks_${var.Location}"    
#     depends_on              = [module.main_vnet, module.main_resource_group]
# }

# module "vm_linux" {
#     vm_name             = "${var.Project}-${var.Customer}-${var.Env}-vm"#User required to change for each project
#     vm_subnet           = "${var.Project}-${var.Customer}-${var.Env}-3-aks-subnet" #User required to change for each project (App_subnet / DB_subnet / SFTP_subnet)
#     aks_sub_id          =  module.main_vnet.aks-subnet-id
#     vm_size             = "Standard_D4s_v3" #User required to change for each project (from azure size list)
#     managed_disk_type   = "Standard_LRS" #User required to change for each project (from azure size list)
#     admin_username      = "${var.admin_user}" #User required to change for each project
#     admin_password      = "${var.admin_pswd}" #User required to change for each project
#     source              = "./Modules/VirtualMachine"
#     vnet_01_name        = "${var.Project}-${var.Customer}-${var.Env}-vnet"
# #    backup_vault_name   = "${var.Project}-${var.Customer}-${var.Env}-bv"
#     Location            = "${var.Location}"
#     resource_group_name = "${var.Project}-${var.Customer}-${var.Env}-rg"
#     depends_on          = [module.main_vnet, module.main_resource_group]
# }


# data "azurerm_public_ip"  "public_ip" {
#   resource_group_name     = "${var.Project}-${var.Customer}-${var.Env}-rg"
#   name                    = "${var.Project}-${var.Customer}-${var.Env}-vm-PublicIP"
#   depends_on              = [module.main_vnet, module.main_resource_group,module.vm1]
# }