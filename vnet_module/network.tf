
resource "azurerm_virtual_network" "myapp" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resourceGroupName
  tags                = var.tags
}

resource "azurerm_subnet" "bastion" {
  name                 = "bastion"
  resource_group_name  = var.resourceGroupName
  virtual_network_name = azurerm_virtual_network.myapp.name
  address_prefixes       = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "fe" {
  name                 = "fe"
  resource_group_name  = var.resourceGroupName
  virtual_network_name = azurerm_virtual_network.myapp.name
  address_prefixes       = ["10.0.1.0/24"]
}


resource "azurerm_subnet" "be" {
  name                 = "be"
  resource_group_name  = var.resourceGroupName
  virtual_network_name = azurerm_virtual_network.myapp.name
  address_prefixes       = ["10.0.3.0/24"]
}





