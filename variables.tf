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
variable "Env" {
    type        = string
    default     = "prod" #User required to change for each project
    description = "prod / test / uat /Dev "
}
variable "Location" {
    type        = string
    default     = "East US" #User required to change for each project
    description = "location for all resources"
}
# Vnet variables
variable "cidr_address_space" {
    type        = string
    default     = "172.11.0.0/16" #User required to change for each project
    description = "cidr address space for vnet01"
}

variable "aks_sub_cidr_address_space" {
    type        = string
    default     = "172.11.0.0/20" #User required to change for each project
    description = "cidr address space for ask vnet"
 
}

variable "spoke_sub_cidr_address_space" {
    type        = string
    default     = "172.11.16.0/24" #User required to change for each project
    description = "cidr address space for ask vnet"
 
}

variable "pe_sub_cidr_address_space" {
    type        = string
    default     = "172.11.17.0/24" #User required to change for each project
    description = "cidr address space for ask vnet"
 
}
variable "lb_sub_cidr_address_space" {
    type        = string
    default     = "172.11.18.0/23" #User required to change for each project
    description = "cidr address space for ask vnet"
 }
variable "aks_subnet" {
    type        = string
    default     = ""
}
#  variable "admin_user" {
#     type        = string
#     default     = "ofer"
# }
#  variable "admin_pswd" {
#     type        = string
#     default     = "QWEasd112233"
# }
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
