

# ##################################
# # private Env.
# ##################################
terraform {
  backend "azurerm" {
    resource_group_name  = "githubrunterraform"
    
    storage_account_name = "storeterraformstatefile"
    container_name       = "tfstatedevops"
    key                  = "terraform.tfstate"
  }
}
###########################
# Customer
##########################
# terraform {
#    backend "azurerm" {
#      resource_group_name  = "automation-resources-data-rg"
#      storage_account_name = "tfdatainthegame"
#      container_name       = "tfstatedevopsinthegame"
#      key                  = "terraform.tfstate"
#    }
#  }

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

# module "main_vnet" {
#     source                           = "./Modules/Vnet"
# #    vnet_01_name                    = "${var.Project}-${var.Customer}-${var.Env}-spoke-vnet"
#     aks_vnet_01_name                 = "${var.Project}-${var.Customer}-${var.Env}-aks-vnet"
#     spoke_subnet                     = "${var.Project}-${var.Customer}-${var.Env}-3-spoke-subnet"
#     aks_subnet_name                  = "${var.Project}-${var.Customer}-${var.Env}-3-aks-subnet"
#     pe_subnet_name                   = "${var.Project}-${var.Customer}-${var.Env}-3-pe-subnet"
#     Location                         = "${var.Location}"
#     Environment                      = "${var.Env}"
#     aks_cidr_address_space           = "${var.cidr_address_space}"
#     aks_subnet_cidr_address_space    = "${var.aks_sub_cidr_address_space}"
#     spoke_subnet_cidr_address_space  = "${var.spoke_sub_cidr_address_space}"
#     pe_subnet_cidr_address_space     = "${var.pe_sub_cidr_address_space}"
#     #lb_subnet_cidr_address_space     = "${var.lb_sub_cidr_address_space}"
#     resource_group_name              = "${var.Project}-${var.Customer}-${var.Env}-rg"
#     nsg_name                         = "${var.Project}-${var.Customer}-${var.Env}-nsg"
#     resource_group_name_vm          = "${var.rg_vm_name}"
#     vnet_name_vm                    = "${var.vnet_vm}"
#     resource_group_name_Hub          = "${var.rg_hub_name}"
#     vnet_name_Hub                    = "${var.vnet_hub}"
#     depends_on                       = [module.main_resource_group]
# }

locals {
    calc_mid_seffix_sub1            = "${var.mid_suffix}"
    calc_mid_seffix_sub2            = "${var.mid_suffix}"+16
    calc_mid_seffix_sub3            = "${var.mid_suffix}"+17
    calc_mid_seffix_sub4            = "${var.mid_suffix}"+18
    clac_sub_suffix_aks             = "${var.end_suffix}"+20
    clac_sub_suffix_all             = "${var.end_suffix}"+24

}

module "main_vnet" {
    source                           = "./Modules/Vnet"
    aks_vnet_01_name                 = "${var.Project}-${var.Customer}-${var.Env}-aks-vnet"
    spoke_subnet                     = "${var.Project}-${var.Customer}-${var.Env}-${var.subnet_1}"
    aks_subnet_name                  = "${var.Project}-${var.Customer}-${var.Env}-${var.subnet_2}"
    pe_subnet_name                   = "${var.Project}-${var.Customer}-${var.Env}-${var.subnet_3}"
    Location                         = "${var.Location}"
    Environment                      = "${var.Env}"
    aks_cidr_address_space           = "${var.cidr_address_space}"
    aks_subnet_cidr_address_space    = "${var.head_preffix}.${var.mid_preffix}.${local.calc_mid_seffix_sub1}.${var.suffix}/${local.clac_sub_suffix_aks}"
    spoke_subnet_cidr_address_space  = "${var.head_preffix}.${var.mid_preffix}.${local.calc_mid_seffix_sub2}.${var.suffix}/${local.clac_sub_suffix_all}"
    pe_subnet_cidr_address_space     = "${var.head_preffix}.${var.mid_preffix}.${local.calc_mid_seffix_sub3}.${var.suffix}/${local.clac_sub_suffix_all}"
    resource_group_name              = "${var.Project}-${var.Customer}-${var.Env}-rg"
    nsg_name                         = "${var.Project}-${var.Customer}-${var.Env}-nsg"
    resource_group_name_vm           = "${var.rg_vm_name}"
    vnet_name_vm                     = "${var.vnet_vm}"
    resource_group_name_Hub          = "${var.rg_hub_name}"
    vnet_name_Hub                    = "${var.vnet_hub}"
    depends_on                       = [module.main_resource_group]
}

module "storageaccount1" {
    source              = "./Modules/StorageAccount"
    Location            = "${var.Location}"
    resource_group_name = "${var.Project}-${var.Customer}-${var.Env}-rg"
    st_name             = "admincellcom${var.Env}ofer"
    replication_type    = "LRS"      
    depends_on          = [module.main_resource_group]
}



module "storageaccount2" {
    source              = "./Modules/StorageAccount"
    Location            = "${var.Location}"
    resource_group_name = "${var.Project}-${var.Customer}-${var.Env}-rg"
    st_name             = "livecellcom${var.Env}ofer" 
    replication_type    = "LRS"      
    depends_on          = [module.main_resource_group]
}
module "storageaccount3" {
    source              = "./Modules/StorageAccount"
    Location            = "${var.Location}"
    resource_group_name = "${var.Project}-${var.Customer}-${var.Env}-rg"
    st_name             = "html5cellcom${var.Env}ofer" 
    replication_type    = "LRS"      
    depends_on          = [module.main_resource_group]
}
data "azurerm_virtual_network" "vm_vnet" {
  name                = "${var.vnet_vm}"
  resource_group_name = "${var.rg_vm_name}"
}

module "Aks1" {
    aks_name                = "${var.Project}-${var.Customer}-${var.Env}-aks" 
    aks_node_pool_vm_size   = "Standard_D4s_v3" #User required to change for each project (from azure size list)
    aks_os_disk_size_gb     = "128" #User required to change for each project
    node_count              = "1" #User required to change for each project
    aks_subnet              = "${var.Project}-${var.Customer}-${var.Env}-aks-subnet" #User required to change for each project (generally should be for AKS_subnet)
    aks_sub_id              =  module.main_vnet.aks-subnet-id
    source                  = "./Modules/Aks"
    aks_vnet_01_name        = "${var.Project}-${var.Customer}-${var.Env}-vnet"
    Location                = "${var.Location}"
    resource_group_name     = "${var.Project}-${var.Customer}-${var.Env}-rg"
    vnet_Hub_id             = data.azurerm_virtual_network.vm_vnet.id
    depends_on              = [module.main_vnet, module.main_resource_group]
}

