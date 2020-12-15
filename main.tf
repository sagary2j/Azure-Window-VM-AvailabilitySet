resource "azurerm_resource_group" "rg" {
  name     = var.resourceGroupName
  location = var.location

  tags = {
    environment = "Dev"
  }
}

resource "azurerm_availability_set" "cmAset" {
  name                = "tridion-dev-cm-aset"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

data "azurerm_subnet" "ttdefault" {
  name = var.target_subnet_name
  virtual_network_name  = var.target_vnet_name
  resource_group_name   = var.subnet_rg
}

resource "azurerm_network_interface" "nic" {
  name                = "tridion-dev-cm-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.ttdefault.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "tridion_vm" {
  name                = "cm-test"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B2s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  availability_set_id = azurerm_availability_set.cmAset.id
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
