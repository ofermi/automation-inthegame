
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

variable "mysql_name" {
    type        = string
    default     = ""
    description = "vnet name"
}

variable "sku_mysql_name" {
    type        = string
    default     = ""
}

variable "mysql_admin_login" {
    type        = string
    default     = ""
}

variable "mysql_admin_pass" {
    type        = string
    default     = ""
}

variable "vnet_01_name" {
    type        = string
    default     = ""
    description = "vnet name"
}

variable "pe_subnet" {
    type        = string
    default     = ""
}