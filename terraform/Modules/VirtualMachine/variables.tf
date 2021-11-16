
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

variable "vm_name" {
    type        = string
    default     = ""
}

variable "vm_subnet" {
    type        = string
    default     = ""
}


variable "aks_sub_id"{
    type        = string
    default     = ""
}

variable "vm_size" {
    type        = string
    default     = ""
}

variable "managed_disk_type" {
    type        = string
    default     = ""
}

variable "admin_username" {
    type        = string
    default     = ""
}

variable "admin_password" {
    type        = string
    default     = ""
}

variable "backup_vault_name" {
    type        = string
    default     = ""
}
