output "aks_name" {

 value = "itg-cellcom-prod-aks"

  }
output "resource_group_name" {
  value = "${var.Project}-${var.Customer}-${var.Env}-rg"
  } 

# output "vm_public_ip_address" {
#  value = data.azurerm_public_ip.public_ip.ip_address
#  }
# output "admin_username" {
#   value = var.admin_user
#   }
# output "admin_pswd" {
#   value = var.admin_pswd
#   }  

