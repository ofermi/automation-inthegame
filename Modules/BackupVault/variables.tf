
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

variable "backup_vault_name" {
    type        = string
    default     = ""
}
