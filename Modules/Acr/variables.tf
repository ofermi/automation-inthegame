
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

variable "private_endpoint_subnet" {
    type        = string
    default     = ""
    description = "vnet name"
}

variable "private_endpoint_vnet_01_name" {
    type        = string
    default     = ""
}

variable "acr_name" {
    type        = string
    default     = ""
}

variable "acr_sku" {
    type        = string
    default     = ""
}
