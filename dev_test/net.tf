
module "virtual_network" {
  source = "../modules/virtual_network"

  name                = local.network_name
  address_space       = local.address_space
  location            = module.group-terra.location
  resource_group_name = module.group-terra.name
}

module "subnet" {
  source = "../modules/subnet"

  name                  = local.subnet_name
  resource_group_name    = module.group-terra.name
  virtual_network_name  = module.virtual_network.name
  address_prefixes      = local.address_prefixes
}

module "network_interface" {
  source = "../modules/network_interface"
  count                           = local.counter
  name                            = "${local.interface_name}-${count.index}"
  location                        = module.group-terra.location
  resource_group_name             = module.group-terra.name

  ip_configuration = {
    name                          = local.subnet_name
    subnet_id                     = module.subnet.id
    private_ip_address_allocation = local.private_ip_address_allocation
    public_ip_address_id          = module.public_ip[count.index].id
  }
}

module "public_ip" {
  source = "../modules/public_ip"

  count = local.counter

  name                         = "${local.public_IP_name}-${count.index}"
  location                     = module.group-terra.location
  resource_group_name          = module.group-terra.name
  allocation_method            = "Dynamic"

}