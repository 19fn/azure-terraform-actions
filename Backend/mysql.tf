resource "azurerm_mysql_server" "server" {
  name                = var.mysql_server_name
  location            = var.rg_location
  resource_group_name = var.rg_name

  administrator_login          = var.admin_name
  administrator_login_password = var.admin_password

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = false
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"
}

resource "azurerm_mysql_database" "database" {
  name                = var.mysql_database_name
  resource_group_name = var.rg_name
  server_name         = var.mysql_server_name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"

  depends_on = [
    azurerm_mysql_server.server
  ]
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

resource "azurerm_mysql_firewall_rule" "firewall_rule" {
  name                = var.mysql_firewall_rule_name
  resource_group_name = var.rg_name
  server_name         = var.mysql_server_name
  start_ip_address    = "181.46.137.29"
  end_ip_address      = "181.46.137.29"

  depends_on = [
    azurerm_mysql_server.server,
    azurerm_mysql_database.database
  ]
}

resource "azurerm_mysql_virtual_network_rule" "vnet_rule" {
  name                = var.mysql_vnet_name
  resource_group_name = var.rg_name
  server_name         = var.mysql_server_name
  subnet_id           = data.azurerm_subnet.subnet.id

  depends_on = [
    azurerm_mysql_server.server,
    azurerm_mysql_database.database,
    data.azurerm_subnet.subnet
  ]
}