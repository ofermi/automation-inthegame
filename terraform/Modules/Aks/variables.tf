
variable "Location" {
    type        = string
    default     = ""
    description = "location for all resources"
}

variable "resource_group_name" {
    type        = string
    default     = ""
    description = "rg name"
}

variable "aks_vnet_01_name" {
    type        = string
    default     = ""
    description = "vnet name"
}

variable "aks_subnet" {
    type        = string
    default     = ""
    
}


variable "aks_sub_id"{
    type        = string
    default     = ""
}
    

variable "aks_name" {
    type        = string
    default     = ""
}

variable "aks_node_pool_vm_size" {
    type        = string
    default     = ""
}

variable "node_count" {
    type        = string
    default     = ""
}

variable "aks_os_disk_size_gb" {
    type        = string
    default     = ""
}

variable "acr_name" {
    type        = string
    default     = ""
}
 variable "tier" {
    type        = string
    default     = ""   
}
variable "vnet_Hub_id" {
    type        = string
    default     = ""
    description = "vnet hub name"
 }
# variable "dns_name" {
#     type        = string
#     default     = ""
#     description = "vnet hub name"
#  }

# variable "aks_resource_group_name" {
#     type        = string
#     default     = ""
#     description = "aks resource group name"
#  } 
  