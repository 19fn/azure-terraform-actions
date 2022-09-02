variable "rg_name" {
  type        = string
  default     = "RG-DEVTEST-EU01"
  description = "Resource group name."
}

variable "rg_location" {
  type        = string
  default     = "East US"
  description = "Resource group location."
}

variable "vnet_name" {
  type        = string
  default     = "VNET-DEVTEST-EU01"
  description = "Virtual network name."
}

variable "subnet_name" {
  type        = string
  default     = "SUB-MSSQL-DEVTEST-EU01"
  description = "Virtual network name."
}

variable "mysql_server_name" {
  type        = string
  default     = "mysql-server-devtest-eu01"
  description = "MySQL Server Name"
}

variable "mysql_database_name" {
  type        = string
  default     = "mssql-database-devtest-eu01"
  description = "MySQL Database Name"
}

variable "mysql_firewall_rule_name" {
  type        = string
  default     = "mysql-firewall-rule-home-ip"
  description = "MySQL Firewall Rule Name"
}

variable "mysql_vnet_name" {
  type        = string
  default     = "mysql-vnet-devtest-eu01"
  description = "MySQL Vnet Name"
}

variable "admin_name" {
  type        = string
  default     = "devadmin"
  description = "MySQL Administrator"
}

variable "admin_password" {
  type        = string
  default     = "bKS1s4X7Sb9hdOGP"
  description = "MySQL Administrator Password"
}