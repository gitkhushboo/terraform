resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space
  location            = var.location
  depends_on          = [azurerm_resource_group.rg]
}

# Subnet
resource "azurerm_subnet" "sbnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_space
  depends_on           = [azurerm_virtual_network.vnet]
}

# Public IP
resource "azurerm_public_ip" "pip" {
  name                = var.pip_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = "Static"
}

# Network Interface
resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  ip_configuration {
    name                          = var.ip_name
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
    subnet_id                     = azurerm_subnet.sbnet.id
  }
  depends_on = [azurerm_subnet.sbnet, azurerm_public_ip.pip]
}

# Windows Virtual Machine
resource "azurerm_windows_virtual_machine" "windkhushvm" {
  name                  = var.vm_name
  computer_name         = var.vm_computer_name
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  size                  = var.size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "win10-21h2-pro"
    version   = "latest"
  }
  depends_on = [azurerm_network_interface.nic]
}

# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  security_rule {
    name                       = "allow-rdp"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "Allow inbound RDP traffic on port 3389"
  }
}

# Associate Network Interface with NSG
resource "azurerm_network_interface_security_group_association" "nsgasoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Outputs
output "vm_public_ip" {
  value     = azurerm_public_ip.pip.ip_address
  sensitive = true
}

output "vm_private_ip" {
  value     = azurerm_network_interface.nic.private_ip_address
  sensitive = true
}

output "vm_name" {
  value     = azurerm_windows_virtual_machine.windkhushvm
  sensitive = true
}

output "admin_username" {
  value = var.admin_username
}
