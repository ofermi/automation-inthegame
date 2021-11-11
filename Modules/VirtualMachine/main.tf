

# data "azurerm_subnet" "vm_subnet" {
#   name                 = "${var.vm_subnet}"
#   virtual_network_name = "${var.vnet_01_name}"
#   resource_group_name  = "${var.resource_group_name}"
# }


# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
    name                         = "${var.vm_name}-PublicIP"
    location                     = "${var.Location}"
    resource_group_name          = "${var.resource_group_name}"
    allocation_method            = "Dynamic"

    }

resource "azurerm_network_interface" "nic01" {
  name                = "${var.vm_name}-nic01"
  location            = "${var.Location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "IPConfig1"
    subnet_id                     = "${var.aks_sub_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
  }
}

# # Create (and display) an SSH key
# resource "tls_private_key" "connect_ssh" {
#   algorithm = "RSA"
#   rsa_bits = 4096
# }


#resource "azurerm_virtual_machine" "vm" {
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "${var.vm_name}"
  location              = "${var.Location}"
  resource_group_name   = "${var.resource_group_name}"
  network_interface_ids = [azurerm_network_interface.nic01.id]
  size               = "${var.vm_size}"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  #delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  # storage_image_reference {
  #   publisher = "MicrosoftWindowsServer"
  #   offer     = "WindowsServer"
  #   sku       = "2019-Datacenter"
  #   version   = "latest"
  # }


  source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }
  
 
  os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    storage_account_type  = "${var.managed_disk_type}"
  }

    computer_name  = "${var.vm_name}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"

    disable_password_authentication = false

    # admin_ssh_key {
    #     username       = "${var.admin_username}"
    #     public_key     = tls_private_key.connect_ssh.public_key_openssh
    # }

  boot_diagnostics  {
    storage_account_uri  = "" 
  }
}

# Enable backup for VM (un\comment this part by your needs)
/*
data "azurerm_backup_policy_vm" "policy" {
  name                = "DefaultPolicy"
  recovery_vault_name = "${var.backup_vault_name}"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_backup_protected_vm" "vm_backup" {
  resource_group_name = "${var.resource_group_name}"
  recovery_vault_name = "${var.backup_vault_name}"
  source_vm_id        = azurerm_virtual_machine.vm.id
  backup_policy_id    = data.azurerm_backup_policy_vm.policy.id
}

*/