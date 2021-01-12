variable "name" {
    type = string
}

variable "resource_group_name" {
    type = string
}

variable "location" {
    type = string
}

variable "size" {
    type = string
}

variable "admin_username" {
    type = string
}

variable "network_interface_ids" {
    type = list(string)
}

variable "computer_name" {
    type = string
}

variable "disable_password_authentication" {
    type = bool
}

variable "admin_ssh_key" {
    type = map
} 
  
variable "os_disk" {
    type = map
}

variable "source_image_reference" {
    type = map
}
