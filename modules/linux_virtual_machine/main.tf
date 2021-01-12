resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.size
  admin_username                  = var.admin_username
  network_interface_ids           = var.network_interface_ids
  computer_name                   = var.computer_name
  disable_password_authentication = var.disable_password_authentication
  admin_ssh_key {
    username    = var.admin_ssh_key["username"]
    public_key  = var.admin_ssh_key["public_key"]
  }
  os_disk {
    caching              = var.os_disk["caching"]
    storage_account_type = var.os_disk["storage_account_type"]
  }
  source_image_reference {
    publisher   = var.source_image_reference["publisher"]
    offer       = var.source_image_reference["offer"]
    sku         = var.source_image_reference["sku"]
    version     = var.source_image_reference["version"]
  }
  
}