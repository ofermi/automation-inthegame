output "aks_name" {
  value = module.Aks1.aks1_name
  }
output "resource_group_name" {
  value = "${var.Project}-${var.Customer}-${var.Env}-rg"
  } 
 output "mongo_ip" {
  value = "${var.input_nongodb_ip}"
  }
 

