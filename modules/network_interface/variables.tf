variable "ip_configuration" {
    type = object({
        name                          = string
        subnet_id                     = string
        private_ip_address_allocation = string
        public_ip_address_id          = string
    })
}

variable "name" {
    type = string
}

variable "location" {
    type = string
}

variable "resource_group_name" {
    type = string
}

