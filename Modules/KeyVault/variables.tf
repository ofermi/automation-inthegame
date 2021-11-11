
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

variable "key_vault_name" {
    type        = string
    default     = ""
    description = "key vault name"
}
