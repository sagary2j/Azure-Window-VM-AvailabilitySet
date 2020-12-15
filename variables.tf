variable "subscriptionID" {
    type = string
    description = "Variable for our subscriptionID"
}

variable "client_id" {
    type = string
    description = "Variable for our client_id"
}

variable "client_secret" {
    type = string
    description = "Variable for our client_secret"
}

variable "tenant_id" {
    type = string
    description = "Variable for our tenant_id"
}

variable "resourceGroupName" {
    type = string
    description = "name of resource group"
}

variable "location" {
    type = string
    description = "location of your resource group"
}

variable "subnet_rg" {
    description = "Resourcegroup name"
}

variable "target_vnet_name" {
    description = "Vnet name"
}

variable "target_subnet_name" {
    description = "Vnet name"
}

variable "admin_username" {
    default = "testadmin"
}
 
variable "admin_password" {
    default = "P@$$w0rd1234!"
}
 


