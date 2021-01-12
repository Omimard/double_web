locals {
  counter                       = 0

  group_name                    = "webservers"
  location                      = "uksouth"
  name                          = "slave"
  size                          = "Standard_B1s"
  admin_username                = "azureuser"
  ssh_file_location             = "~/.ssh/id_rsa.pub"
  caching                       = "ReadWrite"
  storage_account_type          = "Standard_LRS"
  publisher                     = "Canonical"
  offer                         = "UbuntuServer"
  sku                           = "18.04-LTS"
  version                       = "latest"
  network_name                  = "webservers-network"
  address_space                 = ["10.0.0.0/16"]
  subnet_name                   = "internal"
  address_prefixes              = ["10.0.2.0/24"]
  interface_name                = "network_interface"
  private_ip_address_allocation = "Dynamic"

  public_IP_name               = "slavePublicIP"
  public_IP_location           = "uksouth"
  allocation_method            = "Dynamic"

}
