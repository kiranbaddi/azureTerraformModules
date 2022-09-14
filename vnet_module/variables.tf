variable "prefix" {
}

variable "location" {
}

variable "resourceGroupName" {
  type = string
  description = "Name of the resource group to be passed from calling module"
}


variable "bastion_inbound_ports" {
  type = list(string)
}

variable "fe_inbound_ports" {
  type = list(string)
}


variable "be_inbound_ports" {
  type = list(string)
}

variable "tags" {
  type = map(string)

  default = {
    name = "demo"
  }

  description = "Any tags which should be assigned to the resources in this example"
}
