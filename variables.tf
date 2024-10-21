variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnet_1_name" {
  type = string
}

variable "subnet_1_address_prefix" {
  type = list(string)
}

variable "subnet_2_name" {
  type = string
}

variable "subnet_2_address_prefix" {
  type = list(string)
}

variable "nsg_name" {
  type = string
}

variable "udr_name" {
  type = string
}
