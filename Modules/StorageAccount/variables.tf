
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

variable "st_name" {
    type        = string
    default     = ""
    description = "vnet name"
}



variable "replication_type" {
    type        = string
    default     = ""
    description = "replication type name"
}