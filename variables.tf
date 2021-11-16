# General variables
variable "Project" {
    type        = string
    default     = "itg" #User required to change for each project
    description = " project name (itg)"
}
variable "Customer" {
    type        = string
    default     = "cellcom" #User required to change for each project
    description = "4 chars shortcut for the customer/subscription name "
}
# each  ENVIRONMET have to be change
variable "Env" {
    type        = string
    default     = "uat" #User required to change for each project and ENVIRONMET
    description = "prod / test / uat /dev "
}
variable "Location" {
    type        = string
    default     = "East US" #User required to change for each project
    description = "location for all resources"
}
# Vnet variables
variable "cidr_address_space" {
    type        = string
    default     = "172.14.0.0/16" #User required to change for each project
    description = "cidr address space for vnet01"
}

variable "head_preffix" {
    type        = string
    default     = "172" #User required to change for each project
    description = "head preffix"
}
### need to be change per ENV
variable "mid_preffix" {
    type        = string
    default     = "14" #User required to change for each project
    description =  "mid_preffix" 
}
variable "mid_suffix" {
    type        = string
    default     = "0" #User required to change for each project
    description = "mid suffix"
}
variable "suffix" {
    type        = string
    default     = "0" #User required to change for each project
    description = "suffix"
}
variable "end_suffix" {
    type        = string
    default     = "0" #User required to change for each project
    description = "subnet suffix"
}
variable "vnet_name" {
    type        = string
    default     = "aks-vnet" #User required to change for each project
    description = "subnet 1"
}

variable "subnet_1" {
    type        = string
    default     = "spoke-subnet" #User required to change for each project
    description = "vnet name suffix"
}


variable "subnet_2" {
    type        = string
    default     = "aks-subnet" #User required to change for each project
    description = "subnet 2 suffix"
}

variable "subnet_3" {
    type        = string
    default     = "pe-subnet" #User required to change for each project
    description = "subnet 3 suffix"
}

# variable "subnet_4" {
#     type        = string
#     default     = "Lb_External_IP" #User required to change for each project
#     description = "subnet 4"
# }


variable "aks_subnet" {
    type        = string
    default     = ""
}
 variable "vnet_hub" {
    type        = string
    default     = "Best_practice-vnet"
    description = "vnet hub name"
 }
 variable "rg_hub_name" {
    type        = string
    default     = "Best_practice"
    description = "vnet hub name"
 }

  variable "vnet_vm" {
    type        = string
    default     = "Best_practice-vnet"
    description = "vnet vm name"
 }
 variable "rg_vm_name" {
    type        = string
    default     = "Best_practice"
    description = "vnet vm name"
 }
 variable "input_nongodb_ip" {
    type        = string
    default     = "172.21.0.164"
    description = "vnet vm name"
 }
