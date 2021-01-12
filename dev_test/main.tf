provider "azurerm" {
 // version = "~>2.0"
  features {}
}

module "group-terra" {
  source = "../modules/resource_group"

  name     = local.group_name
  location = local.location
}


module "vm" {
  source = "../modules/linux_virtual_machine"

  count               = "${local.counter}"
  name                = "${local.name}-${count.index}"

  resource_group_name             = module.group-terra.name
  location                        = module.group-terra.location

  size                            = local.size
  admin_username                  = local.admin_username
  network_interface_ids           = [module.network_interface[count.index].id]
  computer_name                   = "myvm"
  disable_password_authentication = true

  admin_ssh_key = {
    username    = local.admin_username
    public_key  = file(local.ssh_file_location)
  }

  os_disk = {
    caching              = local.caching
    storage_account_type = local.storage_account_type
  }

  source_image_reference = {
    publisher = local.publisher
    offer     = local.offer
    sku       = local.sku
    version   = local.version
  }


}

