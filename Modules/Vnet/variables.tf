
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

variable "vnet_01_name" {
    type        = string
    default     = ""
    description = "vnet name"
}

variable "aks_vnet_01_name" {
    type        = string
    default     = ""
    description = "aks vnet name"
}

variable "spoke_subnet" {
    type        = string
    default     = ""
    description = "spoke subnet"
}
variable "aks_subnet_name" {
    type        = string
    default     = ""
    description = "aks subnet name"
}
variable "pe_subnet_name" {
    type        = string
    default     = ""
    description = "pe subnet name"
}
variable "cidr_address_space" {
    type        = string
    default     = ""
    description = "vnet name"
}

variable "aks_cidr_address_space" {
    type        = string
    default     = ""
    description = "cidr address space aks_cidr"
}

variable "aks_subnet_cidr_address_space" {
    type        = string
    default     = ""
    description = "cidr address space for aks_subnet"
 
}

variable "spoke_subnet_cidr_address_space" {
    type        = string
    default     = ""
    description = "cidr address space for spoke_subnet"
 
}

variable "pe_subnet_cidr_address_space" {
    type        = string
    default     = ""
    description = "cidr address space for ask vnet"
 
}

variable "lb_subnet_cidr_address_space" {
    type        = string
    default     = ""
    description = "cidr address space for ask vnet"
 }

variable "nsg_name" {
    type        = string
    default     = ""
    description = "nsg name"
 }
variable "vnet_name_Hub" {
    type        = string
    default     = ""
    description = "vnet hub name"
 }

variable "resource_group_name_Hub" {
    type        = string
    default     = ""
    description = "vnet hub name"
 }
 variable "Environment" {
    type        = string
    default     = ""
    description = "prod / test / uat /Dev "
}