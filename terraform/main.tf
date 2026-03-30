provider "azurerm" {
  features {}
}

# -----------------------------
# Resource Group
# -----------------------------
resource "azurerm_resource_group" "rg" {
  name     = "devops-rg4"
  location = "West Europe"
}

# -----------------------------
# Azure Container Registry (ACR)
# -----------------------------
resource "azurerm_container_registry" "acr" {
  name                = "devopsacr78901"  # CHANGE if error (must be unique)
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# -----------------------------
# AKS Cluster
# -----------------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "devops-aks4"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "devopsaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_d2_v4"   # safer for free tier
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "dev"
  }
}

# -----------------------------
# Output (IMPORTANT)
# -----------------------------
output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}