resource "azurerm_storage_account" "st01" {
  name                     = "${var.st_name}"
  resource_group_name      = "${var.resource_group_name}"
  location                 = "${var.Location}"
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"
  allow_blob_public_access = "true"
  account_replication_type = "${var.replication_type}" 

   blob_properties {
    delete_retention_policy {
      days = 7
    }
    container_delete_retention_policy {
      days = 7
    }

    }

   static_website {
       index_document           = "index.html"
       error_404_document       = "index.html"
   }

 
}
