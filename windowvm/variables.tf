variable "rg_name" {
  default = "terraform_rg"
}

variable "location" {
  default = "West US"
}

variable "vnet_name" {
  default = "terraform_vnet"
}

variable "subnet_name" {
  default = "terraform_subnet"
}

variable "address_space" {
  default = ["10.1.0.0/16"]
  type    = list(string)
}

variable "subnet_space" {
  default = ["10.1.1.0/24"]
  type    = list(string)
}

variable "nic_name" {
  default = "terraform_nic"
}

variable "pip_name" {
  default = "terraform_pip"
}

variable "ip_name" {
  default = "terraform_ip"
}

variable "size" {
  default = "Standard_D2s_v3"
}

variable "admin_username" {
  default = "khushboo"
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "vm_name" {
  default = "wind_khush_vm"
}

variable "vm_computer_name" {
  default = "winvm"
}

variable "nsg" {
  default = "terraform_nsg"
}
