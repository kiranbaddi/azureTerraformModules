# Security Group for bastion Node

resource "azurerm_network_security_group" "bastion" {
  name                = "bastion"
  location            = var.location
  resource_group_name = var.resourceGroupName
}

resource "azurerm_network_security_rule" "bastion" {
  count                       = length(var.bastion_inbound_ports)                            
  name                        = "sgrule-bastion-${count.index}" 
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = 100 * (count.index + 1)
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = element(var.bastion_inbound_ports, count.index)                               
  protocol                    = "Tcp"
  resource_group_name         = var.resourceGroupName
  network_security_group_name = azurerm_network_security_group.bastion.name
}


# Associate bastion NSG To bastion subnet
resource "azurerm_subnet_network_security_group_association" "bastion" {
  subnet_id = azurerm_subnet.bastion.id
  network_security_group_id = azurerm_network_security_group.bastion.id
}


# Security Group for be  Node
resource "azurerm_network_security_group" "be" {
  name                = "be"
  location            = var.location
  resource_group_name = var.resourceGroupName
}

resource "azurerm_network_security_rule" "be" {
  count                       = length(var.be_inbound_ports)
  name                        = "sgrule-be-${count.index}"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = 100 * (count.index + 1)
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = element(var.be_inbound_ports, count.index)
  protocol                    = "Tcp"
  resource_group_name         = var.resourceGroupName
  network_security_group_name = azurerm_network_security_group.be.name
}


# be Security Group Association

resource "azurerm_subnet_network_security_group_association" "be" {
  subnet_id = azurerm_subnet.be.id
  network_security_group_id = azurerm_network_security_group.be.id
}

#fe Security Group

resource "azurerm_network_security_group" "fe" {
  name                = "fe"
  location            = var.location
  resource_group_name = var.resourceGroupName
}



resource "azurerm_network_security_rule" "fe" {
  count                       = length(var.fe_inbound_ports)
  name                        = "sgrule-fe-${count.index}"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = 100 * (count.index + 1)
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = element(var.fe_inbound_ports, count.index)
  protocol                    = "Tcp"
  resource_group_name         = var.resourceGroupName
  network_security_group_name = azurerm_network_security_group.fe.name
}


# fe Security Group Association

resource "azurerm_subnet_network_security_group_association" "fe" {
  subnet_id = azurerm_subnet.fe.id
  network_security_group_id = azurerm_network_security_group.fe.id
}
