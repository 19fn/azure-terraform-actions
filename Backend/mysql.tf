resource "azurerm_mssql_server" "server" {
  name                              = var.mysql_server_name
  location                          = var.rg_location
  resource_group_name               = var.rg_name
  version                           = "12.0"
  administrator_login               = var.admin_name
  administrator_login_password      = var.admin_password
  minimum_tls_version               = "1.2"

  tags = {
    environment = "devtest"
  }
}

resource "azurerm_mssql_database" "database" {
  name           = var.mysql_database_name
  server_id      = azurerm_mssql_server.server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "S0"
  zone_redundant = true

  tags = {
    environment = "devtest"
  }

    depends_on = [
    azurerm_mssql_server.server
  ]
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
  address_prefixes     = [ "10.0.3.4" ]
  service_endpoints    = ["Microsoft.Sql"]
}

resource "azurerm_mssql_firewall_rule" "firewall_rule" {
  name                = var.mysql_firewall_rule_name
  server_id           = azurerm_mssql_server.server.id
  start_ip_address    = "181.46.137.29"
  end_ip_address      = "181.46.137.29"

  depends_on = [
    azurerm_mssql_server.server
  ]
}

resource "azurerm_mssql_virtual_network_rule" "vnet_rule" {
  name      = var.mysql_vnet_name
  server_id = azurerm_mssql_server.server.id
  subnet_id = azurerm_subnet.subnet.id

  depends_on = [
    azurerm_mysql_server.server,
    data.azurerm_subnet.subnet
  ]
}