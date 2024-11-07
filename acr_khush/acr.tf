data azurerm_resource_group registry{
			name = "registry"
		}
		
		resource azurerm_container_registry tfreg{
			name = "terraformreg1220"
			resource_group_name = data.azurerm_resource_group.registry.name
			location = data.azurerm_resource_group.registry.location
			sku = "Premium"
			admin_enabled  = true
		}
		
		output adminpwd{
			value = azurerm_container_registry.tfreg.admin_password
                sensitive = true
		}
		
		resource "azurerm_container_registry_token" "token" {
		  name                    = "t12345"
		  container_registry_name = azurerm_container_registry.tfreg.name
		  resource_group_name     = data.azurerm_resource_group.registry.name
		  scope_map_id            = data.azurerm_container_registry_scope_map.scope.id
		}

		data "azurerm_container_registry_scope_map" "scope" {
		  name                    = "_repositories_pull"
		  resource_group_name     = data.azurerm_resource_group.registry.name
		  container_registry_name = azurerm_container_registry.tfreg.name
		}
		
		resource "azurerm_container_registry_token_password" "pwd" {
		container_registry_token_id = azurerm_container_registry_token.token.id

		  password1 {
			expiry = "2024-11-08T17:57:36+08:00"
		  }
		}
