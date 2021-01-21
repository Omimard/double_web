variable "client_secret" {
  type = string
}

provider "azurerm" {
 // version = "~>2.0"
  subscription_id = "a4183087-8a6d-42fa-b1ff-a9c8be389d97"
  client_id       = "cdb82170-3618-49ad-8dfc-b8b7e89076b0"
  client_secret   = var.client_secret
  tenant_id       = "0b5a1912-9abf-4c86-8adc-e7bf9e181bd0"

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

resource "local_file" "hosts" {
  
  count = local.counter
  content = templatefile("../templates/hosts.tpl",
    {
      webserver = [module.public_ip[count.index].ip_address]
    }
  )
  filename = "../templates/hosts"

  depends_on = [
    module.public_ip
  ]
}

output "webserver" {
  value = [local_file.hosts[].webserver]
}