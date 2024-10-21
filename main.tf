resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "deny_inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "deny_outbound"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


resource "azurerm_subnet" "subnet_1" {
  name                 = var.subnet_1_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_1_address_prefix
}

resource "azurerm_subnet" "subnet_2" {
  name                 = var.subnet_2_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_2_address_prefix
}


data "azurerm_route_table" "existing_udr" {
  name                = "UDR"
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_route_table_association" "subnet_1_association" {
  subnet_id      = azurerm_subnet.subnet_1.id
  route_table_id = data.azurerm_route_table.existing_udr.id
}

resource "azurerm_subnet_route_table_association" "subnet_2_association" {
  subnet_id      = azurerm_subnet.subnet_2.id
  route_table_id = data.azurerm_route_table.existing_udr.id
}
