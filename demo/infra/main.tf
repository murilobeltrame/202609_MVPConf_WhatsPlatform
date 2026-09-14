terraform {
  required_providers {
    azurerm = {
      source  = "azurerm"
      version = "4.80.0"
    }
  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "res-0" {
  location   = "brazilsouth"
  managed_by = ""
  name       = "mvpconf-demo"
  tags       = {}
}
resource "azurerm_api_management" "res-1" {
  client_certificate_enabled    = false
  gateway_disabled              = false
  location                      = "brazilsouth"
  min_api_version               = ""
  name                          = "mbc-apim"
  notification_sender_email     = "apimgmt-noreply@mail.windowsazure.com"
  public_ip_address_id          = ""
  public_network_access_enabled = true
  publisher_email               = "murilo@homework.com"
  publisher_name                = "HomeWork"
  resource_group_name           = azurerm_resource_group.res-0.name
  sku_name                      = "Developer_1"
  tags                          = {}
  virtual_network_type          = "None"
  zones                         = []
  delegation {
    subscriptions_enabled     = false
    url                       = ""
    user_registration_enabled = false
    validation_key            = "" # Masked sensitive attribute
  }
  hostname_configuration {
    proxy {
      certificate                     = "" # Masked sensitive attribute
      certificate_password            = "" # Masked sensitive attribute
      default_ssl_binding             = true
      host_name                       = "mbc-apim.azure-api.net"
      key_vault_certificate_id        = ""
      key_vault_id                    = ""
      negotiate_client_certificate    = false
      ssl_keyvault_identity_client_id = ""
    }
  }
  protocols {
    enable_http2  = false
    http2_enabled = false
  }
  security {
    backend_ssl30_enabled                               = false
    backend_tls10_enabled                               = false
    backend_tls11_enabled                               = false
    enable_backend_ssl30                                = false
    enable_backend_tls10                                = false
    enable_backend_tls11                                = false
    enable_frontend_ssl30                               = false
    enable_frontend_tls10                               = false
    enable_frontend_tls11                               = false
    frontend_ssl30_enabled                              = false
    frontend_tls10_enabled                              = false
    frontend_tls11_enabled                              = false
    tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = false
    tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = false
    tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = false
    tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = false
    tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = false
    tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = false
    tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = false
    tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = false
    tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = false
    tls_rsa_with_aes256_gcm_sha384_ciphers_enabled      = false
    triple_des_ciphers_enabled                          = false
  }
  sign_in {
    enabled = false
  }
  sign_up {
    enabled = true
    terms_of_service {
      consent_required = false
      enabled          = false
      text             = ""
    }
  }
}
resource "azurerm_api_management_api_version_set" "res-3" {
  api_management_name = "mbc-apim"
  description         = ""
  display_name        = "WinePlatform"
  name                = "6aa1e698e58eb5b57d6156b8"
  resource_group_name = azurerm_resource_group.res-0.name
  version_header_name = ""
  version_query_name  = ""
  versioning_scheme   = "Segment"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_api" "res-4" {
  api_management_name   = "mbc-apim"
  api_type              = "http"
  description           = ""
  display_name          = "Echo API"
  name                  = "echo-api"
  path                  = "echo"
  protocols             = ["https"]
  resource_group_name   = azurerm_resource_group.res-0.name
  revision              = "1"
  revision_description  = ""
  service_url           = "https://echo.playground.azure-api.net/api"
  subscription_required = true
  terms_of_service_url  = ""
  version               = ""
  version_description   = ""
  version_set_id        = ""
  subscription_key_parameter_names {
    header = "Ocp-Apim-Subscription-Key"
    query  = "subscription-key"
  }
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_api_operation" "res-5" {
  api_management_name = "mbc-apim"
  api_name            = "echo-api"
  description         = "A demonstration of a POST call based on the echo backend above. The request body is expected to contain JSON-formatted data (see example below). A policy is used to automatically transform any request sent in JSON directly to XML. In a real-world scenario this could be used to enable modern clients to speak to a legacy backend."
  display_name        = "Create resource"
  method              = "POST"
  operation_id        = "create-resource"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/resource"
  request {
    description = ""
    representation {
      content_type = "application/json"
      schema_id    = ""
      type_name    = ""
      example {
        description    = ""
        external_value = ""
        name           = "default"
        summary        = ""
        value = jsonencode({
          avgSpeed    = 90
          maxSpeed    = 125
          speedUnit   = "mph"
          vehicleType = "train"
        })
      }
    }
  }
  response {
    description = ""
    status_code = 200
  }
  depends_on = [
    azurerm_api_management_api.res-4,
  ]
}
resource "azurerm_api_management_api_operation_policy" "res-6" {
  api_management_name = "mbc-apim"
  api_name            = "echo-api"
  operation_id        = "create-resource"
  resource_group_name = azurerm_resource_group.res-0.name
  xml_content         = "<policies>\r\n\t<inbound>\r\n\t\t<base />\r\n\t\t<json-to-xml apply=\"always\" consider-accept-header=\"false\" />\r\n\t</inbound>\r\n\t<backend>\r\n\t\t<base />\r\n\t</backend>\r\n\t<outbound>\r\n\t\t<base />\r\n\t</outbound>\r\n</policies>"
  depends_on = [
    azurerm_api_management_api_operation.res-5,
  ]
}
resource "azurerm_api_management_api_operation" "res-7" {
  api_management_name = "mbc-apim"
  api_name            = "echo-api"
  description         = "A demonstration of a PUT call handled by the same \"echo\" backend as above. You can now specify a request body in addition to headers and it will be returned as well."
  display_name        = "Modify Resource"
  method              = "PUT"
  operation_id        = "modify-resource"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/resource"
  request {
    description = ""
  }
  response {
    description = ""
    status_code = 200
  }
  depends_on = [
    azurerm_api_management_api.res-4,
  ]
}
resource "azurerm_api_management_api_operation" "res-8" {
  api_management_name = "mbc-apim"
  api_name            = "echo-api"
  description         = "A demonstration of a DELETE call which traditionally deletes the resource. It is based on the same \"echo\" backend as in all other operations so nothing is actually deleted."
  display_name        = "Remove resource"
  method              = "DELETE"
  operation_id        = "remove-resource"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/resource"
  request {
    description = ""
  }
  response {
    description = ""
    status_code = 200
  }
  depends_on = [
    azurerm_api_management_api.res-4,
  ]
}
resource "azurerm_api_management_api_operation" "res-9" {
  api_management_name = "mbc-apim"
  api_name            = "echo-api"
  description         = "The HEAD operation returns only headers. In this demonstration a policy is used to set additional headers when the response is returned and to enable JSONP."
  display_name        = "Retrieve header only"
  method              = "HEAD"
  operation_id        = "retrieve-header-only"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/resource"
  request {
    description = ""
  }
  response {
    description = ""
    status_code = 200
  }
  depends_on = [
    azurerm_api_management_api.res-4,
  ]
}
resource "azurerm_api_management_api_operation_policy" "res-10" {
  api_management_name = "mbc-apim"
  api_name            = "echo-api"
  operation_id        = "retrieve-header-only"
  resource_group_name = azurerm_resource_group.res-0.name
  xml_content         = "<policies>\r\n\t<inbound>\r\n\t\t<base />\r\n\t</inbound>\r\n\t<backend>\r\n\t\t<base />\r\n\t</backend>\r\n\t<outbound>\r\n\t\t<base />\r\n\t\t<set-header name=\"X-My-Sample\" exists-action=\"override\">\r\n\t\t\t<value>This is a sample</value>\r\n\t\t\t<!-- for multiple headers with the same name add additional value elements -->\r\n\t\t</set-header>\r\n\t\t<jsonp callback-parameter-name=\"ProcessResponse\" />\r\n\t</outbound>\r\n</policies>"
  depends_on = [
    azurerm_api_management_api_operation.res-9,
  ]
}
resource "azurerm_api_management_api_operation" "res-11" {
  api_management_name = "mbc-apim"
  api_name            = "echo-api"
  description         = "A demonstration of a GET call on a sample resource. It is handled by an \"echo\" backend which returns a response equal to the request (the supplied headers and body are being returned as received)."
  display_name        = "Retrieve resource"
  method              = "GET"
  operation_id        = "retrieve-resource"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/resource"
  request {
    description = ""
    query_parameter {
      default_value = "sample"
      description   = "A sample parameter that is required and has a default value of \"sample\"."
      name          = "param1"
      required      = true
      schema_id     = ""
      type          = "string"
      type_name     = ""
      values        = ["sample"]
    }
    query_parameter {
      default_value = ""
      description   = "Another sample parameter, set to not required."
      name          = "param2"
      required      = false
      schema_id     = ""
      type          = "number"
      type_name     = ""
      values        = []
    }
  }
  response {
    description = "Returned in all cases."
    status_code = 200
  }
  depends_on = [
    azurerm_api_management_api.res-4,
  ]
}
resource "azurerm_api_management_api_operation" "res-12" {
  api_management_name = "mbc-apim"
  api_name            = "echo-api"
  description         = "A demonstration of a GET call with caching enabled on the same \"echo\" backend as above. Cache TTL is set to 1 hour. When you make the first request the headers you supplied will be cached. Subsequent calls will return the same headers as the first time even if you change them in your request."
  display_name        = "Retrieve resource (cached)"
  method              = "GET"
  operation_id        = "retrieve-resource-cached"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/resource-cached"
  request {
    description = ""
    query_parameter {
      default_value = "sample"
      description   = "A sample parameter that is required and has a default value of \"sample\"."
      name          = "param1"
      required      = true
      schema_id     = ""
      type          = "string"
      type_name     = ""
      values        = ["sample"]
    }
    query_parameter {
      default_value = ""
      description   = "Another sample parameter, set to not required."
      name          = "param2"
      required      = false
      schema_id     = ""
      type          = "string"
      type_name     = ""
      values        = []
    }
  }
  response {
    description = ""
    status_code = 200
  }
  depends_on = [
    azurerm_api_management_api.res-4,
  ]
}
resource "azurerm_api_management_api_operation_policy" "res-13" {
  api_management_name = "mbc-apim"
  api_name            = "echo-api"
  operation_id        = "retrieve-resource-cached"
  resource_group_name = azurerm_resource_group.res-0.name
  xml_content         = "<policies>\r\n\t<inbound>\r\n\t\t<base />\r\n\t\t<cache-lookup vary-by-developer=\"false\" vary-by-developer-groups=\"false\">\r\n\t\t\t<vary-by-header>Accept</vary-by-header>\r\n\t\t\t<vary-by-header>Accept-Charset</vary-by-header>\r\n\t\t</cache-lookup>\r\n\t\t<rewrite-uri template=\"/resource\" />\r\n\t</inbound>\r\n\t<backend>\r\n\t\t<base />\r\n\t</backend>\r\n\t<outbound>\r\n\t\t<base />\r\n\t\t<cache-store duration=\"3600\" />\r\n\t</outbound>\r\n</policies>"
  depends_on = [
    azurerm_api_management_api_operation.res-12,
  ]
}
resource "azurerm_api_management_api_policy" "res-15" {
  api_management_name = "mbc-apim"
  api_name            = "wine-platform-mcp"
  resource_group_name = azurerm_resource_group.res-0.name
  xml_content         = "<!--\r\n    - Policies are applied in the order they appear.\r\n    - Position <base/> inside a section to inherit policies from the outer scope.\r\n    - Comments within policies are not preserved.\r\n-->\r\n<!-- Add policies as children to the <inbound>, <outbound>, <backend>, and <on-error> elements -->\r\n<policies>\r\n\t<!-- Throttle, authorize, validate, cache, or transform the requests -->\r\n\t<inbound></inbound>\r\n\t<!-- Control if and how the requests are forwarded to services  -->\r\n\t<backend>\r\n\t\t<base />\r\n\t</backend>\r\n\t<!-- Customize the responses -->\r\n\t<outbound></outbound>\r\n\t<!-- Handle exceptions and customize error responses  -->\r\n\t<on-error>\r\n\t\t<base />\r\n\t</on-error>\r\n</policies>"
}
resource "azurerm_api_management_api" "res-16" {
  api_management_name   = "mbc-apim"
  api_type              = "http"
  description           = ""
  display_name          = "WinePlatform"
  name                  = "wineplatform"
  path                  = ""
  protocols             = ["http", "https"]
  resource_group_name   = azurerm_resource_group.res-0.name
  revision              = "1"
  revision_description  = ""
  service_url           = "https://mbc-rest-demo.calmriver-f10577e0.brazilsouth.azurecontainerapps.io/"
  subscription_required = true
  terms_of_service_url  = ""
  version               = "v1"
  version_description   = ""
  version_set_id        = azurerm_api_management_api_version_set.res-3.id
  subscription_key_parameter_names {
    header = "Ocp-Apim-Subscription-Key"
    query  = "subscription-key"
  }
}
resource "azurerm_api_management_api_operation" "res-17" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  description         = ""
  display_name        = "CreateVineyard"
  method              = "POST"
  operation_id        = "CreateVineyard"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/vineyards"
  request {
    description = ""
  }
  response {
    description = "OK"
    status_code = 200
  }
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_operation_tag" "res-18" {
  api_operation_id = azurerm_api_management_api_operation.res-17.id
  display_name     = "Vineyards"
  name             = "Vineyards"
}
resource "azurerm_api_management_api_operation" "res-19" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  description         = ""
  display_name        = "CreateWine"
  method              = "POST"
  operation_id        = "CreateWine"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/wines"
  request {
    description = ""
  }
  response {
    description = "OK"
    status_code = 200
  }
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_operation_tag" "res-20" {
  api_operation_id = azurerm_api_management_api_operation.res-19.id
  display_name     = "Wines"
  name             = "Wines"
}
resource "azurerm_api_management_api_operation" "res-21" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  description         = ""
  display_name        = "CreateWinery"
  method              = "POST"
  operation_id        = "CreateWinery"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/wineries"
  request {
    description = ""
  }
  response {
    description = "OK"
    status_code = 200
  }
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_operation_tag" "res-22" {
  api_operation_id = azurerm_api_management_api_operation.res-21.id
  display_name     = "Wineries"
  name             = "Wineries"
}
resource "azurerm_api_management_api_operation" "res-23" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  description         = ""
  display_name        = "GetGrapes"
  method              = "GET"
  operation_id        = "GetGrapes"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/grapes"
  request {
    description = ""
    query_parameter {
      default_value = ""
      description   = ""
      name          = "name"
      required      = false
      schema_id     = "6aa1e69946346115a4a85630"
      type          = "string"
      type_name     = "GrapesGetRequest"
      values        = []
    }
    query_parameter {
      default_value = ""
      description   = ""
      name          = "type"
      required      = false
      schema_id     = "6aa1e69946346115a4a85630"
      type          = "integer"
      type_name     = "GrapeType"
      values        = []
    }
  }
  response {
    description = "OK"
    status_code = 200
    representation {
      content_type = "application/json"
      schema_id    = "6aa1e69946346115a4a85630"
      type_name    = "GrapesGet200ApplicationJsonResponse"
      example {
        description    = ""
        external_value = ""
        name           = "default"
        summary        = ""
        value = jsonencode([{
          name = "string"
          regions = [{
            native = true
            region = {
              country = {
                name = "string"
              }
              name = "string"
            }
          }]
          type = 0
        }])
      }
    }
  }
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_operation_tag" "res-24" {
  api_operation_id = azurerm_api_management_api_operation.res-23.id
  display_name     = "Grapes"
  name             = "Grapes"
}
resource "azurerm_api_management_api_operation" "res-25" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  description         = ""
  display_name        = "GetUnavailableCatalog"
  method              = "GET"
  operation_id        = "GetUnavailableCatalog"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/catalogo/indisponivel"
  request {
    description = ""
  }
  response {
    description = "OK"
    status_code = 200
  }
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_operation_tag" "res-26" {
  api_operation_id = azurerm_api_management_api_operation.res-25.id
  display_name     = "Catalog"
  name             = "Catalog"
}
resource "azurerm_api_management_api_operation" "res-27" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  description         = ""
  display_name        = "GetVineyard"
  method              = "GET"
  operation_id        = "GetVineyard"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/vineyards/{vineyardId}"
  request {
    description = ""
  }
  response {
    description = "OK"
    status_code = 200
  }
  template_parameter {
    default_value = ""
    description   = ""
    name          = "vineyardId"
    required      = true
    schema_id     = "6aa1e69946346115a4a85630"
    type          = "string"
    type_name     = "Vineyards-vineyardId-GetRequest"
    values        = []
  }
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_operation_tag" "res-28" {
  api_operation_id = azurerm_api_management_api_operation.res-27.id
  display_name     = "Vineyards"
  name             = "Vineyards"
}
resource "azurerm_api_management_api_operation" "res-29" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  description         = ""
  display_name        = "GetWine"
  method              = "GET"
  operation_id        = "GetWine"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/wines/{wineId}"
  request {
    description = ""
  }
  response {
    description = "OK"
    status_code = 200
  }
  template_parameter {
    default_value = ""
    description   = ""
    name          = "wineId"
    required      = true
    schema_id     = "6aa1e69946346115a4a85630"
    type          = "string"
    type_name     = "Wines-wineId-GetRequest"
    values        = []
  }
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_operation_tag" "res-30" {
  api_operation_id = azurerm_api_management_api_operation.res-29.id
  display_name     = "Wines"
  name             = "Wines"
}
resource "azurerm_api_management_api_operation" "res-31" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  description         = ""
  display_name        = "GetWinery"
  method              = "GET"
  operation_id        = "GetWinery"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/wineries/{wineryId}"
  request {
    description = ""
  }
  response {
    description = "OK"
    status_code = 200
  }
  template_parameter {
    default_value = ""
    description   = ""
    name          = "wineryId"
    required      = true
    schema_id     = "6aa1e69946346115a4a85630"
    type          = "string"
    type_name     = "Wineries-wineryId-GetRequest"
    values        = []
  }
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_operation_tag" "res-32" {
  api_operation_id = azurerm_api_management_api_operation.res-31.id
  display_name     = "Wineries"
  name             = "Wineries"
}
resource "azurerm_api_management_api_operation" "res-33" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  description         = ""
  display_name        = "ListCatalogWines"
  method              = "GET"
  operation_id        = "ListCatalogWines"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/catalogo/vinhos"
  request {
    description = ""
    query_parameter {
      default_value = ""
      description   = ""
      name          = "page"
      required      = false
      schema_id     = "6aa1e69946346115a4a85630"
      type          = ""
      type_name     = "CatalogoVinhosGetRequest"
      values        = []
    }
    query_parameter {
      default_value = ""
      description   = ""
      name          = "pageSize"
      required      = false
      schema_id     = "6aa1e69946346115a4a85630"
      type          = ""
      type_name     = "CatalogoVinhosGetRequest-1"
      values        = []
    }
    query_parameter {
      default_value = ""
      description   = ""
      name          = "wineryId"
      required      = false
      schema_id     = "6aa1e69946346115a4a85630"
      type          = "string"
      type_name     = "CatalogoVinhosGetRequest-2"
      values        = []
    }
    query_parameter {
      default_value = ""
      description   = ""
      name          = "vintage"
      required      = false
      schema_id     = "6aa1e69946346115a4a85630"
      type          = ""
      type_name     = "CatalogoVinhosGetRequest-3"
      values        = []
    }
  }
  response {
    description = "OK"
    status_code = 200
  }
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_operation_tag" "res-34" {
  api_operation_id = azurerm_api_management_api_operation.res-33.id
  display_name     = "Catalog"
  name             = "Catalog"
}
resource "azurerm_api_management_api_operation" "res-35" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  description         = ""
  display_name        = "ListCellarInventory"
  method              = "GET"
  operation_id        = "ListCellarInventory"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/estoque/adegas"
  request {
    description = ""
    query_parameter {
      default_value = ""
      description   = ""
      name          = "page"
      required      = false
      schema_id     = "6aa1e69946346115a4a85630"
      type          = ""
      type_name     = "EstoqueAdegasGetRequest"
      values        = []
    }
    query_parameter {
      default_value = ""
      description   = ""
      name          = "pageSize"
      required      = false
      schema_id     = "6aa1e69946346115a4a85630"
      type          = ""
      type_name     = "EstoqueAdegasGetRequest-1"
      values        = []
    }
    query_parameter {
      default_value = ""
      description   = ""
      name          = "wineryId"
      required      = false
      schema_id     = "6aa1e69946346115a4a85630"
      type          = "string"
      type_name     = "EstoqueAdegasGetRequest-2"
      values        = []
    }
  }
  response {
    description = "OK"
    status_code = 200
  }
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_operation_tag" "res-36" {
  api_operation_id = azurerm_api_management_api_operation.res-35.id
  display_name     = "Inventory"
  name             = "Inventory"
}
resource "azurerm_api_management_api_operation" "res-37" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  description         = ""
  display_name        = "ListVineyards"
  method              = "GET"
  operation_id        = "ListVineyards"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/vineyards"
  request {
    description = ""
    query_parameter {
      default_value = ""
      description   = ""
      name          = "wineryId"
      required      = false
      schema_id     = "6aa1e69946346115a4a85630"
      type          = "string"
      type_name     = "VineyardsGetRequest"
      values        = []
    }
  }
  response {
    description = "OK"
    status_code = 200
  }
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_operation_tag" "res-38" {
  api_operation_id = azurerm_api_management_api_operation.res-37.id
  display_name     = "Vineyards"
  name             = "Vineyards"
}
resource "azurerm_api_management_api_operation" "res-39" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  description         = ""
  display_name        = "ListWineries"
  method              = "GET"
  operation_id        = "ListWineries"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/wineries"
  request {
    description = ""
    query_parameter {
      default_value = ""
      description   = ""
      name          = "page"
      required      = false
      schema_id     = "6aa1e69946346115a4a85630"
      type          = ""
      type_name     = "WineriesGetRequest"
      values        = []
    }
    query_parameter {
      default_value = ""
      description   = ""
      name          = "pageSize"
      required      = false
      schema_id     = "6aa1e69946346115a4a85630"
      type          = ""
      type_name     = "WineriesGetRequest-1"
      values        = []
    }
  }
  response {
    description = "OK"
    status_code = 200
  }
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_operation_tag" "res-40" {
  api_operation_id = azurerm_api_management_api_operation.res-39.id
  display_name     = "Wineries"
  name             = "Wineries"
}
resource "azurerm_api_management_api_operation" "res-41" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  description         = ""
  display_name        = "ListWines"
  method              = "GET"
  operation_id        = "ListWines"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/wines"
  request {
    description = ""
    query_parameter {
      default_value = ""
      description   = ""
      name          = "page"
      required      = false
      schema_id     = "6aa1e69946346115a4a85630"
      type          = ""
      type_name     = "WinesGetRequest"
      values        = []
    }
    query_parameter {
      default_value = ""
      description   = ""
      name          = "pageSize"
      required      = false
      schema_id     = "6aa1e69946346115a4a85630"
      type          = ""
      type_name     = "WinesGetRequest-1"
      values        = []
    }
    query_parameter {
      default_value = ""
      description   = ""
      name          = "wineryId"
      required      = false
      schema_id     = "6aa1e69946346115a4a85630"
      type          = "string"
      type_name     = "WinesGetRequest-2"
      values        = []
    }
  }
  response {
    description = "OK"
    status_code = 200
  }
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_operation_tag" "res-42" {
  api_operation_id = azurerm_api_management_api_operation.res-41.id
  display_name     = "Wines"
  name             = "Wines"
}
resource "azurerm_api_management_api_operation" "res-43" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  description         = ""
  display_name        = "UpdateVineyard"
  method              = "PATCH"
  operation_id        = "UpdateVineyard"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/vineyards/{vineyardId}"
  request {
    description = ""
  }
  response {
    description = "OK"
    status_code = 200
  }
  template_parameter {
    default_value = ""
    description   = ""
    name          = "vineyardId"
    required      = true
    schema_id     = "6aa1e69946346115a4a85630"
    type          = "string"
    type_name     = "Vineyards-vineyardId-PatchRequest"
    values        = []
  }
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_operation_tag" "res-44" {
  api_operation_id = azurerm_api_management_api_operation.res-43.id
  display_name     = "Vineyards"
  name             = "Vineyards"
}
resource "azurerm_api_management_api_operation" "res-45" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  description         = ""
  display_name        = "UpdateWine"
  method              = "PATCH"
  operation_id        = "UpdateWine"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/wines/{wineId}"
  request {
    description = ""
  }
  response {
    description = "OK"
    status_code = 200
  }
  template_parameter {
    default_value = ""
    description   = ""
    name          = "wineId"
    required      = true
    schema_id     = "6aa1e69946346115a4a85630"
    type          = "string"
    type_name     = "Wines-wineId-PatchRequest"
    values        = []
  }
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_operation_tag" "res-46" {
  api_operation_id = azurerm_api_management_api_operation.res-45.id
  display_name     = "Wines"
  name             = "Wines"
}
resource "azurerm_api_management_api_operation" "res-47" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  description         = ""
  display_name        = "UpdateWinery"
  method              = "PATCH"
  operation_id        = "UpdateWinery"
  resource_group_name = azurerm_resource_group.res-0.name
  url_template        = "/wineries/{wineryId}"
  request {
    description = ""
  }
  response {
    description = "OK"
    status_code = 200
  }
  template_parameter {
    default_value = ""
    description   = ""
    name          = "wineryId"
    required      = true
    schema_id     = "6aa1e69946346115a4a85630"
    type          = "string"
    type_name     = "Wineries-wineryId-PatchRequest"
    values        = []
  }
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_operation_tag" "res-48" {
  api_operation_id = azurerm_api_management_api_operation.res-47.id
  display_name     = "Wineries"
  name             = "Wineries"
}
resource "azurerm_api_management_api_schema" "res-49" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  components = jsonencode({
    schemas = {
      CatalogoVinhosGetRequest = {
        format        = "int32"
        pattern       = "^-?(?:0|[1-9]\\d*)$"
        x-apim-inline = true
      }
      CatalogoVinhosGetRequest-1 = {
        format        = "int32"
        pattern       = "^-?(?:0|[1-9]\\d*)$"
        x-apim-inline = true
      }
      CatalogoVinhosGetRequest-2 = {
        format        = "uuid"
        type          = "string"
        x-apim-inline = true
      }
      CatalogoVinhosGetRequest-3 = {
        format        = "int32"
        pattern       = "^-?(?:0|[1-9]\\d*)$"
        x-apim-inline = true
      }
      Country = {
        properties = {
          name = {
            type = "string"
          }
        }
        required = ["name"]
        type     = "object"
      }
      EstoqueAdegasGetRequest = {
        format        = "int32"
        pattern       = "^-?(?:0|[1-9]\\d*)$"
        x-apim-inline = true
      }
      EstoqueAdegasGetRequest-1 = {
        format        = "int32"
        pattern       = "^-?(?:0|[1-9]\\d*)$"
        x-apim-inline = true
      }
      EstoqueAdegasGetRequest-2 = {
        format        = "uuid"
        type          = "string"
        x-apim-inline = true
      }
      Grape = {
        properties = {
          name = {
            type = "string"
          }
          regions = {
            items = {
              "$ref" = "#/components/schemas/GrapeRegion"
            }
            type = "array"
          }
          type = {
            "$ref" = "#/components/schemas/GrapeType"
          }
        }
        required = ["name", "type", "regions"]
        type     = "object"
      }
      GrapeRegion = {
        properties = {
          native = {
            type = "boolean"
          }
          region = {
            "$ref" = "#/components/schemas/Region"
          }
        }
        required = ["region", "native"]
        type     = "object"
      }
      GrapeType = {
        type = "integer"
      }
      GrapesGet200ApplicationJsonResponse = {
        items = {
          "$ref" = "#/components/schemas/Grape"
        }
        type          = "array"
        x-apim-inline = true
      }
      GrapesGetRequest = {
        type          = "string"
        x-apim-inline = true
      }
      Region = {
        properties = {
          country = {
            "$ref" = "#/components/schemas/Country"
          }
          name = {
            type = "string"
          }
        }
        required = ["name", "country"]
        type     = "object"
      }
      Vineyards-vineyardId-GetRequest = {
        format        = "uuid"
        type          = "string"
        x-apim-inline = true
      }
      Vineyards-vineyardId-PatchRequest = {
        format        = "uuid"
        type          = "string"
        x-apim-inline = true
      }
      VineyardsGetRequest = {
        format        = "uuid"
        type          = "string"
        x-apim-inline = true
      }
      Wineries-wineryId-GetRequest = {
        format        = "uuid"
        type          = "string"
        x-apim-inline = true
      }
      Wineries-wineryId-PatchRequest = {
        format        = "uuid"
        type          = "string"
        x-apim-inline = true
      }
      WineriesGetRequest = {
        format        = "int32"
        pattern       = "^-?(?:0|[1-9]\\d*)$"
        x-apim-inline = true
      }
      WineriesGetRequest-1 = {
        format        = "int32"
        pattern       = "^-?(?:0|[1-9]\\d*)$"
        x-apim-inline = true
      }
      Wines-wineId-GetRequest = {
        format        = "uuid"
        type          = "string"
        x-apim-inline = true
      }
      Wines-wineId-PatchRequest = {
        format        = "uuid"
        type          = "string"
        x-apim-inline = true
      }
      WinesGetRequest = {
        format        = "int32"
        pattern       = "^-?(?:0|[1-9]\\d*)$"
        x-apim-inline = true
      }
      WinesGetRequest-1 = {
        format        = "int32"
        pattern       = "^-?(?:0|[1-9]\\d*)$"
        x-apim-inline = true
      }
      WinesGetRequest-2 = {
        format        = "uuid"
        type          = "string"
        x-apim-inline = true
      }
    }
  })
  content_type        = "application/vnd.oai.openapi.components+json"
  resource_group_name = azurerm_resource_group.res-0.name
  schema_id           = "6aa1e69946346115a4a85630"
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_tag_description" "res-50" {
  api_tag_id                         = "/subscriptions/c8422a40-6f30-4238-aaf9-f46c0ee23a22/resourceGroups/mvpconf-demo/providers/Microsoft.ApiManagement/service/mbc-apim/apis/wineplatform/tags/Catalog"
  description                        = ""
  external_documentation_description = ""
  external_documentation_url         = ""
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_tag_description" "res-51" {
  api_tag_id                         = "/subscriptions/c8422a40-6f30-4238-aaf9-f46c0ee23a22/resourceGroups/mvpconf-demo/providers/Microsoft.ApiManagement/service/mbc-apim/apis/wineplatform/tags/Grapes"
  description                        = ""
  external_documentation_description = ""
  external_documentation_url         = ""
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_tag_description" "res-52" {
  api_tag_id                         = "/subscriptions/c8422a40-6f30-4238-aaf9-f46c0ee23a22/resourceGroups/mvpconf-demo/providers/Microsoft.ApiManagement/service/mbc-apim/apis/wineplatform/tags/Inventory"
  description                        = ""
  external_documentation_description = ""
  external_documentation_url         = ""
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_tag_description" "res-53" {
  api_tag_id                         = "/subscriptions/c8422a40-6f30-4238-aaf9-f46c0ee23a22/resourceGroups/mvpconf-demo/providers/Microsoft.ApiManagement/service/mbc-apim/apis/wineplatform/tags/Vineyards"
  description                        = ""
  external_documentation_description = ""
  external_documentation_url         = ""
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_tag_description" "res-54" {
  api_tag_id                         = "/subscriptions/c8422a40-6f30-4238-aaf9-f46c0ee23a22/resourceGroups/mvpconf-demo/providers/Microsoft.ApiManagement/service/mbc-apim/apis/wineplatform/tags/Wineries"
  description                        = ""
  external_documentation_description = ""
  external_documentation_url         = ""
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_api_tag_description" "res-55" {
  api_tag_id                         = "/subscriptions/c8422a40-6f30-4238-aaf9-f46c0ee23a22/resourceGroups/mvpconf-demo/providers/Microsoft.ApiManagement/service/mbc-apim/apis/wineplatform/tags/Wines"
  description                        = ""
  external_documentation_description = ""
  external_documentation_url         = ""
  depends_on = [
    azurerm_api_management_api.res-16,
  ]
}
resource "azurerm_api_management_backend" "res-56" {
  api_management_name = "mbc-apim"
  description         = "mbc-rest-demo"
  name                = "ContainerApp_mbc-rest-demo"
  protocol            = "http"
  resource_group_name = azurerm_resource_group.res-0.name
  resource_id         = "https://management.azure.com/subscriptions/c8422a40-6f30-4238-aaf9-f46c0ee23a22/resourceGroups/mvpconf-demo/providers/Microsoft.App/containerApps/mbc-rest-demo"
  title               = ""
  url                 = "https://mbc-rest-demo.calmriver-f10577e0.brazilsouth.azurecontainerapps.io"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_backend" "res-57" {
  api_management_name = "mbc-apim"
  description         = ""
  name                = "wine-platform-mcp-backend-f2c136b5-53f1-4e69-8a20-24d546e75f2c"
  protocol            = "http"
  resource_group_name = azurerm_resource_group.res-0.name
  resource_id         = ""
  title               = ""
  url                 = "https://mbc-mcp-demo.calmriver-f10577e0.brazilsouth.azurecontainerapps.io"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_diagnostic" "res-58" {
  always_log_errors         = false
  api_management_logger_id  = azurerm_api_management_logger.res-65.id
  api_management_name       = "mbc-apim"
  http_correlation_protocol = ""
  identifier                = "azuremonitor"
  log_client_ip             = true
  operation_name_format     = ""
  resource_group_name       = azurerm_resource_group.res-0.name
  sampling_percentage       = 100
  verbosity                 = ""
  backend_request {
    body_bytes     = 0
    headers_to_log = []
    data_masking {
      query_params {
        mode  = "Hide"
        value = "*"
      }
    }
  }
  frontend_request {
    body_bytes     = 0
    headers_to_log = []
    data_masking {
      query_params {
        mode  = "Hide"
        value = "*"
      }
    }
  }
}
resource "azurerm_api_management_group" "res-60" {
  api_management_name = "mbc-apim"
  description         = "Administrators is a built-in group containing the admin email account provided at the time of service creation. Its membership is managed by the system."
  display_name        = "Administrators"
  external_id         = ""
  name                = "administrators"
  resource_group_name = azurerm_resource_group.res-0.name
  type                = "system"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_group_user" "res-61" {
  api_management_name = "mbc-apim"
  group_name          = "administrators"
  resource_group_name = azurerm_resource_group.res-0.name
  user_id             = "1"
  depends_on = [
    azurerm_api_management_group.res-60,
  ]
}
resource "azurerm_api_management_group" "res-62" {
  api_management_name = "mbc-apim"
  description         = "Developers is a built-in group. Its membership is managed by the system. Signed-in users fall into this group."
  display_name        = "Developers"
  external_id         = ""
  name                = "developers"
  resource_group_name = azurerm_resource_group.res-0.name
  type                = "system"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_group_user" "res-63" {
  api_management_name = "mbc-apim"
  group_name          = "developers"
  resource_group_name = azurerm_resource_group.res-0.name
  user_id             = "1"
  depends_on = [
    azurerm_api_management_group.res-62,
  ]
}
resource "azurerm_api_management_group" "res-64" {
  api_management_name = "mbc-apim"
  description         = "Guests is a built-in group. Its membership is managed by the system. Unauthenticated users visiting the developer portal fall into this group."
  display_name        = "Guests"
  external_id         = ""
  name                = "guests"
  resource_group_name = azurerm_resource_group.res-0.name
  type                = "system"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_logger" "res-65" {
  api_management_name = "mbc-apim"
  buffered            = true
  description         = ""
  name                = "azuremonitor"
  resource_group_name = azurerm_resource_group.res-0.name
  resource_id         = ""
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_policy" "res-73" {
  api_management_id = azurerm_api_management.res-1.id
  xml_content       = "<!--\r\n    IMPORTANT:\r\n    - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.\r\n    - Only the <forward-request> policy element can appear within the <backend> section element.\r\n    - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.\r\n    - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.\r\n    - To add a policy position the cursor at the desired insertion point and click on the round button associated with the policy.\r\n    - To remove a policy, delete the corresponding policy statement from the policy document.\r\n    - Policies are applied in the order of their appearance, from the top down.\r\n-->\r\n<policies>\r\n\t<inbound />\r\n\t<backend>\r\n\t\t<forward-request />\r\n\t</backend>\r\n\t<outbound />\r\n</policies>"
}
resource "azurerm_api_management_product" "res-78" {
  api_management_name   = "mbc-apim"
  approval_required     = false
  description           = "Subscribers will be able to run 5 calls/minute up to a maximum of 100 calls/week."
  display_name          = "Starter"
  product_id            = "starter"
  published             = true
  resource_group_name   = azurerm_resource_group.res-0.name
  subscription_required = true
  subscriptions_limit   = 1
  terms                 = ""
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_product_api" "res-80" {
  api_management_name = "mbc-apim"
  api_name            = "echo-api"
  product_id          = "starter"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-78,
  ]
}
resource "azurerm_api_management_product_group" "res-84" {
  api_management_name = "mbc-apim"
  group_name          = "administrators"
  product_id          = "starter"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-78,
  ]
}
resource "azurerm_api_management_product_group" "res-85" {
  api_management_name = "mbc-apim"
  group_name          = "developers"
  product_id          = "starter"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-78,
  ]
}
resource "azurerm_api_management_product_group" "res-86" {
  api_management_name = "mbc-apim"
  group_name          = "guests"
  product_id          = "starter"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-78,
  ]
}
resource "azurerm_api_management_product_policy" "res-87" {
  api_management_name = "mbc-apim"
  product_id          = "starter"
  resource_group_name = azurerm_resource_group.res-0.name
  xml_content         = "<!--\r\n            IMPORTANT:\r\n            - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.\r\n            - Only the <forward-request> policy element can appear within the <backend> section element.\r\n            - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.\r\n            - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.\r\n            - To add a policy position the cursor at the desired insertion point and click on the round button associated with the policy.\r\n            - To remove a policy, delete the corresponding policy statement from the policy document.\r\n            - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.\r\n            - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.\r\n            - Policies are applied in the order of their appearance, from the top down.\r\n        -->\r\n<policies>\r\n\t<inbound>\r\n\t\t<rate-limit calls=\"5\" renewal-period=\"60\" />\r\n\t\t<quota calls=\"100\" renewal-period=\"604800\" />\r\n\t\t<base />\r\n\t</inbound>\r\n\t<backend>\r\n\t\t<base />\r\n\t</backend>\r\n\t<outbound>\r\n\t\t<base />\r\n\t</outbound>\r\n</policies>"
  depends_on = [
    azurerm_api_management_product.res-78,
  ]
}
resource "azurerm_api_management_product" "res-88" {
  api_management_name   = "mbc-apim"
  approval_required     = true
  description           = "Subscribers have completely unlimited access to the API. Administrator approval is required."
  display_name          = "Unlimited"
  product_id            = "unlimited"
  published             = true
  resource_group_name   = azurerm_resource_group.res-0.name
  subscription_required = true
  subscriptions_limit   = 1
  terms                 = ""
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_product_api" "res-90" {
  api_management_name = "mbc-apim"
  api_name            = "echo-api"
  product_id          = "unlimited"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-88,
  ]
}
resource "azurerm_api_management_product_group" "res-94" {
  api_management_name = "mbc-apim"
  group_name          = "administrators"
  product_id          = "unlimited"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-88,
  ]
}
resource "azurerm_api_management_product_group" "res-95" {
  api_management_name = "mbc-apim"
  group_name          = "developers"
  product_id          = "unlimited"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-88,
  ]
}
resource "azurerm_api_management_product_group" "res-96" {
  api_management_name = "mbc-apim"
  group_name          = "guests"
  product_id          = "unlimited"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-88,
  ]
}
resource "azurerm_api_management_product" "res-97" {
  api_management_name   = "mbc-apim"
  approval_required     = false
  description           = "The Store that sells WInes"
  display_name          = "WineStore"
  product_id            = "winestore"
  published             = true
  resource_group_name   = azurerm_resource_group.res-0.name
  subscription_required = true
  subscriptions_limit   = 0
  terms                 = ""
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_product_api" "res-100" {
  api_management_name = "mbc-apim"
  api_name            = "wine-platform-mcp"
  product_id          = "winestore"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-97,
  ]
}
resource "azurerm_api_management_product_api" "res-101" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  product_id          = "winestore"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-97,
  ]
}
resource "azurerm_api_management_product_group" "res-105" {
  api_management_name = "mbc-apim"
  group_name          = "administrators"
  product_id          = "winestore"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-97,
  ]
}
resource "azurerm_api_management_product_group" "res-106" {
  api_management_name = "mbc-apim"
  group_name          = "developers"
  product_id          = "winestore"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-97,
  ]
}
resource "azurerm_api_management_product_group" "res-107" {
  api_management_name = "mbc-apim"
  group_name          = "guests"
  product_id          = "winestore"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-97,
  ]
}
resource "azurerm_api_management_product" "res-108" {
  api_management_name   = "mbc-apim"
  approval_required     = false
  description           = "The producer of Wines"
  display_name          = "Wineyard"
  product_id            = "wineyard"
  published             = true
  resource_group_name   = azurerm_resource_group.res-0.name
  subscription_required = true
  subscriptions_limit   = 0
  terms                 = ""
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_product_api" "res-111" {
  api_management_name = "mbc-apim"
  api_name            = "wine-platform-mcp"
  product_id          = "wineyard"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-108,
  ]
}
resource "azurerm_api_management_product_api" "res-112" {
  api_management_name = "mbc-apim"
  api_name            = "wineplatform"
  product_id          = "wineyard"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-108,
  ]
}
resource "azurerm_api_management_product_group" "res-116" {
  api_management_name = "mbc-apim"
  group_name          = "administrators"
  product_id          = "wineyard"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-108,
  ]
}
resource "azurerm_api_management_product_group" "res-117" {
  api_management_name = "mbc-apim"
  group_name          = "developers"
  product_id          = "wineyard"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-108,
  ]
}
resource "azurerm_api_management_product_group" "res-118" {
  api_management_name = "mbc-apim"
  group_name          = "guests"
  product_id          = "wineyard"
  resource_group_name = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_api_management_product.res-108,
  ]
}
resource "azurerm_api_management_subscription" "res-119" {
  allow_tracing       = false
  api_id              = ""
  api_management_name = "mbc-apim"
  display_name        = ""
  primary_key         = "" # Masked sensitive attribute
  product_id          = "/subscriptions/c8422a40-6f30-4238-aaf9-f46c0ee23a22/resourceGroups/mvpconf-demo/providers/Microsoft.ApiManagement/service/mbc-apim/products/starter"
  resource_group_name = azurerm_resource_group.res-0.name
  secondary_key       = "" # Masked sensitive attribute
  state               = "active"
  subscription_id     = "6a9f6e37bb5eb4006b070001"
  user_id             = azurerm_api_management_user.res-160.id
  depends_on = [
    # One of azurerm_api_management_product.res-78,azurerm_api_management_product_policy.res-87 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_api_management_subscription" "res-120" {
  allow_tracing       = false
  api_id              = ""
  api_management_name = "mbc-apim"
  display_name        = ""
  primary_key         = "" # Masked sensitive attribute
  product_id          = azurerm_api_management_product.res-88.id
  resource_group_name = azurerm_resource_group.res-0.name
  secondary_key       = "" # Masked sensitive attribute
  state               = "active"
  subscription_id     = "6a9f6e37bb5eb4006b070002"
  user_id             = azurerm_api_management_user.res-160.id
}
resource "azurerm_api_management_subscription" "res-121" {
  allow_tracing       = false
  api_id              = ""
  api_management_name = "mbc-apim"
  display_name        = ""
  primary_key         = "" # Masked sensitive attribute
  product_id          = azurerm_api_management_product.res-97.id
  resource_group_name = azurerm_resource_group.res-0.name
  secondary_key       = "" # Masked sensitive attribute
  state               = "active"
  subscription_id     = "6aa1f7e646346115a4a85647"
  user_id             = azurerm_api_management_user.res-160.id
}
resource "azurerm_api_management_subscription" "res-122" {
  allow_tracing       = false
  api_id              = ""
  api_management_name = "mbc-apim"
  display_name        = ""
  primary_key         = "" # Masked sensitive attribute
  product_id          = azurerm_api_management_product.res-108.id
  resource_group_name = azurerm_resource_group.res-0.name
  secondary_key       = "" # Masked sensitive attribute
  state               = "active"
  subscription_id     = "6aa1f81a46346115a4a8564f"
  user_id             = azurerm_api_management_user.res-160.id
}
resource "azurerm_api_management_tag" "res-124" {
  api_management_id = "/subscriptions/c8422a40-6f30-4238-aaf9-f46c0ee23a22/resourceGroups/mvpconf-demo/providers/Microsoft.ApiManagement/service/mbc-apim"
  display_name      = "Catalog"
  name              = "Catalog"
  depends_on = [
    azurerm_api_management.res-1,
    # One of azurerm_api_management.res-1,azurerm_api_management_policy.res-73 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_api_management_tag" "res-127" {
  api_management_id = "/subscriptions/c8422a40-6f30-4238-aaf9-f46c0ee23a22/resourceGroups/mvpconf-demo/providers/Microsoft.ApiManagement/service/mbc-apim"
  display_name      = "Grapes"
  name              = "Grapes"
  depends_on = [
    azurerm_api_management.res-1,
    # One of azurerm_api_management.res-1,azurerm_api_management_policy.res-73 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_api_management_tag" "res-129" {
  api_management_id = "/subscriptions/c8422a40-6f30-4238-aaf9-f46c0ee23a22/resourceGroups/mvpconf-demo/providers/Microsoft.ApiManagement/service/mbc-apim"
  display_name      = "Inventory"
  name              = "Inventory"
  depends_on = [
    azurerm_api_management.res-1,
    # One of azurerm_api_management.res-1,azurerm_api_management_policy.res-73 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_api_management_tag" "res-131" {
  api_management_id = "/subscriptions/c8422a40-6f30-4238-aaf9-f46c0ee23a22/resourceGroups/mvpconf-demo/providers/Microsoft.ApiManagement/service/mbc-apim"
  display_name      = "Vineyards"
  name              = "Vineyards"
  depends_on = [
    azurerm_api_management.res-1,
    # One of azurerm_api_management.res-1,azurerm_api_management_policy.res-73 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_api_management_tag" "res-136" {
  api_management_id = "/subscriptions/c8422a40-6f30-4238-aaf9-f46c0ee23a22/resourceGroups/mvpconf-demo/providers/Microsoft.ApiManagement/service/mbc-apim"
  display_name      = "Wineries"
  name              = "Wineries"
  depends_on = [
    azurerm_api_management.res-1,
    # One of azurerm_api_management.res-1,azurerm_api_management_policy.res-73 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_api_management_tag" "res-141" {
  api_management_id = "/subscriptions/c8422a40-6f30-4238-aaf9-f46c0ee23a22/resourceGroups/mvpconf-demo/providers/Microsoft.ApiManagement/service/mbc-apim"
  display_name      = "Wines"
  name              = "Wines"
  depends_on = [
    azurerm_api_management.res-1,
    # One of azurerm_api_management.res-1,azurerm_api_management_policy.res-73 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_api_management_email_template" "res-146" {
  api_management_name = "mbc-apim"
  body                = "<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Dear $DevFirstName $DevLastName,</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n          On behalf of $OrganizationName and our customers we thank you for giving us a try. Your $OrganizationName API account is now closed.\r\n        </p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Thank you,</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Your $OrganizationName Team</p>\r\n    <a href=\"$DevPortalUrl\">$DevPortalUrl</a>\r\n    <p />\r\n  </body>\r\n</html>"
  resource_group_name = azurerm_resource_group.res-0.name
  subject             = "Thank you for using the $OrganizationName API!"
  template_name       = "AccountClosedDeveloper"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_email_template" "res-147" {
  api_management_name = "mbc-apim"
  body                = "<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Dear $DevFirstName $DevLastName,</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n          We are happy to let you know that your request to publish the $AppName application in the application gallery has been approved. Your application has been published and can be viewed <a href=\"http://$DevPortalUrl/Applications/Details/$AppId\">here</a>.\r\n        </p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Best,</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">The $OrganizationName API Team</p>\r\n  </body>\r\n</html>"
  resource_group_name = azurerm_resource_group.res-0.name
  subject             = "Your application $AppName is published in the application gallery"
  template_name       = "ApplicationApprovedNotificationMessage"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_email_template" "res-148" {
  api_management_name = "mbc-apim"
  body                = "<!DOCTYPE html >\r\n<html>\r\n  <head>\r\n    <meta charset=\"UTF-8\" />\r\n    <title>Letter</title>\r\n  </head>\r\n  <body>\r\n    <table width=\"100%\">\r\n      <tr>\r\n        <td>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">Dear $DevFirstName $DevLastName,</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\"></p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">Thank you for joining the $OrganizationName API program! We host a growing number of cool APIs and strive to provide an awesome experience for API developers.</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">First order of business is to activate your account and get you going. To that end, please click on the following link:</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n            <a id=\"confirmUrl\" href=\"$ConfirmUrl\" style=\"text-decoration:none\">\r\n              <strong>$ConfirmUrl</strong>\r\n            </a>\r\n          </p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">If clicking the link does not work, please copy-and-paste or re-type it into your browser's address bar and hit \"Enter\".</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">Thank you,</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">$OrganizationName API Team</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n            <a href=\"$DevPortalUrl\">$DevPortalUrl</a>\r\n          </p>\r\n        </td>\r\n      </tr>\r\n    </table>\r\n  </body>\r\n</html>"
  resource_group_name = azurerm_resource_group.res-0.name
  subject             = "Please confirm your new $OrganizationName API account"
  template_name       = "ConfirmSignUpIdentityDefault"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_email_template" "res-149" {
  api_management_name = "mbc-apim"
  body                = "<!DOCTYPE html >\r\n<html>\r\n  <head>\r\n    <meta charset=\"UTF-8\" />\r\n    <title>Letter</title>\r\n  </head>\r\n  <body>\r\n    <table width=\"100%\">\r\n      <tr>\r\n        <td>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">Dear $DevFirstName $DevLastName,</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\"></p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">You are receiving this email because you made a change to the email address on your $OrganizationName API account.</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">Please click on the following link to confirm the change:</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n            <a id=\"confirmUrl\" href=\"$ConfirmUrl\" style=\"text-decoration:none\">\r\n              <strong>$ConfirmUrl</strong>\r\n            </a>\r\n          </p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">If clicking the link does not work, please copy-and-paste or re-type it into your browser's address bar and hit \"Enter\".</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">Thank you,</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">$OrganizationName API Team</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n            <a href=\"$DevPortalUrl\">$DevPortalUrl</a>\r\n          </p>\r\n        </td>\r\n      </tr>\r\n    </table>\r\n  </body>\r\n</html>"
  resource_group_name = azurerm_resource_group.res-0.name
  subject             = "Please confirm the new email associated with your $OrganizationName API account"
  template_name       = "EmailChangeIdentityDefault"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_email_template" "res-150" {
  api_management_name = "mbc-apim"
  body                = "<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Dear $DevFirstName $DevLastName,</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n          Your account has been created. Please follow the link below to visit the $OrganizationName developer portal and claim it:\r\n        </p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n      <a href=\"$ConfirmUrl\">$ConfirmUrl</a>\r\n    </p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Best,</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">The $OrganizationName API Team</p>\r\n  </body>\r\n</html>"
  resource_group_name = azurerm_resource_group.res-0.name
  subject             = "You are invited to join the $OrganizationName developer network"
  template_name       = "InviteUserNotificationMessage"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_email_template" "res-151" {
  api_management_name = "mbc-apim"
  body                = "<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Dear $DevFirstName $DevLastName,</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">This is a brief note to let you know that $CommenterFirstName $CommenterLastName made the following comment on the issue $IssueName you created:</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">$CommentText</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n          To view the issue on the developer portal click <a href=\"http://$DevPortalUrl/issues/$IssueId\">here</a>.\r\n        </p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Best,</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">The $OrganizationName API Team</p>\r\n  </body>\r\n</html>"
  resource_group_name = azurerm_resource_group.res-0.name
  subject             = "$IssueName issue has a new comment"
  template_name       = "NewCommentNotificationMessage"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_email_template" "res-152" {
  api_management_name = "mbc-apim"
  body                = "<!DOCTYPE html >\r\n<html>\r\n  <head>\r\n    <meta charset=\"UTF-8\" />\r\n    <title>Letter</title>\r\n  </head>\r\n  <body>\r\n    <h1 style=\"color:#000505;font-size:18pt;font-family:'Segoe UI'\">\r\n          Welcome to <span style=\"color:#003363\">$OrganizationName API!</span></h1>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Dear $DevFirstName $DevLastName,</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Your $OrganizationName API program registration is completed and we are thrilled to have you as a customer. Here are a few important bits of information for your reference:</p>\r\n    <table width=\"100%\" style=\"margin:20px 0\">\r\n      <tr>\r\n            #if ($IdentityProvider == \"Basic\")\r\n            <td width=\"50%\" style=\"height:40px;vertical-align:top;font-family:'Segoe UI';font-size:12pt\">\r\n              Please use the following <strong>username</strong> when signing into any of the $${OrganizationName}-hosted developer portals:\r\n            </td><td style=\"vertical-align:top;font-family:'Segoe UI';font-size:12pt\"><strong>$DevUsername</strong></td>\r\n            #else\r\n            <td width=\"50%\" style=\"height:40px;vertical-align:top;font-family:'Segoe UI';font-size:12pt\">\r\n              Please use the following <strong>$IdentityProvider account</strong> when signing into any of the $${OrganizationName}-hosted developer portals:\r\n            </td><td style=\"vertical-align:top;font-family:'Segoe UI';font-size:12pt\"><strong>$DevUsername</strong></td>            \r\n            #end\r\n          </tr>\r\n      <tr>\r\n        <td style=\"height:40px;vertical-align:top;font-family:'Segoe UI';font-size:12pt\">\r\n              We will direct all communications to the following <strong>email address</strong>:\r\n            </td>\r\n        <td style=\"vertical-align:top;font-family:'Segoe UI';font-size:12pt\">\r\n          <a href=\"mailto:$DevEmail\" style=\"text-decoration:none\">\r\n            <strong>$DevEmail</strong>\r\n          </a>\r\n        </td>\r\n      </tr>\r\n    </table>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Best of luck in your API pursuits!</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">$OrganizationName API Team</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n      <a href=\"http://$DevPortalUrl\">$DevPortalUrl</a>\r\n    </p>\r\n  </body>\r\n</html>"
  resource_group_name = azurerm_resource_group.res-0.name
  subject             = "Welcome to the $OrganizationName API!"
  template_name       = "NewDeveloperNotificationMessage"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_email_template" "res-153" {
  api_management_name = "mbc-apim"
  body                = "<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Dear $DevFirstName $DevLastName,</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Thank you for contacting us. Our API team will review your issue and get back to you soon.</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n          Click this <a href=\"http://$DevPortalUrl/issues/$IssueId\">link</a> to view or edit your request.\r\n        </p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Best,</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">The $OrganizationName API Team</p>\r\n  </body>\r\n</html>"
  resource_group_name = azurerm_resource_group.res-0.name
  subject             = "Your request $IssueName was received"
  template_name       = "NewIssueNotificationMessage"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_email_template" "res-154" {
  api_management_name = "mbc-apim"
  body                = "<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <table width=\"100%\">\r\n      <tr>\r\n        <td>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">Dear $DevFirstName $DevLastName,</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\"></p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">The password of your $OrganizationName API account has been reset, per your request.</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n                Your new password is: <strong>$DevPassword</strong></p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">Please make sure to change it next time you sign in.</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">Thank you,</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">$OrganizationName API Team</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n            <a href=\"$DevPortalUrl\">$DevPortalUrl</a>\r\n          </p>\r\n        </td>\r\n      </tr>\r\n    </table>\r\n  </body>\r\n</html>"
  resource_group_name = azurerm_resource_group.res-0.name
  subject             = "Your password was reset"
  template_name       = "PasswordResetByAdminNotificationMessage"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_email_template" "res-155" {
  api_management_name = "mbc-apim"
  body                = "<!DOCTYPE html >\r\n<html>\r\n  <head>\r\n    <meta charset=\"UTF-8\" />\r\n    <title>Letter</title>\r\n  </head>\r\n  <body>\r\n    <table width=\"100%\">\r\n      <tr>\r\n        <td>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">Dear $DevFirstName $DevLastName,</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\"></p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">You are receiving this email because you requested to change the password on your $OrganizationName API account.</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">Please click on the link below and follow instructions to create your new password:</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n            <a id=\"resetUrl\" href=\"$ConfirmUrl\" style=\"text-decoration:none\">\r\n              <strong>$ConfirmUrl</strong>\r\n            </a>\r\n          </p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">If clicking the link does not work, please copy-and-paste or re-type it into your browser's address bar and hit \"Enter\".</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">Thank you,</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">$OrganizationName API Team</p>\r\n          <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n            <a href=\"$DevPortalUrl\">$DevPortalUrl</a>\r\n          </p>\r\n        </td>\r\n      </tr>\r\n    </table>\r\n  </body>\r\n</html>"
  resource_group_name = azurerm_resource_group.res-0.name
  subject             = "Your password change request"
  template_name       = "PasswordResetIdentityDefault"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_email_template" "res-156" {
  api_management_name = "mbc-apim"
  body                = "<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Greetings $DevFirstName $DevLastName!</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n          Thank you for subscribing to the <a href=\"http://$DevPortalUrl/product#product=$ProdId\"><strong>$ProdName</strong></a> and welcome to the $OrganizationName developer community. We are delighted to have you as part of the team and are looking forward to the amazing applications you will build using our API!\r\n        </p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Below are a few subscription details for your reference:</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n      <ul>\r\n            #if ($SubStartDate != \"\")\r\n            <li style=\"font-size:12pt;font-family:'Segoe UI'\">Start date: $SubStartDate</li>\r\n            #end\r\n            \r\n            #if ($SubTerm != \"\")\r\n            <li style=\"font-size:12pt;font-family:'Segoe UI'\">Subscription term: $SubTerm</li>\r\n            #end\r\n          </ul>\r\n    </p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n            Visit the developer <a href=\"http://$DevPortalUrl/profile\">profile area</a> to manage your subscription and subscription keys\r\n        </p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">A couple of pointers to help get you started:</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n      <strong>\r\n        <a href=\"http://$DevPortalUrl/product#product=$ProdId\">Learn about the API</a>\r\n      </strong>\r\n    </p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">The API documentation provides all information necessary to make a request and to process a response. Code samples are provided per API operation in a variety of languages. Moreover, an interactive console allows making API calls directly from the developer portal without writing any code.</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Happy hacking,</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">The $OrganizationName API Team</p>\r\n    <a style=\"font-size:12pt;font-family:'Segoe UI'\" href=\"http://$DevPortalUrl\">$DevPortalUrl</a>\r\n  </body>\r\n</html>"
  resource_group_name = azurerm_resource_group.res-0.name
  subject             = "Your subscription to the $ProdName"
  template_name       = "PurchaseDeveloperNotificationMessage"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_email_template" "res-157" {
  api_management_name = "mbc-apim"
  body                = "<!DOCTYPE html >\r\n<html>\r\n  <head>\r\n    <style>\r\n          body {font-size:12pt; font-family:\"Segoe UI\",\"Segoe WP\",\"Tahoma\",\"Arial\",\"sans-serif\";}\r\n          .alert { color: red; }\r\n          .child1 { padding-left: 20px; }\r\n          .child2 { padding-left: 40px; }\r\n          .number { text-align: right; }\r\n          .text { text-align: left; }\r\n          th, td { padding: 4px 10px; min-width: 100px; }\r\n          th { background-color: #DDDDDD;}\r\n        </style>\r\n  </head>\r\n  <body>\r\n    <p>Greetings $DevFirstName $DevLastName!</p>\r\n    <p>\r\n          You are approaching the quota limit on you subscription to the <strong>$ProdName</strong> product (primary key $SubPrimaryKey).\r\n          #if ($QuotaResetDate != \"\")\r\n          This quota will be renewed on $QuotaResetDate.\r\n          #else\r\n          This quota will not be renewed.\r\n          #end\r\n        </p>\r\n    <p>Below are details on quota usage for the subscription:</p>\r\n    <p>\r\n      <table>\r\n        <thead>\r\n          <th class=\"text\">Quota Scope</th>\r\n          <th class=\"number\">Calls</th>\r\n          <th class=\"number\">Call Quota</th>\r\n          <th class=\"number\">Bandwidth</th>\r\n          <th class=\"number\">Bandwidth Quota</th>\r\n        </thead>\r\n        <tbody>\r\n          <tr>\r\n            <td class=\"text\">Subscription</td>\r\n            <td class=\"number\">\r\n                  #if ($CallsAlert == true)\r\n                  <span class=\"alert\">$Calls</span>\r\n                  #else\r\n                  $Calls\r\n                  #end\r\n                </td>\r\n            <td class=\"number\">$CallQuota</td>\r\n            <td class=\"number\">\r\n                  #if ($BandwidthAlert == true)\r\n                  <span class=\"alert\">$Bandwidth</span>\r\n                  #else\r\n                  $Bandwidth\r\n                  #end\r\n                </td>\r\n            <td class=\"number\">$BandwidthQuota</td>\r\n          </tr>\r\n              #foreach ($api in $Apis)\r\n              <tr><td class=\"child1 text\">API: $api.Name</td><td class=\"number\">\r\n                  #if ($api.CallsAlert == true)\r\n                  <span class=\"alert\">$api.Calls</span>\r\n                  #else\r\n                  $api.Calls\r\n                  #end\r\n                </td><td class=\"number\">$api.CallQuota</td><td class=\"number\">\r\n                  #if ($api.BandwidthAlert == true)\r\n                  <span class=\"alert\">$api.Bandwidth</span>\r\n                  #else\r\n                  $api.Bandwidth\r\n                  #end\r\n                </td><td class=\"number\">$api.BandwidthQuota</td></tr>\r\n              #foreach ($operation in $api.Operations)\r\n              <tr><td class=\"child2 text\">Operation: $operation.Name</td><td class=\"number\">\r\n                  #if ($operation.CallsAlert == true)\r\n                  <span class=\"alert\">$operation.Calls</span>\r\n                  #else\r\n                  $operation.Calls\r\n                  #end\r\n                </td><td class=\"number\">$operation.CallQuota</td><td class=\"number\">\r\n                  #if ($operation.BandwidthAlert == true)\r\n                  <span class=\"alert\">$operation.Bandwidth</span>\r\n                  #else\r\n                  $operation.Bandwidth\r\n                  #end\r\n                </td><td class=\"number\">$operation.BandwidthQuota</td></tr>\r\n              #end\r\n              #end\r\n            </tbody>\r\n      </table>\r\n    </p>\r\n    <p>Thank you,</p>\r\n    <p>$OrganizationName API Team</p>\r\n    <a href=\"$DevPortalUrl\">$DevPortalUrl</a>\r\n    <p />\r\n  </body>\r\n</html>"
  resource_group_name = azurerm_resource_group.res-0.name
  subject             = "You are approaching an API quota limit"
  template_name       = "QuotaLimitApproachingDeveloperNotificationMessage"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_email_template" "res-158" {
  api_management_name = "mbc-apim"
  body                = "<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Dear $DevFirstName $DevLastName,</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n          We would like to inform you that we reviewed your subscription request for the <strong>$ProdName</strong>.\r\n        </p>\r\n        #if ($SubDeclineReason == \"\")\r\n        <p style=\"font-size:12pt;font-family:'Segoe UI'\">Regretfully, we were unable to approve it, as subscriptions are temporarily suspended at this time.</p>\r\n        #else\r\n        <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n          Regretfully, we were unable to approve it at this time for the following reason:\r\n          <div style=\"margin-left: 1.5em;\"> $SubDeclineReason </div></p>\r\n        #end\r\n        <p style=\"font-size:12pt;font-family:'Segoe UI'\"> We truly appreciate your interest. </p><p style=\"font-size:12pt;font-family:'Segoe UI'\">All the best,</p><p style=\"font-size:12pt;font-family:'Segoe UI'\">The $OrganizationName API Team</p><a style=\"font-size:12pt;font-family:'Segoe UI'\" href=\"http://$DevPortalUrl\">$DevPortalUrl</a></body>\r\n</html>"
  resource_group_name = azurerm_resource_group.res-0.name
  subject             = "Your subscription request for the $ProdName"
  template_name       = "RejectDeveloperNotificationMessage"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_email_template" "res-159" {
  api_management_name = "mbc-apim"
  body                = "<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Dear $DevFirstName $DevLastName,</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n          Thank you for your interest in our <strong>$ProdName</strong> API product!\r\n        </p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">\r\n          We were delighted to receive your subscription request. We will promptly review it and get back to you at <strong>$DevEmail</strong>.\r\n        </p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">Thank you,</p>\r\n    <p style=\"font-size:12pt;font-family:'Segoe UI'\">The $OrganizationName API Team</p>\r\n    <a style=\"font-size:12pt;font-family:'Segoe UI'\" href=\"http://$DevPortalUrl\">$DevPortalUrl</a>\r\n  </body>\r\n</html>"
  resource_group_name = azurerm_resource_group.res-0.name
  subject             = "Your subscription request for the $ProdName"
  template_name       = "RequestDeveloperNotificationMessage"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_api_management_user" "res-160" {
  api_management_name = "mbc-apim"
  email               = "murilo@homework.com"
  first_name          = "Administrator"
  last_name           = ""
  note                = ""
  password            = "" # Masked sensitive attribute
  resource_group_name = azurerm_resource_group.res-0.name
  state               = "active"
  user_id             = "1"
  depends_on = [
    azurerm_api_management.res-1,
  ]
}
resource "azurerm_container_app" "res-161" {
  container_app_environment_id = azurerm_container_app_environment.res-163.id
  max_inactive_revisions       = 100
  name                         = "mbc-mcp-demo"
  resource_group_name          = azurerm_resource_group.res-0.name
  revision_mode                = "Single"
  tags                         = {}
  workload_profile_name        = "Consumption"
  ingress {
    allow_insecure_connections = true
    client_certificate_mode    = ""
    exposed_port               = 0
    external_enabled           = true
    target_port                = 5000
    transport                  = "auto"
    traffic_weight {
      label           = ""
      latest_revision = true
      percentage      = 100
      revision_suffix = ""
    }
  }
  registry {
    identity             = "system-environment"
    password_secret_name = ""
    server               = "mbcmvpconf.azurecr.io"
    username             = ""
  }
  template {
    cooldown_period_in_seconds       = 300
    max_replicas                     = 10
    min_replicas                     = 0
    polling_interval_in_seconds      = 30
    revision_suffix                  = ""
    termination_grace_period_seconds = 0
    container {
      args    = []
      command = []
      cpu     = 0.5
      image   = "mbcmvpconf.azurecr.io/mcp-demo:latest"
      memory  = "1Gi"
      name    = "mbc-mcp-demo"
    }
  }
}
resource "azurerm_container_app" "res-162" {
  container_app_environment_id = azurerm_container_app_environment.res-163.id
  max_inactive_revisions       = 100
  name                         = "mbc-rest-demo"
  resource_group_name          = azurerm_resource_group.res-0.name
  revision_mode                = "Single"
  tags                         = {}
  workload_profile_name        = "Consumption"
  ingress {
    allow_insecure_connections = true
    client_certificate_mode    = ""
    exposed_port               = 0
    external_enabled           = true
    target_port                = 5000
    transport                  = "auto"
    traffic_weight {
      label           = ""
      latest_revision = true
      percentage      = 100
      revision_suffix = ""
    }
  }
  registry {
    identity             = "system-environment"
    password_secret_name = ""
    server               = "mbcmvpconf.azurecr.io"
    username             = ""
  }
  template {
    cooldown_period_in_seconds       = 300
    max_replicas                     = 10
    min_replicas                     = 0
    polling_interval_in_seconds      = 30
    revision_suffix                  = ""
    termination_grace_period_seconds = 0
    container {
      args    = []
      command = []
      cpu     = 0.5
      image   = "mbcmvpconf.azurecr.io/rest-demo:latest"
      memory  = "1Gi"
      name    = "mbc-rest-demo"
    }
  }
}
resource "azurerm_container_app_environment" "res-163" {
  dapr_application_insights_connection_string = "" # Masked sensitive attribute
  infrastructure_resource_group_name          = ""
  infrastructure_subnet_id                    = ""
  internal_load_balancer_enabled              = false
  location                                    = "brazilsouth"
  log_analytics_workspace_id                  = azurerm_log_analytics_workspace.res-170.id
  logs_destination                            = "log-analytics"
  mutual_tls_enabled                          = false
  name                                        = "mbcme"
  public_network_access                       = "Enabled"
  resource_group_name                         = azurerm_resource_group.res-0.name
  tags                                        = {}
  zone_redundancy_enabled                     = false
  identity {
    identity_ids = []
    type         = "SystemAssigned"
  }
  workload_profile {
    maximum_count         = 0
    minimum_count         = 0
    name                  = "Consumption"
    workload_profile_type = "Consumption"
  }
}
resource "azurerm_container_registry" "res-164" {
  admin_enabled                 = true
  anonymous_pull_enabled        = false
  data_endpoint_enabled         = false
  encryption                    = []
  export_policy_enabled         = true
  location                      = "brazilsouth"
  name                          = "mbcmvpconf"
  network_rule_bypass_option    = "AzureServices"
  network_rule_set              = []
  public_network_access_enabled = true
  quarantine_policy_enabled     = false
  resource_group_name           = azurerm_resource_group.res-0.name
  retention_policy_in_days      = 0
  sku                           = "Basic"
  tags                          = {}
  trust_policy_enabled          = false
  zone_redundancy_enabled       = false
}
resource "azurerm_container_registry_scope_map" "res-165" {
  actions                 = ["repositories/*/metadata/read", "repositories/*/metadata/write", "repositories/*/content/read", "repositories/*/content/write", "repositories/*/content/delete"]
  container_registry_name = "mbcmvpconf"
  description             = "Can perform all read, write and delete operations on the registry"
  name                    = "_repositories_admin"
  resource_group_name     = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_container_registry.res-164,
  ]
}
resource "azurerm_container_registry_scope_map" "res-166" {
  actions                 = ["repositories/*/content/read"]
  container_registry_name = "mbcmvpconf"
  description             = "Can pull any repository of the registry"
  name                    = "_repositories_pull"
  resource_group_name     = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_container_registry.res-164,
  ]
}
resource "azurerm_container_registry_scope_map" "res-167" {
  actions                 = ["repositories/*/content/read", "repositories/*/metadata/read"]
  container_registry_name = "mbcmvpconf"
  description             = "Can perform all read operations on the registry"
  name                    = "_repositories_pull_metadata_read"
  resource_group_name     = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_container_registry.res-164,
  ]
}
resource "azurerm_container_registry_scope_map" "res-168" {
  actions                 = ["repositories/*/content/read", "repositories/*/content/write"]
  container_registry_name = "mbcmvpconf"
  description             = "Can push to any repository of the registry"
  name                    = "_repositories_push"
  resource_group_name     = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_container_registry.res-164,
  ]
}
resource "azurerm_container_registry_scope_map" "res-169" {
  actions                 = ["repositories/*/metadata/read", "repositories/*/metadata/write", "repositories/*/content/read", "repositories/*/content/write"]
  container_registry_name = "mbcmvpconf"
  description             = "Can perform all read and write operations on the registry"
  name                    = "_repositories_push_metadata_write"
  resource_group_name     = azurerm_resource_group.res-0.name
  depends_on = [
    azurerm_container_registry.res-164,
  ]
}
resource "azurerm_log_analytics_workspace" "res-170" {
  allow_resource_only_permissions         = true
  cmk_for_query_forced                    = false
  daily_quota_gb                          = -1
  data_collection_rule_id                 = ""
  immediate_data_purge_on_30_days_enabled = false
  internet_ingestion_enabled              = true
  internet_query_enabled                  = true
  location                                = "brazilsouth"
  name                                    = "workspacemvpconfdemo82e9"
  resource_group_name                     = azurerm_resource_group.res-0.name
  retention_in_days                       = 30
  sku                                     = "PerGB2018"
  tags                                    = {}
}
resource "azurerm_log_analytics_saved_search" "res-171" {
  category                   = "General Exploration"
  display_name               = "All Computers with their most recent data"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_General|AlphabeticallySortedComputers"
  query                      = "search not(ObjectName == \"Advisor Metrics\" or ObjectName == \"ManagedSpace\") | summarize AggregatedValue = max(TimeGenerated) by Computer | limit 500000 | sort by Computer asc\r\n// Oql: NOT(ObjectName=\"Advisor Metrics\" OR ObjectName=ManagedSpace) | measure max(TimeGenerated) by Computer | top 500000 | Sort Computer // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-172" {
  category                   = "General Exploration"
  display_name               = "Stale Computers (data older than 24 hours)"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_General|StaleComputers"
  query                      = "search not(ObjectName == \"Advisor Metrics\" or ObjectName == \"ManagedSpace\") | summarize lastdata = max(TimeGenerated) by Computer | limit 500000 | where lastdata < ago(24h)\r\n// Oql: NOT(ObjectName=\"Advisor Metrics\" OR ObjectName=ManagedSpace) | measure max(TimeGenerated) as lastdata by Computer | top 500000 | where lastdata < NOW-24HOURS // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-173" {
  category                   = "General Exploration"
  display_name               = "Which Management Group is generating the most data points?"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_General|dataPointsPerManagementGroup"
  query                      = "search * | summarize AggregatedValue = count() by ManagementGroupName\r\n// Oql: * | Measure count() by ManagementGroupName // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-174" {
  category                   = "General Exploration"
  display_name               = "Distribution of data Types"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_General|dataTypeDistribution"
  query                      = "search * | extend Type = $table | summarize AggregatedValue = count() by Type\r\n// Oql: * | Measure count() by Type // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-175" {
  category                   = "Log Management"
  display_name               = "All Events"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|AllEvents"
  query                      = "Event | sort by TimeGenerated desc\r\n// Oql: Type=Event // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-176" {
  category                   = "Log Management"
  display_name               = "All Syslogs"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|AllSyslog"
  query                      = "Syslog | sort by TimeGenerated desc\r\n// Oql: Type=Syslog // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-177" {
  category                   = "Log Management"
  display_name               = "All Syslog Records grouped by Facility"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|AllSyslogByFacility"
  query                      = "Syslog | summarize AggregatedValue = count() by Facility\r\n// Oql: Type=Syslog | Measure count() by Facility // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-178" {
  category                   = "Log Management"
  display_name               = "All Syslog Records grouped by ProcessName"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|AllSyslogByProcessName"
  query                      = "Syslog | summarize AggregatedValue = count() by ProcessName\r\n// Oql: Type=Syslog | Measure count() by ProcessName // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-179" {
  category                   = "Log Management"
  display_name               = "All Syslog Records with Errors"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|AllSyslogsWithErrors"
  query                      = "Syslog | where SeverityLevel == \"error\" | sort by TimeGenerated desc\r\n// Oql: Type=Syslog SeverityLevel=error // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-180" {
  category                   = "Log Management"
  display_name               = "Average HTTP Request time by Client IP Address"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|AverageHTTPRequestTimeByClientIPAddress"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = avg(TimeTaken) by cIP\r\n// Oql: Type=W3CIISLog | Measure Avg(TimeTaken) by cIP // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-181" {
  category                   = "Log Management"
  display_name               = "Average HTTP Request time by HTTP Method"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|AverageHTTPRequestTimeHTTPMethod"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = avg(TimeTaken) by csMethod\r\n// Oql: Type=W3CIISLog | Measure Avg(TimeTaken) by csMethod // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-182" {
  category                   = "Log Management"
  display_name               = "Count of IIS Log Entries by Client IP Address"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|CountIISLogEntriesClientIPAddress"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by cIP\r\n// Oql: Type=W3CIISLog | Measure count() by cIP // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-183" {
  category                   = "Log Management"
  display_name               = "Count of IIS Log Entries by HTTP Request Method"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|CountIISLogEntriesHTTPRequestMethod"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csMethod\r\n// Oql: Type=W3CIISLog | Measure count() by csMethod // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-184" {
  category                   = "Log Management"
  display_name               = "Count of IIS Log Entries by HTTP User Agent"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|CountIISLogEntriesHTTPUserAgent"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csUserAgent\r\n// Oql: Type=W3CIISLog | Measure count() by csUserAgent // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-185" {
  category                   = "Log Management"
  display_name               = "Count of IIS Log Entries by Host requested by client"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|CountOfIISLogEntriesByHostRequestedByClient"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csHost\r\n// Oql: Type=W3CIISLog | Measure count() by csHost // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-186" {
  category                   = "Log Management"
  display_name               = "Count of IIS Log Entries by URL for the host \"www.contoso.com\" (replace with your own)"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|CountOfIISLogEntriesByURLForHost"
  query                      = "search csHost == \"www.contoso.com\" | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csUriStem\r\n// Oql: Type=W3CIISLog csHost=\"www.contoso.com\" | Measure count() by csUriStem // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-187" {
  category                   = "Log Management"
  display_name               = "Count of IIS Log Entries by URL requested by client (without query strings)"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|CountOfIISLogEntriesByURLRequestedByClient"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csUriStem\r\n// Oql: Type=W3CIISLog | Measure count() by csUriStem // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-188" {
  category                   = "Log Management"
  display_name               = "Count of Events with level \"Warning\" grouped by Event ID"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|CountOfWarningEvents"
  query                      = "Event | where EventLevelName == \"warning\" | summarize AggregatedValue = count() by EventID\r\n// Oql: Type=Event EventLevelName=warning | Measure count() by EventID // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-189" {
  category                   = "Log Management"
  display_name               = "Shows breakdown of response codes"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|DisplayBreakdownRespondCodes"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by scStatus\r\n// Oql: Type=W3CIISLog | Measure count() by scStatus // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-190" {
  category                   = "Log Management"
  display_name               = "Count of Events grouped by Event Log"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|EventsByEventLog"
  query                      = "Event | summarize AggregatedValue = count() by EventLog\r\n// Oql: Type=Event | Measure count() by EventLog // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-191" {
  category                   = "Log Management"
  display_name               = "Count of Events grouped by Event Source"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|EventsByEventSource"
  query                      = "Event | summarize AggregatedValue = count() by Source\r\n// Oql: Type=Event | Measure count() by Source // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-192" {
  category                   = "Log Management"
  display_name               = "Count of Events grouped by Event ID"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|EventsByEventsID"
  query                      = "Event | summarize AggregatedValue = count() by EventID\r\n// Oql: Type=Event | Measure count() by EventID // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-193" {
  category                   = "Log Management"
  display_name               = "Events in the Operations Manager Event Log whose Event ID is in the range between 2000 and 3000"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|EventsInOMBetween2000to3000"
  query                      = "Event | where EventLog == \"Operations Manager\" and EventID >= 2000 and EventID <= 3000 | sort by TimeGenerated desc\r\n// Oql: Type=Event EventLog=\"Operations Manager\" EventID:[2000..3000] // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-194" {
  category                   = "Log Management"
  display_name               = "Count of Events containing the word \"started\" grouped by EventID"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|EventsWithStartedinEventID"
  query                      = "search in (Event) \"started\" | summarize AggregatedValue = count() by EventID\r\n// Oql: Type=Event \"started\" | Measure count() by EventID // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-195" {
  category                   = "Log Management"
  display_name               = "Find the maximum time taken for each page"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|FindMaximumTimeTakenForEachPage"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = max(TimeTaken) by csUriStem\r\n// Oql: Type=W3CIISLog | Measure Max(TimeTaken) by csUriStem // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-196" {
  category                   = "Log Management"
  display_name               = "IIS Log Entries for a specific client IP Address (replace with your own)"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|IISLogEntriesForClientIP"
  query                      = "search cIP == \"192.168.0.1\" | extend Type = $table | where Type == W3CIISLog | sort by TimeGenerated desc | project csUriStem, scBytes, csBytes, TimeTaken, scStatus\r\n// Oql: Type=W3CIISLog cIP=\"192.168.0.1\" | Select csUriStem,scBytes,csBytes,TimeTaken,scStatus // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-197" {
  category                   = "Log Management"
  display_name               = "All IIS Log Entries"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|ListAllIISLogEntries"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | sort by TimeGenerated desc\r\n// Oql: Type=W3CIISLog // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-198" {
  category                   = "Log Management"
  display_name               = "How many connections to Operations Manager's SDK service by day"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|NoOfConnectionsToOMSDKService"
  query                      = "Event | where EventID == 26328 and EventLog == \"Operations Manager\" | summarize AggregatedValue = count() by bin(TimeGenerated, 1d) | sort by TimeGenerated desc\r\n// Oql: Type=Event EventID=26328 EventLog=\"Operations Manager\" | Measure count() interval 1DAY // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-199" {
  category                   = "Log Management"
  display_name               = "When did my servers initiate restart?"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|ServerRestartTime"
  query                      = "search in (Event) \"shutdown\" and EventLog == \"System\" and Source == \"User32\" and EventID == 1074 | sort by TimeGenerated desc | project TimeGenerated, Computer\r\n// Oql: shutdown Type=Event EventLog=System Source=User32 EventID=1074 | Select TimeGenerated,Computer // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-200" {
  category                   = "Log Management"
  display_name               = "Shows which pages people are getting a 404 for"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|Show404PagesList"
  query                      = "search scStatus == 404 | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by csUriStem\r\n// Oql: Type=W3CIISLog scStatus=404 | Measure count() by csUriStem // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-201" {
  category                   = "Log Management"
  display_name               = "Shows servers that are throwing internal server error"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|ShowServersThrowingInternalServerError"
  query                      = "search scStatus == 500 | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = count() by sComputerName\r\n// Oql: Type=W3CIISLog scStatus=500 | Measure count() by sComputerName // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-202" {
  category                   = "Log Management"
  display_name               = "Total Bytes received by each Azure Role Instance"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|TotalBytesReceivedByEachAzureRoleInstance"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = sum(csBytes) by RoleInstance\r\n// Oql: Type=W3CIISLog | Measure Sum(csBytes) by RoleInstance // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-203" {
  category                   = "Log Management"
  display_name               = "Total Bytes received by each IIS Computer"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|TotalBytesReceivedByEachIISComputer"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = sum(csBytes) by Computer | limit 500000\r\n// Oql: Type=W3CIISLog | Measure Sum(csBytes) by Computer | top 500000 // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-204" {
  category                   = "Log Management"
  display_name               = "Total Bytes responded back to clients by Client IP Address"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|TotalBytesRespondedToClientsByClientIPAddress"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = sum(scBytes) by cIP\r\n// Oql: Type=W3CIISLog | Measure Sum(scBytes) by cIP // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-205" {
  category                   = "Log Management"
  display_name               = "Total Bytes responded back to clients by each IIS ServerIP Address"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|TotalBytesRespondedToClientsByEachIISServerIPAddress"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = sum(scBytes) by sIP\r\n// Oql: Type=W3CIISLog | Measure Sum(scBytes) by sIP // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-206" {
  category                   = "Log Management"
  display_name               = "Total Bytes sent by Client IP Address"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|TotalBytesSentByClientIPAddress"
  query                      = "search * | extend Type = $table | where Type == W3CIISLog | summarize AggregatedValue = sum(csBytes) by cIP\r\n// Oql: Type=W3CIISLog | Measure Sum(csBytes) by cIP // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PEF: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-207" {
  category                   = "Log Management"
  display_name               = "All Events with level \"Warning\""
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|WarningEvents"
  query                      = "Event | where EventLevelName == \"warning\" | sort by TimeGenerated desc\r\n// Oql: Type=Event EventLevelName=warning // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-208" {
  category                   = "Log Management"
  display_name               = "Windows Firewall Policy settings have changed"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|WindowsFireawallPolicySettingsChanged"
  query                      = "Event | where EventLog == \"Microsoft-Windows-Windows Firewall With Advanced Security/Firewall\" and EventID == 2008 | sort by TimeGenerated desc\r\n// Oql: Type=Event EventLog=\"Microsoft-Windows-Windows Firewall With Advanced Security/Firewall\" EventID=2008 // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_saved_search" "res-209" {
  category                   = "Log Management"
  display_name               = "On which machines and how many times have Windows Firewall Policy settings changed"
  function_alias             = ""
  function_parameters        = []
  log_analytics_workspace_id = azurerm_log_analytics_workspace.res-170.id
  name                       = "LogManagement(workspacemvpconfdemo82e9)_LogManagement|WindowsFireawallPolicySettingsChangedByMachines"
  query                      = "Event | where EventLog == \"Microsoft-Windows-Windows Firewall With Advanced Security/Firewall\" and EventID == 2008 | summarize AggregatedValue = count() by Computer | limit 500000\r\n// Oql: Type=Event EventLog=\"Microsoft-Windows-Windows Firewall With Advanced Security/Firewall\" EventID=2008 | measure count() by Computer | top 500000 // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122"
  tags                       = {}
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-210" {
  description             = ""
  display_name            = "AACAudit"
  name                    = "AACAudit"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-211" {
  description             = ""
  display_name            = "AACHttpRequest"
  name                    = "AACHttpRequest"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-212" {
  description             = ""
  display_name            = "AADAgentRiskEvents"
  name                    = "AADAgentRiskEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-213" {
  description             = ""
  display_name            = "AADB2CRequestLogs"
  name                    = "AADB2CRequestLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-214" {
  description             = ""
  display_name            = "AADCustomSecurityAttributeAuditLogs"
  name                    = "AADCustomSecurityAttributeAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-215" {
  description             = ""
  display_name            = "AADDomainServicesAccountLogon"
  name                    = "AADDomainServicesAccountLogon"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-216" {
  description             = ""
  display_name            = "AADDomainServicesAccountManagement"
  name                    = "AADDomainServicesAccountManagement"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-217" {
  description             = ""
  display_name            = "AADDomainServicesDNSAuditsDynamicUpdates"
  name                    = "AADDomainServicesDNSAuditsDynamicUpdates"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-218" {
  description             = ""
  display_name            = "AADDomainServicesDNSAuditsGeneral"
  name                    = "AADDomainServicesDNSAuditsGeneral"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-219" {
  description             = ""
  display_name            = "AADDomainServicesDirectoryServiceAccess"
  name                    = "AADDomainServicesDirectoryServiceAccess"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-220" {
  description             = ""
  display_name            = "AADDomainServicesLogonLogoff"
  name                    = "AADDomainServicesLogonLogoff"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-221" {
  description             = ""
  display_name            = "AADDomainServicesPolicyChange"
  name                    = "AADDomainServicesPolicyChange"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-222" {
  description             = ""
  display_name            = "AADDomainServicesPrivilegeUse"
  name                    = "AADDomainServicesPrivilegeUse"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-223" {
  description             = ""
  display_name            = "AADDomainServicesSystemSecurity"
  name                    = "AADDomainServicesSystemSecurity"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-224" {
  description             = ""
  display_name            = "AADFirstPartyToFirstPartySignInLogs"
  name                    = "AADFirstPartyToFirstPartySignInLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-225" {
  description             = ""
  display_name            = "AADGraphActivityLogs"
  name                    = "AADGraphActivityLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-226" {
  description             = ""
  display_name            = "AADManagedIdentitySignInLogs"
  name                    = "AADManagedIdentitySignInLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-227" {
  description             = ""
  display_name            = "AADNonInteractiveUserSignInLogs"
  name                    = "AADNonInteractiveUserSignInLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-228" {
  description             = ""
  display_name            = "AADProvisioningLogs"
  name                    = "AADProvisioningLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-229" {
  description             = ""
  display_name            = "AADRiskyAgents"
  name                    = "AADRiskyAgents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-230" {
  description             = ""
  display_name            = "AADRiskyServicePrincipals"
  name                    = "AADRiskyServicePrincipals"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-231" {
  description             = ""
  display_name            = "AADRiskyUsers"
  name                    = "AADRiskyUsers"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-232" {
  description             = ""
  display_name            = "AADServicePrincipalRiskEvents"
  name                    = "AADServicePrincipalRiskEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-233" {
  description             = ""
  display_name            = "AADServicePrincipalSignInLogs"
  name                    = "AADServicePrincipalSignInLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-234" {
  description             = ""
  display_name            = "AADUserRiskEvents"
  name                    = "AADUserRiskEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-235" {
  description             = ""
  display_name            = "ABSBotRequests"
  name                    = "ABSBotRequests"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-236" {
  description             = ""
  display_name            = "ACICollaborationAudit"
  name                    = "ACICollaborationAudit"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-237" {
  description             = ""
  display_name            = "ACLTransactionLogs"
  name                    = "ACLTransactionLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-238" {
  description             = ""
  display_name            = "ACLUserDefinedLogs"
  name                    = "ACLUserDefinedLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-239" {
  description             = ""
  display_name            = "ACRConnectedClientList"
  name                    = "ACRConnectedClientList"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-240" {
  description             = ""
  display_name            = "ACREntraAuthenticationAuditLog"
  name                    = "ACREntraAuthenticationAuditLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-241" {
  description             = ""
  display_name            = "ACSAdvancedMessagingOperations"
  name                    = "ACSAdvancedMessagingOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-242" {
  description             = ""
  display_name            = "ACSAuthIncomingOperations"
  name                    = "ACSAuthIncomingOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-243" {
  description             = ""
  display_name            = "ACSBillingUsage"
  name                    = "ACSBillingUsage"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-244" {
  description             = ""
  display_name            = "ACSCallAutomationIncomingOperations"
  name                    = "ACSCallAutomationIncomingOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-245" {
  description             = ""
  display_name            = "ACSCallAutomationMediaSummary"
  name                    = "ACSCallAutomationMediaSummary"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-246" {
  description             = ""
  display_name            = "ACSCallAutomationStreamingUsage"
  name                    = "ACSCallAutomationStreamingUsage"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-247" {
  description             = ""
  display_name            = "ACSCallClientMediaStatsTimeSeries"
  name                    = "ACSCallClientMediaStatsTimeSeries"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-248" {
  description             = ""
  display_name            = "ACSCallClientOperations"
  name                    = "ACSCallClientOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-249" {
  description             = ""
  display_name            = "ACSCallClientServiceRequestAndOutcome"
  name                    = "ACSCallClientServiceRequestAndOutcome"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-250" {
  description             = ""
  display_name            = "ACSCallClosedCaptionsSummary"
  name                    = "ACSCallClosedCaptionsSummary"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-251" {
  description             = ""
  display_name            = "ACSCallDiagnostics"
  name                    = "ACSCallDiagnostics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-252" {
  description             = ""
  display_name            = "ACSCallDiagnosticsUpdates"
  name                    = "ACSCallDiagnosticsUpdates"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-253" {
  description             = ""
  display_name            = "ACSCallRecordingIncomingOperations"
  name                    = "ACSCallRecordingIncomingOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-254" {
  description             = ""
  display_name            = "ACSCallRecordingSummary"
  name                    = "ACSCallRecordingSummary"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-255" {
  description             = ""
  display_name            = "ACSCallSummary"
  name                    = "ACSCallSummary"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-256" {
  description             = ""
  display_name            = "ACSCallSummaryUpdates"
  name                    = "ACSCallSummaryUpdates"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-257" {
  description             = ""
  display_name            = "ACSCallSurvey"
  name                    = "ACSCallSurvey"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-258" {
  description             = ""
  display_name            = "ACSCallingMetrics"
  name                    = "ACSCallingMetrics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-259" {
  description             = ""
  display_name            = "ACSChatIncomingOperations"
  name                    = "ACSChatIncomingOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-260" {
  description             = ""
  display_name            = "ACSEmailSendMailOperational"
  name                    = "ACSEmailSendMailOperational"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-261" {
  description             = ""
  display_name            = "ACSEmailStatusUpdateOperational"
  name                    = "ACSEmailStatusUpdateOperational"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-262" {
  description             = ""
  display_name            = "ACSEmailUserEngagementOperational"
  name                    = "ACSEmailUserEngagementOperational"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-263" {
  description             = ""
  display_name            = "ACSJobRouterIncomingOperations"
  name                    = "ACSJobRouterIncomingOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-264" {
  description             = ""
  display_name            = "ACSOptOutManagementOperations"
  name                    = "ACSOptOutManagementOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-265" {
  description             = ""
  display_name            = "ACSRoomsIncomingOperations"
  name                    = "ACSRoomsIncomingOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-266" {
  description             = ""
  display_name            = "ACSSMSIncomingOperations"
  name                    = "ACSSMSIncomingOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-267" {
  description             = ""
  display_name            = "ADAssessmentRecommendation"
  name                    = "ADAssessmentRecommendation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-268" {
  description             = ""
  display_name            = "ADFActivityRun"
  name                    = "ADFActivityRun"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-269" {
  description             = ""
  display_name            = "ADFAirflowSchedulerLogs"
  name                    = "ADFAirflowSchedulerLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-270" {
  description             = ""
  display_name            = "ADFAirflowTaskLogs"
  name                    = "ADFAirflowTaskLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-271" {
  description             = ""
  display_name            = "ADFAirflowWebLogs"
  name                    = "ADFAirflowWebLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-272" {
  description             = ""
  display_name            = "ADFAirflowWorkerLogs"
  name                    = "ADFAirflowWorkerLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-273" {
  description             = ""
  display_name            = "ADFPipelineRun"
  name                    = "ADFPipelineRun"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-274" {
  description             = ""
  display_name            = "ADFSSISIntegrationRuntimeLogs"
  name                    = "ADFSSISIntegrationRuntimeLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-275" {
  description             = ""
  display_name            = "ADFSSISPackageEventMessageContext"
  name                    = "ADFSSISPackageEventMessageContext"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-276" {
  description             = ""
  display_name            = "ADFSSISPackageEventMessages"
  name                    = "ADFSSISPackageEventMessages"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-277" {
  description             = ""
  display_name            = "ADFSSISPackageExecutableStatistics"
  name                    = "ADFSSISPackageExecutableStatistics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-278" {
  description             = ""
  display_name            = "ADFSSISPackageExecutionComponentPhases"
  name                    = "ADFSSISPackageExecutionComponentPhases"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-279" {
  description             = ""
  display_name            = "ADFSSISPackageExecutionDataStatistics"
  name                    = "ADFSSISPackageExecutionDataStatistics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-280" {
  description             = ""
  display_name            = "ADFSSignInLogs"
  name                    = "ADFSSignInLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-281" {
  description             = ""
  display_name            = "ADFSandboxActivityRun"
  name                    = "ADFSandboxActivityRun"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-282" {
  description             = ""
  display_name            = "ADFSandboxPipelineRun"
  name                    = "ADFSandboxPipelineRun"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-283" {
  description             = ""
  display_name            = "ADFTriggerRun"
  name                    = "ADFTriggerRun"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-284" {
  description             = ""
  display_name            = "ADGSyslogEvent"
  name                    = "ADGSyslogEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-285" {
  description             = ""
  display_name            = "ADReplicationResult"
  name                    = "ADReplicationResult"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-286" {
  description             = ""
  display_name            = "ADSecurityAssessmentRecommendation"
  name                    = "ADSecurityAssessmentRecommendation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-287" {
  description             = ""
  display_name            = "ADTDataHistoryOperation"
  name                    = "ADTDataHistoryOperation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-288" {
  description             = ""
  display_name            = "ADTDigitalTwinsOperation"
  name                    = "ADTDigitalTwinsOperation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-289" {
  description             = ""
  display_name            = "ADTEventRoutesOperation"
  name                    = "ADTEventRoutesOperation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-290" {
  description             = ""
  display_name            = "ADTModelsOperation"
  name                    = "ADTModelsOperation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-291" {
  description             = ""
  display_name            = "ADTQueryOperation"
  name                    = "ADTQueryOperation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-292" {
  description             = ""
  display_name            = "ADXCommand"
  name                    = "ADXCommand"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-293" {
  description             = ""
  display_name            = "ADXDataOperation"
  name                    = "ADXDataOperation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-294" {
  description             = ""
  display_name            = "ADXIngestionBatching"
  name                    = "ADXIngestionBatching"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-295" {
  description             = ""
  display_name            = "ADXJournal"
  name                    = "ADXJournal"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-296" {
  description             = ""
  display_name            = "ADXQuery"
  name                    = "ADXQuery"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-297" {
  description             = ""
  display_name            = "ADXTableDetails"
  name                    = "ADXTableDetails"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-298" {
  description             = ""
  display_name            = "ADXTableUsageStatistics"
  name                    = "ADXTableUsageStatistics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-299" {
  description             = ""
  display_name            = "AEWAssignmentBlobLogs"
  name                    = "AEWAssignmentBlobLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-300" {
  description             = ""
  display_name            = "AEWAuditLogs"
  name                    = "AEWAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-301" {
  description             = ""
  display_name            = "AEWComputePipelinesLogs"
  name                    = "AEWComputePipelinesLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-302" {
  description             = ""
  display_name            = "AEWExperimentAssignmentSummary"
  name                    = "AEWExperimentAssignmentSummary"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-303" {
  description             = ""
  display_name            = "AEWExperimentScorecardMetricPairs"
  name                    = "AEWExperimentScorecardMetricPairs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-304" {
  description             = ""
  display_name            = "AEWExperimentScorecards"
  name                    = "AEWExperimentScorecards"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-305" {
  description             = ""
  display_name            = "AFSAuditLogs"
  name                    = "AFSAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-306" {
  description             = ""
  display_name            = "AGCAccessLogs"
  name                    = "AGCAccessLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-307" {
  description             = ""
  display_name            = "AGCFirewallLogs"
  name                    = "AGCFirewallLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-308" {
  description             = ""
  display_name            = "AGSGrafanaAlertAuthFailure"
  name                    = "AGSGrafanaAlertAuthFailure"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-309" {
  description             = ""
  display_name            = "AGSGrafanaLoginEvents"
  name                    = "AGSGrafanaLoginEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-310" {
  description             = ""
  display_name            = "AGSGrafanaUsageInsightsEvents"
  name                    = "AGSGrafanaUsageInsightsEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-311" {
  description             = ""
  display_name            = "AGSUpdateEvents"
  name                    = "AGSUpdateEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-312" {
  description             = ""
  display_name            = "AGWAccessLogs"
  name                    = "AGWAccessLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-313" {
  description             = ""
  display_name            = "AGWFirewallLogs"
  name                    = "AGWFirewallLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-314" {
  description             = ""
  display_name            = "AGWPerformanceLogs"
  name                    = "AGWPerformanceLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-315" {
  description             = ""
  display_name            = "AHCIDiagnosticLogs"
  name                    = "AHCIDiagnosticLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-316" {
  description             = ""
  display_name            = "AHDSDeidAuditLogs"
  name                    = "AHDSDeidAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-317" {
  description             = ""
  display_name            = "AHDSDicomAuditLogs"
  name                    = "AHDSDicomAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-318" {
  description             = ""
  display_name            = "AHDSDicomDiagnosticLogs"
  name                    = "AHDSDicomDiagnosticLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-319" {
  description             = ""
  display_name            = "AHDSMedTechDiagnosticLogs"
  name                    = "AHDSMedTechDiagnosticLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-320" {
  description             = ""
  display_name            = "AKSAudit"
  name                    = "AKSAudit"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-321" {
  description             = ""
  display_name            = "AKSAuditAdmin"
  name                    = "AKSAuditAdmin"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-322" {
  description             = ""
  display_name            = "AKSControlPlane"
  name                    = "AKSControlPlane"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-323" {
  description             = ""
  display_name            = "ALBHealthEvent"
  name                    = "ALBHealthEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-324" {
  description             = ""
  display_name            = "AMAHealth"
  name                    = "AMAHealth"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-325" {
  description             = ""
  display_name            = "AMSKeyDeliveryRequests"
  name                    = "AMSKeyDeliveryRequests"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-326" {
  description             = ""
  display_name            = "AMSLiveEventOperations"
  name                    = "AMSLiveEventOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-327" {
  description             = ""
  display_name            = "AMSMediaAccountHealth"
  name                    = "AMSMediaAccountHealth"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-328" {
  description             = ""
  display_name            = "AMSStreamingEndpointRequests"
  name                    = "AMSStreamingEndpointRequests"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-329" {
  description             = ""
  display_name            = "AMWMetricsUsageDetails"
  name                    = "AMWMetricsUsageDetails"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-330" {
  description             = ""
  display_name            = "ANFFileAccess"
  name                    = "ANFFileAccess"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-331" {
  description             = ""
  display_name            = "ANFTopClientReadIOPS"
  name                    = "ANFTopClientReadIOPS"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-332" {
  description             = ""
  display_name            = "ANFTopClientWriteIOPS"
  name                    = "ANFTopClientWriteIOPS"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-333" {
  description             = ""
  display_name            = "ANFTopFileReadIOPS"
  name                    = "ANFTopFileReadIOPS"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-334" {
  description             = ""
  display_name            = "ANFTopFileWriteIOPS"
  name                    = "ANFTopFileWriteIOPS"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-335" {
  description             = ""
  display_name            = "AOIDatabaseQuery"
  name                    = "AOIDatabaseQuery"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-336" {
  description             = ""
  display_name            = "AOIDigestion"
  name                    = "AOIDigestion"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-337" {
  description             = ""
  display_name            = "AOIStorage"
  name                    = "AOIStorage"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-338" {
  description             = ""
  display_name            = "APIMDevPortalAuditDiagnosticLog"
  name                    = "APIMDevPortalAuditDiagnosticLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-339" {
  description             = ""
  display_name            = "ASCAuditLogs"
  name                    = "ASCAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-340" {
  description             = ""
  display_name            = "ASCDeviceEvents"
  name                    = "ASCDeviceEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-341" {
  description             = ""
  display_name            = "ASRJobs"
  name                    = "ASRJobs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-342" {
  description             = ""
  display_name            = "ASRReplicatedItems"
  name                    = "ASRReplicatedItems"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-343" {
  description             = ""
  display_name            = "ASRv2HealthEvents"
  name                    = "ASRv2HealthEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-344" {
  description             = ""
  display_name            = "ASRv2JobEvents"
  name                    = "ASRv2JobEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-345" {
  description             = ""
  display_name            = "ASRv2ProtectedItems"
  name                    = "ASRv2ProtectedItems"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-346" {
  description             = ""
  display_name            = "ASRv2ReplicationExtensions"
  name                    = "ASRv2ReplicationExtensions"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-347" {
  description             = ""
  display_name            = "ASRv2ReplicationPolicies"
  name                    = "ASRv2ReplicationPolicies"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-348" {
  description             = ""
  display_name            = "ASRv2ReplicationVaults"
  name                    = "ASRv2ReplicationVaults"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-349" {
  description             = ""
  display_name            = "ATCExpressRouteCircuitIpfix"
  name                    = "ATCExpressRouteCircuitIpfix"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-350" {
  description             = ""
  display_name            = "ATCMicrosoftPeeringMetadata"
  name                    = "ATCMicrosoftPeeringMetadata"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-351" {
  description             = ""
  display_name            = "ATCPrivatePeeringMetadata"
  name                    = "ATCPrivatePeeringMetadata"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-352" {
  description             = ""
  display_name            = "AVNMConnectivityConfigurationChange"
  name                    = "AVNMConnectivityConfigurationChange"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-353" {
  description             = ""
  display_name            = "AVNMIPAMPoolAllocationChange"
  name                    = "AVNMIPAMPoolAllocationChange"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-354" {
  description             = ""
  display_name            = "AVNMNetworkGroupMembershipChange"
  name                    = "AVNMNetworkGroupMembershipChange"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-355" {
  description             = ""
  display_name            = "AVNMRuleCollectionChange"
  name                    = "AVNMRuleCollectionChange"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-356" {
  description             = ""
  display_name            = "AVSEsxiFirewallSyslog"
  name                    = "AVSEsxiFirewallSyslog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-357" {
  description             = ""
  display_name            = "AVSEsxiSyslog"
  name                    = "AVSEsxiSyslog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-358" {
  description             = ""
  display_name            = "AVSNsxEdgeSyslog"
  name                    = "AVSNsxEdgeSyslog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-359" {
  description             = ""
  display_name            = "AVSNsxManagerSyslog"
  name                    = "AVSNsxManagerSyslog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-360" {
  description             = ""
  display_name            = "AVSSyslog"
  name                    = "AVSSyslog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-361" {
  description             = ""
  display_name            = "AVSVcSyslog"
  name                    = "AVSVcSyslog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-362" {
  description             = ""
  display_name            = "AZFWApplicationRule"
  name                    = "AZFWApplicationRule"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-363" {
  description             = ""
  display_name            = "AZFWApplicationRuleAggregation"
  name                    = "AZFWApplicationRuleAggregation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-364" {
  description             = ""
  display_name            = "AZFWDnsFlowTrace"
  name                    = "AZFWDnsFlowTrace"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-365" {
  description             = ""
  display_name            = "AZFWDnsQuery"
  name                    = "AZFWDnsQuery"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-366" {
  description             = ""
  display_name            = "AZFWFatFlow"
  name                    = "AZFWFatFlow"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-367" {
  description             = ""
  display_name            = "AZFWFlowTrace"
  name                    = "AZFWFlowTrace"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-368" {
  description             = ""
  display_name            = "AZFWIdpsSignature"
  name                    = "AZFWIdpsSignature"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-369" {
  description             = ""
  display_name            = "AZFWInternalFqdnResolutionFailure"
  name                    = "AZFWInternalFqdnResolutionFailure"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-370" {
  description             = ""
  display_name            = "AZFWNatRule"
  name                    = "AZFWNatRule"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-371" {
  description             = ""
  display_name            = "AZFWNatRuleAggregation"
  name                    = "AZFWNatRuleAggregation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-372" {
  description             = ""
  display_name            = "AZFWNetworkRule"
  name                    = "AZFWNetworkRule"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-373" {
  description             = ""
  display_name            = "AZFWNetworkRuleAggregation"
  name                    = "AZFWNetworkRuleAggregation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-374" {
  description             = ""
  display_name            = "AZFWThreatIntel"
  name                    = "AZFWThreatIntel"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-375" {
  description             = ""
  display_name            = "AZKVAuditLogs"
  name                    = "AZKVAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-376" {
  description             = ""
  display_name            = "AZKVPolicyEvaluationDetailsLogs"
  name                    = "AZKVPolicyEvaluationDetailsLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-377" {
  description             = ""
  display_name            = "AZMSApplicationMetricLogs"
  name                    = "AZMSApplicationMetricLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-378" {
  description             = ""
  display_name            = "AZMSArchiveLogs"
  name                    = "AZMSArchiveLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-379" {
  description             = ""
  display_name            = "AZMSAutoscaleLogs"
  name                    = "AZMSAutoscaleLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-380" {
  description             = ""
  display_name            = "AZMSCustomerManagedKeyUserLogs"
  name                    = "AZMSCustomerManagedKeyUserLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-381" {
  description             = ""
  display_name            = "AZMSDiagnosticErrorLogs"
  name                    = "AZMSDiagnosticErrorLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-382" {
  description             = ""
  display_name            = "AZMSHybridConnectionsEvents"
  name                    = "AZMSHybridConnectionsEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-383" {
  description             = ""
  display_name            = "AZMSKafkaCoordinatorLogs"
  name                    = "AZMSKafkaCoordinatorLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-384" {
  description             = ""
  display_name            = "AZMSKafkaUserErrorLogs"
  name                    = "AZMSKafkaUserErrorLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-385" {
  description             = ""
  display_name            = "AZMSOperationalLogs"
  name                    = "AZMSOperationalLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-386" {
  description             = ""
  display_name            = "AZMSRunTimeAuditLogs"
  name                    = "AZMSRunTimeAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-387" {
  description             = ""
  display_name            = "AZMSVnetConnectionEvents"
  name                    = "AZMSVnetConnectionEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-388" {
  description             = ""
  display_name            = "AddonAzureBackupAlerts"
  name                    = "AddonAzureBackupAlerts"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-389" {
  description             = ""
  display_name            = "AddonAzureBackupJobs"
  name                    = "AddonAzureBackupJobs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-390" {
  description             = ""
  display_name            = "AddonAzureBackupPolicy"
  name                    = "AddonAzureBackupPolicy"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-391" {
  description             = ""
  display_name            = "AddonAzureBackupProtectedInstance"
  name                    = "AddonAzureBackupProtectedInstance"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-392" {
  description             = ""
  display_name            = "AddonAzureBackupStorage"
  name                    = "AddonAzureBackupStorage"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-393" {
  description             = ""
  display_name            = "AegDataPlaneRequests"
  name                    = "AegDataPlaneRequests"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-394" {
  description             = ""
  display_name            = "AegDeliveryFailureLogs"
  name                    = "AegDeliveryFailureLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-395" {
  description             = ""
  display_name            = "AegPublishFailureLogs"
  name                    = "AegPublishFailureLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-396" {
  description             = ""
  display_name            = "AgriFoodApplicationAuditLogs"
  name                    = "AgriFoodApplicationAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-397" {
  description             = ""
  display_name            = "AgriFoodFarmManagementLogs"
  name                    = "AgriFoodFarmManagementLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-398" {
  description             = ""
  display_name            = "AgriFoodFarmOperationLogs"
  name                    = "AgriFoodFarmOperationLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-399" {
  description             = ""
  display_name            = "AgriFoodInsightLogs"
  name                    = "AgriFoodInsightLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-400" {
  description             = ""
  display_name            = "AgriFoodJobProcessedLogs"
  name                    = "AgriFoodJobProcessedLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-401" {
  description             = ""
  display_name            = "AgriFoodModelInferenceLogs"
  name                    = "AgriFoodModelInferenceLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-402" {
  description             = ""
  display_name            = "AgriFoodProviderAuthLogs"
  name                    = "AgriFoodProviderAuthLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-403" {
  description             = ""
  display_name            = "AgriFoodSatelliteLogs"
  name                    = "AgriFoodSatelliteLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-404" {
  description             = ""
  display_name            = "AgriFoodSensorManagementLogs"
  name                    = "AgriFoodSensorManagementLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-405" {
  description             = ""
  display_name            = "AgriFoodWeatherLogs"
  name                    = "AgriFoodWeatherLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-406" {
  description             = ""
  display_name            = "AirflowDagProcessingLogs"
  name                    = "AirflowDagProcessingLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-407" {
  description             = ""
  display_name            = "Alert"
  name                    = "Alert"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-408" {
  description             = ""
  display_name            = "AmlComputeClusterEvent"
  name                    = "AmlComputeClusterEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-409" {
  description             = ""
  display_name            = "AmlComputeClusterNodeEvent"
  name                    = "AmlComputeClusterNodeEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-410" {
  description             = ""
  display_name            = "AmlComputeCpuGpuUtilization"
  name                    = "AmlComputeCpuGpuUtilization"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-411" {
  description             = ""
  display_name            = "AmlComputeInstanceEvent"
  name                    = "AmlComputeInstanceEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-412" {
  description             = ""
  display_name            = "AmlComputeJobEvent"
  name                    = "AmlComputeJobEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-413" {
  description             = ""
  display_name            = "AmlDataLabelEvent"
  name                    = "AmlDataLabelEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-414" {
  description             = ""
  display_name            = "AmlDataSetEvent"
  name                    = "AmlDataSetEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-415" {
  description             = ""
  display_name            = "AmlDataStoreEvent"
  name                    = "AmlDataStoreEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-416" {
  description             = ""
  display_name            = "AmlDeploymentEvent"
  name                    = "AmlDeploymentEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-417" {
  description             = ""
  display_name            = "AmlEnvironmentEvent"
  name                    = "AmlEnvironmentEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-418" {
  description             = ""
  display_name            = "AmlInferencingEvent"
  name                    = "AmlInferencingEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-419" {
  description             = ""
  display_name            = "AmlModelsEvent"
  name                    = "AmlModelsEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-420" {
  description             = ""
  display_name            = "AmlOnlineEndpointConsoleLog"
  name                    = "AmlOnlineEndpointConsoleLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-421" {
  description             = ""
  display_name            = "AmlOnlineEndpointEventLog"
  name                    = "AmlOnlineEndpointEventLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-422" {
  description             = ""
  display_name            = "AmlOnlineEndpointTrafficLog"
  name                    = "AmlOnlineEndpointTrafficLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-423" {
  description             = ""
  display_name            = "AmlPipelineEvent"
  name                    = "AmlPipelineEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-424" {
  description             = ""
  display_name            = "AmlRegistryReadEventsLog"
  name                    = "AmlRegistryReadEventsLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-425" {
  description             = ""
  display_name            = "AmlRegistryWriteEventsLog"
  name                    = "AmlRegistryWriteEventsLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-426" {
  description             = ""
  display_name            = "AmlRunEvent"
  name                    = "AmlRunEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-427" {
  description             = ""
  display_name            = "AmlRunStatusChangedEvent"
  name                    = "AmlRunStatusChangedEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-428" {
  description             = ""
  display_name            = "ApiManagementGatewayLlmLog"
  name                    = "ApiManagementGatewayLlmLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-429" {
  description             = ""
  display_name            = "ApiManagementGatewayLogs"
  name                    = "ApiManagementGatewayLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-430" {
  description             = ""
  display_name            = "ApiManagementGatewayMCPLog"
  name                    = "ApiManagementGatewayMCPLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-431" {
  description             = ""
  display_name            = "ApiManagementWebSocketConnectionLogs"
  name                    = "ApiManagementWebSocketConnectionLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-432" {
  description             = ""
  display_name            = "AppAvailabilityResults"
  name                    = "AppAvailabilityResults"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-433" {
  description             = ""
  display_name            = "AppBrowserTimings"
  name                    = "AppBrowserTimings"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-434" {
  description             = ""
  display_name            = "AppCenterError"
  name                    = "AppCenterError"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-435" {
  description             = ""
  display_name            = "AppDependencies"
  name                    = "AppDependencies"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-436" {
  description             = ""
  display_name            = "AppEnvSessionConsoleLogs"
  name                    = "AppEnvSessionConsoleLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-437" {
  description             = ""
  display_name            = "AppEnvSessionLifecycleLogs"
  name                    = "AppEnvSessionLifecycleLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-438" {
  description             = ""
  display_name            = "AppEnvSessionPoolEventLogs"
  name                    = "AppEnvSessionPoolEventLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-439" {
  description             = ""
  display_name            = "AppEnvSpringAppConsoleLogs"
  name                    = "AppEnvSpringAppConsoleLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-440" {
  description             = ""
  display_name            = "AppEvents"
  name                    = "AppEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-441" {
  description             = ""
  display_name            = "AppExceptions"
  name                    = "AppExceptions"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-442" {
  description             = ""
  display_name            = "AppGenAIContent"
  name                    = "AppGenAIContent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-443" {
  description             = ""
  display_name            = "AppMetrics"
  name                    = "AppMetrics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-444" {
  description             = ""
  display_name            = "AppPageViews"
  name                    = "AppPageViews"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-445" {
  description             = ""
  display_name            = "AppPerformanceCounters"
  name                    = "AppPerformanceCounters"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-446" {
  description             = ""
  display_name            = "AppPlatformBuildLogs"
  name                    = "AppPlatformBuildLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-447" {
  description             = ""
  display_name            = "AppPlatformContainerEventLogs"
  name                    = "AppPlatformContainerEventLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-448" {
  description             = ""
  display_name            = "AppPlatformIngressLogs"
  name                    = "AppPlatformIngressLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-449" {
  description             = ""
  display_name            = "AppPlatformLogsforSpring"
  name                    = "AppPlatformLogsforSpring"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-450" {
  description             = ""
  display_name            = "AppPlatformSystemLogs"
  name                    = "AppPlatformSystemLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-451" {
  description             = ""
  display_name            = "AppRequests"
  name                    = "AppRequests"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-452" {
  description             = ""
  display_name            = "AppServiceAntivirusScanAuditLogs"
  name                    = "AppServiceAntivirusScanAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-453" {
  description             = ""
  display_name            = "AppServiceAppLogs"
  name                    = "AppServiceAppLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-454" {
  description             = ""
  display_name            = "AppServiceAuditLogs"
  name                    = "AppServiceAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-455" {
  description             = ""
  display_name            = "AppServiceAuthenticationLogs"
  name                    = "AppServiceAuthenticationLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-456" {
  description             = ""
  display_name            = "AppServiceConsoleLogs"
  name                    = "AppServiceConsoleLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-457" {
  description             = ""
  display_name            = "AppServiceEnvironmentPlatformLogs"
  name                    = "AppServiceEnvironmentPlatformLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-458" {
  description             = ""
  display_name            = "AppServiceFileAuditLogs"
  name                    = "AppServiceFileAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-459" {
  description             = ""
  display_name            = "AppServiceHTTPLogs"
  name                    = "AppServiceHTTPLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-460" {
  description             = ""
  display_name            = "AppServiceIPSecAuditLogs"
  name                    = "AppServiceIPSecAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-461" {
  description             = ""
  display_name            = "AppServicePlatformLogs"
  name                    = "AppServicePlatformLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-462" {
  description             = ""
  display_name            = "AppServiceServerlessSecurityPluginData"
  name                    = "AppServiceServerlessSecurityPluginData"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-463" {
  description             = ""
  display_name            = "AppSystemEvents"
  name                    = "AppSystemEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-464" {
  description             = ""
  display_name            = "AppTraces"
  name                    = "AppTraces"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-465" {
  description             = ""
  display_name            = "ArcK8sAudit"
  name                    = "ArcK8sAudit"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-466" {
  description             = ""
  display_name            = "ArcK8sAuditAdmin"
  name                    = "ArcK8sAuditAdmin"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-467" {
  description             = ""
  display_name            = "ArcK8sControlPlane"
  name                    = "ArcK8sControlPlane"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-468" {
  description             = ""
  display_name            = "AuditLogs"
  name                    = "AuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-469" {
  description             = ""
  display_name            = "AutoscaleEvaluationsLog"
  name                    = "AutoscaleEvaluationsLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-470" {
  description             = ""
  display_name            = "AutoscaleScaleActionsLog"
  name                    = "AutoscaleScaleActionsLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-471" {
  description             = ""
  display_name            = "AzureActivity"
  name                    = "AzureActivity"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-472" {
  description             = ""
  display_name            = "AzureActivityV2"
  name                    = "AzureActivityV2"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-473" {
  description             = ""
  display_name            = "AzureAssessmentRecommendation"
  name                    = "AzureAssessmentRecommendation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-474" {
  description             = ""
  display_name            = "AzureAttestationDiagnostics"
  name                    = "AzureAttestationDiagnostics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-475" {
  description             = ""
  display_name            = "AzureBackupOperations"
  name                    = "AzureBackupOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-476" {
  description             = ""
  display_name            = "AzureDevOpsAuditing"
  name                    = "AzureDevOpsAuditing"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-477" {
  description             = ""
  display_name            = "AzureLoadTestingOperation"
  name                    = "AzureLoadTestingOperation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-478" {
  description             = ""
  display_name            = "AzureMetrics"
  name                    = "AzureMetrics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-479" {
  description             = ""
  display_name            = "AzureMetricsV2"
  name                    = "AzureMetricsV2"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-480" {
  description             = ""
  display_name            = "AzureMonitorPipelineLogErrors"
  name                    = "AzureMonitorPipelineLogErrors"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-481" {
  description             = ""
  display_name            = "AzureSQLAutomaticTuning"
  name                    = "AzureSQLAutomaticTuning"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-482" {
  description             = ""
  display_name            = "AzureSQLBlocks"
  name                    = "AzureSQLBlocks"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-483" {
  description             = ""
  display_name            = "AzureSQLDatabaseWaitStatistics"
  name                    = "AzureSQLDatabaseWaitStatistics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-484" {
  description             = ""
  display_name            = "AzureSQLDeadlocks"
  name                    = "AzureSQLDeadlocks"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-485" {
  description             = ""
  display_name            = "AzureSQLErrors"
  name                    = "AzureSQLErrors"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-486" {
  description             = ""
  display_name            = "AzureSQLQueryStoreRuntimeStatistics"
  name                    = "AzureSQLQueryStoreRuntimeStatistics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-487" {
  description             = ""
  display_name            = "AzureSQLQueryStoreWaitStatistics"
  name                    = "AzureSQLQueryStoreWaitStatistics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-488" {
  description             = ""
  display_name            = "AzureSQLResourceUsageStats"
  name                    = "AzureSQLResourceUsageStats"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-489" {
  description             = ""
  display_name            = "AzureSQLTimeouts"
  name                    = "AzureSQLTimeouts"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-490" {
  description             = ""
  display_name            = "BaiClusterNodeEvent"
  name                    = "BaiClusterNodeEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-491" {
  description             = ""
  display_name            = "BehaviorEntities"
  name                    = "BehaviorEntities"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-492" {
  description             = ""
  display_name            = "BehaviorInfo"
  name                    = "BehaviorInfo"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-493" {
  description             = ""
  display_name            = "BlockchainApplicationLog"
  name                    = "BlockchainApplicationLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-494" {
  description             = ""
  display_name            = "BlockchainProxyLog"
  name                    = "BlockchainProxyLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-495" {
  description             = ""
  display_name            = "CCFApplicationLogs"
  name                    = "CCFApplicationLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-496" {
  description             = ""
  display_name            = "CDBCassandraRequests"
  name                    = "CDBCassandraRequests"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-497" {
  description             = ""
  display_name            = "CDBControlPlaneRequests"
  name                    = "CDBControlPlaneRequests"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-498" {
  description             = ""
  display_name            = "CDBDataPlaneRequests"
  name                    = "CDBDataPlaneRequests"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-499" {
  description             = ""
  display_name            = "CDBDataPlaneRequests15M"
  name                    = "CDBDataPlaneRequests15M"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-500" {
  description             = ""
  display_name            = "CDBDataPlaneRequests5M"
  name                    = "CDBDataPlaneRequests5M"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-501" {
  description             = ""
  display_name            = "CDBGremlinRequests"
  name                    = "CDBGremlinRequests"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-502" {
  description             = ""
  display_name            = "CDBMongoRequests"
  name                    = "CDBMongoRequests"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-503" {
  description             = ""
  display_name            = "CDBPartitionKeyRUConsumption"
  name                    = "CDBPartitionKeyRUConsumption"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-504" {
  description             = ""
  display_name            = "CDBPartitionKeyStatistics"
  name                    = "CDBPartitionKeyStatistics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-505" {
  description             = ""
  display_name            = "CDBQueryRuntimeStatistics"
  name                    = "CDBQueryRuntimeStatistics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-506" {
  description             = ""
  display_name            = "CDBTableApiRequests"
  name                    = "CDBTableApiRequests"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-507" {
  description             = ""
  display_name            = "CHSMServiceOperationAuditLogs"
  name                    = "CHSMServiceOperationAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-508" {
  description             = ""
  display_name            = "CIEventsAudit"
  name                    = "CIEventsAudit"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-509" {
  description             = ""
  display_name            = "CIEventsOperational"
  name                    = "CIEventsOperational"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-510" {
  description             = ""
  display_name            = "CassandraAudit"
  name                    = "CassandraAudit"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-511" {
  description             = ""
  display_name            = "CassandraLogs"
  name                    = "CassandraLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-512" {
  description             = ""
  display_name            = "ChaosStudioExperimentEventLogs"
  name                    = "ChaosStudioExperimentEventLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-513" {
  description             = ""
  display_name            = "CloudHsmHardwareOperationAuditLogs"
  name                    = "CloudHsmHardwareOperationAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-514" {
  description             = ""
  display_name            = "CloudHsmServiceOperationAuditLogs"
  name                    = "CloudHsmServiceOperationAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-515" {
  description             = ""
  display_name            = "ComputerGroup"
  name                    = "ComputerGroup"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-516" {
  description             = ""
  display_name            = "ContainerAppConsoleLogs"
  name                    = "ContainerAppConsoleLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-517" {
  description             = ""
  display_name            = "ContainerAppConsoleLogs_CL"
  name                    = "ContainerAppConsoleLogs_CL"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
  column {
    description  = ""
    display_name = "_timestamp_d"
    name         = "_timestamp_d"
    type         = "real"
  }
  column {
    description  = ""
    display_name = "ContainerAppName_s"
    name         = "ContainerAppName_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "ContainerGroupId_g"
    name         = "ContainerGroupId_g"
    type         = "guid"
  }
  column {
    description  = ""
    display_name = "EnvironmentName_s"
    name         = "EnvironmentName_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "ContainerId_g"
    name         = "ContainerId_g"
    type         = "guid"
  }
  column {
    description  = ""
    display_name = "time_t"
    name         = "time_t"
    type         = "dateTime"
  }
  column {
    description  = ""
    display_name = "Stream_s"
    name         = "Stream_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "Log_s"
    name         = "Log_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "ContainerGroupName_s"
    name         = "ContainerGroupName_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "ContainerImage_s"
    name         = "ContainerImage_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "Category"
    name         = "Category"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "RevisionName_s"
    name         = "RevisionName_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "ContainerName_s"
    name         = "ContainerName_s"
    type         = "string"
  }
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-518" {
  description             = ""
  display_name            = "ContainerAppHTTPLogs"
  name                    = "ContainerAppHTTPLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-519" {
  description             = ""
  display_name            = "ContainerAppSystemLogs"
  name                    = "ContainerAppSystemLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-520" {
  description             = ""
  display_name            = "ContainerAppSystemLogs_CL"
  name                    = "ContainerAppSystemLogs_CL"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
  column {
    description  = ""
    display_name = "time_t"
    name         = "time_t"
    type         = "dateTime"
  }
  column {
    description  = ""
    display_name = "CappsEventKind_s"
    name         = "CappsEventKind_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "_timestamp_d"
    name         = "_timestamp_d"
    type         = "real"
  }
  column {
    description  = ""
    display_name = "EnvironmentName_s"
    name         = "EnvironmentName_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "time_s"
    name         = "time_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "TimeStamp_s"
    name         = "TimeStamp_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "JobName_s"
    name         = "JobName_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "Type_s"
    name         = "Type_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "RevisionName_s"
    name         = "RevisionName_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "ReplicaName_s"
    name         = "ReplicaName_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "Log_s"
    name         = "Log_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "ExecutionName_s"
    name         = "ExecutionName_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "Reason_s"
    name         = "Reason_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "EventSource_s"
    name         = "EventSource_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "ContainerAppName_s"
    name         = "ContainerAppName_s"
    type         = "string"
  }
  column {
    description  = ""
    display_name = "Count_d"
    name         = "Count_d"
    type         = "real"
  }
  column {
    description  = ""
    display_name = "Level"
    name         = "Level"
    type         = "string"
  }
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-521" {
  description             = ""
  display_name            = "ContainerEvent"
  name                    = "ContainerEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-522" {
  description             = ""
  display_name            = "ContainerImageInventory"
  name                    = "ContainerImageInventory"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-523" {
  description             = ""
  display_name            = "ContainerInstanceLog"
  name                    = "ContainerInstanceLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-524" {
  description             = ""
  display_name            = "ContainerInventory"
  name                    = "ContainerInventory"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-525" {
  description             = ""
  display_name            = "ContainerLog"
  name                    = "ContainerLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-526" {
  description             = ""
  display_name            = "ContainerLogV2"
  name                    = "ContainerLogV2"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-527" {
  description             = ""
  display_name            = "ContainerNetworkLogs"
  name                    = "ContainerNetworkLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-528" {
  description             = ""
  display_name            = "ContainerNodeInventory"
  name                    = "ContainerNodeInventory"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-529" {
  description             = ""
  display_name            = "ContainerRegistryLoginEvents"
  name                    = "ContainerRegistryLoginEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-530" {
  description             = ""
  display_name            = "ContainerRegistryRepositoryEvents"
  name                    = "ContainerRegistryRepositoryEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-531" {
  description             = ""
  display_name            = "ContainerServiceLog"
  name                    = "ContainerServiceLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-532" {
  description             = ""
  display_name            = "CoreAzureBackup"
  name                    = "CoreAzureBackup"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-533" {
  description             = ""
  display_name            = "DCRLogErrors"
  name                    = "DCRLogErrors"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-534" {
  description             = ""
  display_name            = "DCRLogTroubleshooting"
  name                    = "DCRLogTroubleshooting"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-535" {
  description             = ""
  display_name            = "DNSQueryLogs"
  name                    = "DNSQueryLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-536" {
  description             = ""
  display_name            = "DSMAzureBlobStorageLogs"
  name                    = "DSMAzureBlobStorageLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-537" {
  description             = ""
  display_name            = "DSMDataClassificationLogs"
  name                    = "DSMDataClassificationLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-538" {
  description             = ""
  display_name            = "DSMDataLabelingLogs"
  name                    = "DSMDataLabelingLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-539" {
  description             = ""
  display_name            = "DataSetOutput"
  name                    = "DataSetOutput"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-540" {
  description             = ""
  display_name            = "DataSetRuns"
  name                    = "DataSetRuns"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-541" {
  description             = ""
  display_name            = "DataTransferOperations"
  name                    = "DataTransferOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-542" {
  description             = ""
  display_name            = "DatabricksAccounts"
  name                    = "DatabricksAccounts"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-543" {
  description             = ""
  display_name            = "DatabricksApps"
  name                    = "DatabricksApps"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-544" {
  description             = ""
  display_name            = "DatabricksBrickStoreHttpGateway"
  name                    = "DatabricksBrickStoreHttpGateway"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-545" {
  description             = ""
  display_name            = "DatabricksBudgetPolicyCentral"
  name                    = "DatabricksBudgetPolicyCentral"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-546" {
  description             = ""
  display_name            = "DatabricksCapsule8Dataplane"
  name                    = "DatabricksCapsule8Dataplane"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-547" {
  description             = ""
  display_name            = "DatabricksClamAVScan"
  name                    = "DatabricksClamAVScan"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-548" {
  description             = ""
  display_name            = "DatabricksCloudStorageMetadata"
  name                    = "DatabricksCloudStorageMetadata"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-549" {
  description             = ""
  display_name            = "DatabricksClusterLibraries"
  name                    = "DatabricksClusterLibraries"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-550" {
  description             = ""
  display_name            = "DatabricksClusterPolicies"
  name                    = "DatabricksClusterPolicies"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-551" {
  description             = ""
  display_name            = "DatabricksClusters"
  name                    = "DatabricksClusters"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-552" {
  description             = ""
  display_name            = "DatabricksDBFS"
  name                    = "DatabricksDBFS"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-553" {
  description             = ""
  display_name            = "DatabricksDashboards"
  name                    = "DatabricksDashboards"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-554" {
  description             = ""
  display_name            = "DatabricksDataMonitoring"
  name                    = "DatabricksDataMonitoring"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-555" {
  description             = ""
  display_name            = "DatabricksDataRooms"
  name                    = "DatabricksDataRooms"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-556" {
  description             = ""
  display_name            = "DatabricksDatabricksSQL"
  name                    = "DatabricksDatabricksSQL"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-557" {
  description             = ""
  display_name            = "DatabricksDeltaPipelines"
  name                    = "DatabricksDeltaPipelines"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-558" {
  description             = ""
  display_name            = "DatabricksFeatureStore"
  name                    = "DatabricksFeatureStore"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-559" {
  description             = ""
  display_name            = "DatabricksFiles"
  name                    = "DatabricksFiles"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-560" {
  description             = ""
  display_name            = "DatabricksFilesystem"
  name                    = "DatabricksFilesystem"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-561" {
  description             = ""
  display_name            = "DatabricksGenie"
  name                    = "DatabricksGenie"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-562" {
  description             = ""
  display_name            = "DatabricksGitCredentials"
  name                    = "DatabricksGitCredentials"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-563" {
  description             = ""
  display_name            = "DatabricksGlobalInitScripts"
  name                    = "DatabricksGlobalInitScripts"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-564" {
  description             = ""
  display_name            = "DatabricksGroups"
  name                    = "DatabricksGroups"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-565" {
  description             = ""
  display_name            = "DatabricksIAMRole"
  name                    = "DatabricksIAMRole"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-566" {
  description             = ""
  display_name            = "DatabricksIngestion"
  name                    = "DatabricksIngestion"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-567" {
  description             = ""
  display_name            = "DatabricksInstancePools"
  name                    = "DatabricksInstancePools"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-568" {
  description             = ""
  display_name            = "DatabricksJobs"
  name                    = "DatabricksJobs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-569" {
  description             = ""
  display_name            = "DatabricksLakeviewConfig"
  name                    = "DatabricksLakeviewConfig"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-570" {
  description             = ""
  display_name            = "DatabricksLineageTracking"
  name                    = "DatabricksLineageTracking"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-571" {
  description             = ""
  display_name            = "DatabricksMLflowAcledArtifact"
  name                    = "DatabricksMLflowAcledArtifact"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-572" {
  description             = ""
  display_name            = "DatabricksMLflowExperiment"
  name                    = "DatabricksMLflowExperiment"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-573" {
  description             = ""
  display_name            = "DatabricksMarketplaceConsumer"
  name                    = "DatabricksMarketplaceConsumer"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-574" {
  description             = ""
  display_name            = "DatabricksMarketplaceProvider"
  name                    = "DatabricksMarketplaceProvider"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-575" {
  description             = ""
  display_name            = "DatabricksModelRegistry"
  name                    = "DatabricksModelRegistry"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-576" {
  description             = ""
  display_name            = "DatabricksNotebook"
  name                    = "DatabricksNotebook"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-577" {
  description             = ""
  display_name            = "DatabricksOnlineTables"
  name                    = "DatabricksOnlineTables"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-578" {
  description             = ""
  display_name            = "DatabricksPartnerHub"
  name                    = "DatabricksPartnerHub"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-579" {
  description             = ""
  display_name            = "DatabricksPredictiveOptimization"
  name                    = "DatabricksPredictiveOptimization"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-580" {
  description             = ""
  display_name            = "DatabricksRBAC"
  name                    = "DatabricksRBAC"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-581" {
  description             = ""
  display_name            = "DatabricksRFA"
  name                    = "DatabricksRFA"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-582" {
  description             = ""
  display_name            = "DatabricksRemoteHistoryService"
  name                    = "DatabricksRemoteHistoryService"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-583" {
  description             = ""
  display_name            = "DatabricksRepos"
  name                    = "DatabricksRepos"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-584" {
  description             = ""
  display_name            = "DatabricksSQL"
  name                    = "DatabricksSQL"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-585" {
  description             = ""
  display_name            = "DatabricksSQLPermissions"
  name                    = "DatabricksSQLPermissions"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-586" {
  description             = ""
  display_name            = "DatabricksSSH"
  name                    = "DatabricksSSH"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-587" {
  description             = ""
  display_name            = "DatabricksSecrets"
  name                    = "DatabricksSecrets"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-588" {
  description             = ""
  display_name            = "DatabricksServerlessRealTimeInference"
  name                    = "DatabricksServerlessRealTimeInference"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-589" {
  description             = ""
  display_name            = "DatabricksTables"
  name                    = "DatabricksTables"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-590" {
  description             = ""
  display_name            = "DatabricksUnityCatalog"
  name                    = "DatabricksUnityCatalog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-591" {
  description             = ""
  display_name            = "DatabricksVectorSearch"
  name                    = "DatabricksVectorSearch"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-592" {
  description             = ""
  display_name            = "DatabricksWebTerminal"
  name                    = "DatabricksWebTerminal"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-593" {
  description             = ""
  display_name            = "DatabricksWebhookNotifications"
  name                    = "DatabricksWebhookNotifications"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-594" {
  description             = ""
  display_name            = "DatabricksWorkspace"
  name                    = "DatabricksWorkspace"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-595" {
  description             = ""
  display_name            = "DatabricksWorkspaceFiles"
  name                    = "DatabricksWorkspaceFiles"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-596" {
  description             = ""
  display_name            = "DevCenterAgentHealthLogs"
  name                    = "DevCenterAgentHealthLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-597" {
  description             = ""
  display_name            = "DevCenterBillingEventLogs"
  name                    = "DevCenterBillingEventLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-598" {
  description             = ""
  display_name            = "DevCenterConnectionLogs"
  name                    = "DevCenterConnectionLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-599" {
  description             = ""
  display_name            = "DevCenterDiagnosticLogs"
  name                    = "DevCenterDiagnosticLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-600" {
  description             = ""
  display_name            = "DevCenterResourceOperationLogs"
  name                    = "DevCenterResourceOperationLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-601" {
  description             = ""
  display_name            = "DevOpsOperationsAudit"
  name                    = "DevOpsOperationsAudit"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-602" {
  description             = ""
  display_name            = "DeviceBehaviorEntities"
  name                    = "DeviceBehaviorEntities"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-603" {
  description             = ""
  display_name            = "DeviceBehaviorInfo"
  name                    = "DeviceBehaviorInfo"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-604" {
  description             = ""
  display_name            = "DeviceCustomFileEvents"
  name                    = "DeviceCustomFileEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-605" {
  description             = ""
  display_name            = "DeviceCustomImageLoadEvents"
  name                    = "DeviceCustomImageLoadEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-606" {
  description             = ""
  display_name            = "DeviceCustomNetworkEvents"
  name                    = "DeviceCustomNetworkEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-607" {
  description             = ""
  display_name            = "DeviceCustomProcessEvents"
  name                    = "DeviceCustomProcessEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-608" {
  description             = ""
  display_name            = "DeviceCustomRegistryEvents"
  name                    = "DeviceCustomRegistryEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-609" {
  description             = ""
  display_name            = "DeviceCustomScriptEvents"
  name                    = "DeviceCustomScriptEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-610" {
  description             = ""
  display_name            = "DiscoveryBookshelfAuditLogs"
  name                    = "DiscoveryBookshelfAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-611" {
  description             = ""
  display_name            = "DiscoverySupercomputerAuditLogs"
  name                    = "DiscoverySupercomputerAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-612" {
  description             = ""
  display_name            = "DiscoveryWorkspaceAuditLogs"
  name                    = "DiscoveryWorkspaceAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-613" {
  description             = ""
  display_name            = "DragonCopilot"
  name                    = "DragonCopilot"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-614" {
  description             = ""
  display_name            = "DurableTaskSchedulerLogs"
  name                    = "DurableTaskSchedulerLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-615" {
  description             = ""
  display_name            = "EGNFailedHttpDataPlaneOperations"
  name                    = "EGNFailedHttpDataPlaneOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-616" {
  description             = ""
  display_name            = "EGNFailedMqttConnections"
  name                    = "EGNFailedMqttConnections"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-617" {
  description             = ""
  display_name            = "EGNFailedMqttPublishedMessages"
  name                    = "EGNFailedMqttPublishedMessages"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-618" {
  description             = ""
  display_name            = "EGNFailedMqttSubscriptions"
  name                    = "EGNFailedMqttSubscriptions"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-619" {
  description             = ""
  display_name            = "EGNMqttDisconnections"
  name                    = "EGNMqttDisconnections"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-620" {
  description             = ""
  display_name            = "EGNSuccessfulHttpDataPlaneOperations"
  name                    = "EGNSuccessfulHttpDataPlaneOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-621" {
  description             = ""
  display_name            = "EGNSuccessfulMqttConnections"
  name                    = "EGNSuccessfulMqttConnections"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-622" {
  description             = ""
  display_name            = "ETWEvent"
  name                    = "ETWEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-623" {
  description             = ""
  display_name            = "EdgeActionConsoleLog"
  name                    = "EdgeActionConsoleLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-624" {
  description             = ""
  display_name            = "EdgeActionServiceLog"
  name                    = "EdgeActionServiceLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-625" {
  description             = ""
  display_name            = "EnrichedMicrosoft365AuditLogs"
  name                    = "EnrichedMicrosoft365AuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-626" {
  description             = ""
  display_name            = "Event"
  name                    = "Event"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-627" {
  description             = ""
  display_name            = "ExchangeAssessmentRecommendation"
  name                    = "ExchangeAssessmentRecommendation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-628" {
  description             = ""
  display_name            = "ExchangeOnlineAssessmentRecommendation"
  name                    = "ExchangeOnlineAssessmentRecommendation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-629" {
  description             = ""
  display_name            = "FailedIngestion"
  name                    = "FailedIngestion"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-630" {
  description             = ""
  display_name            = "FunctionAppLogs"
  name                    = "FunctionAppLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-631" {
  description             = ""
  display_name            = "GraphNotificationsActivityLogs"
  name                    = "GraphNotificationsActivityLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-632" {
  description             = ""
  display_name            = "HDInsightAmbariClusterAlerts"
  name                    = "HDInsightAmbariClusterAlerts"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-633" {
  description             = ""
  display_name            = "HDInsightAmbariSystemMetrics"
  name                    = "HDInsightAmbariSystemMetrics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-634" {
  description             = ""
  display_name            = "HDInsightGatewayAuditLogs"
  name                    = "HDInsightGatewayAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-635" {
  description             = ""
  display_name            = "HDInsightHBaseLogs"
  name                    = "HDInsightHBaseLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-636" {
  description             = ""
  display_name            = "HDInsightHBaseMetrics"
  name                    = "HDInsightHBaseMetrics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-637" {
  description             = ""
  display_name            = "HDInsightHadoopAndYarnLogs"
  name                    = "HDInsightHadoopAndYarnLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-638" {
  description             = ""
  display_name            = "HDInsightHadoopAndYarnMetrics"
  name                    = "HDInsightHadoopAndYarnMetrics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-639" {
  description             = ""
  display_name            = "HDInsightHiveAndLLAPLogs"
  name                    = "HDInsightHiveAndLLAPLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-640" {
  description             = ""
  display_name            = "HDInsightHiveAndLLAPMetrics"
  name                    = "HDInsightHiveAndLLAPMetrics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-641" {
  description             = ""
  display_name            = "HDInsightHiveQueryAppStats"
  name                    = "HDInsightHiveQueryAppStats"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-642" {
  description             = ""
  display_name            = "HDInsightHiveTezAppStats"
  name                    = "HDInsightHiveTezAppStats"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-643" {
  description             = ""
  display_name            = "HDInsightJupyterNotebookEvents"
  name                    = "HDInsightJupyterNotebookEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-644" {
  description             = ""
  display_name            = "HDInsightKafkaLogs"
  name                    = "HDInsightKafkaLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-645" {
  description             = ""
  display_name            = "HDInsightKafkaMetrics"
  name                    = "HDInsightKafkaMetrics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-646" {
  description             = ""
  display_name            = "HDInsightKafkaServerLog"
  name                    = "HDInsightKafkaServerLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-647" {
  description             = ""
  display_name            = "HDInsightOozieLogs"
  name                    = "HDInsightOozieLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-648" {
  description             = ""
  display_name            = "HDInsightRangerAuditLogs"
  name                    = "HDInsightRangerAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-649" {
  description             = ""
  display_name            = "HDInsightSecurityLogs"
  name                    = "HDInsightSecurityLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-650" {
  description             = ""
  display_name            = "HDInsightSparkApplicationEvents"
  name                    = "HDInsightSparkApplicationEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-651" {
  description             = ""
  display_name            = "HDInsightSparkBlockManagerEvents"
  name                    = "HDInsightSparkBlockManagerEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-652" {
  description             = ""
  display_name            = "HDInsightSparkEnvironmentEvents"
  name                    = "HDInsightSparkEnvironmentEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-653" {
  description             = ""
  display_name            = "HDInsightSparkExecutorEvents"
  name                    = "HDInsightSparkExecutorEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-654" {
  description             = ""
  display_name            = "HDInsightSparkExtraEvents"
  name                    = "HDInsightSparkExtraEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-655" {
  description             = ""
  display_name            = "HDInsightSparkJobEvents"
  name                    = "HDInsightSparkJobEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-656" {
  description             = ""
  display_name            = "HDInsightSparkLogs"
  name                    = "HDInsightSparkLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-657" {
  description             = ""
  display_name            = "HDInsightSparkSQLExecutionEvents"
  name                    = "HDInsightSparkSQLExecutionEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-658" {
  description             = ""
  display_name            = "HDInsightSparkStageEvents"
  name                    = "HDInsightSparkStageEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-659" {
  description             = ""
  display_name            = "HDInsightSparkStageTaskAccumulables"
  name                    = "HDInsightSparkStageTaskAccumulables"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-660" {
  description             = ""
  display_name            = "HDInsightSparkTaskEvents"
  name                    = "HDInsightSparkTaskEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-661" {
  description             = ""
  display_name            = "HDInsightStormLogs"
  name                    = "HDInsightStormLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-662" {
  description             = ""
  display_name            = "HDInsightStormMetrics"
  name                    = "HDInsightStormMetrics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-663" {
  description             = ""
  display_name            = "HDInsightStormTopologyMetrics"
  name                    = "HDInsightStormTopologyMetrics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-664" {
  description             = ""
  display_name            = "HealthStateChangeEvent"
  name                    = "HealthStateChangeEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-665" {
  description             = ""
  display_name            = "Heartbeat"
  name                    = "Heartbeat"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-666" {
  description             = ""
  display_name            = "InsightsMetrics"
  name                    = "InsightsMetrics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-667" {
  description             = ""
  display_name            = "IntuneAuditLogs"
  name                    = "IntuneAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-668" {
  description             = ""
  display_name            = "IntuneDeviceComplianceOrg"
  name                    = "IntuneDeviceComplianceOrg"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-669" {
  description             = ""
  display_name            = "IntuneDevices"
  name                    = "IntuneDevices"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-670" {
  description             = ""
  display_name            = "IntuneOperationalLogs"
  name                    = "IntuneOperationalLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-671" {
  description             = ""
  display_name            = "KubeEvents"
  name                    = "KubeEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-672" {
  description             = ""
  display_name            = "KubeHealth"
  name                    = "KubeHealth"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-673" {
  description             = ""
  display_name            = "KubeMonAgentEvents"
  name                    = "KubeMonAgentEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-674" {
  description             = ""
  display_name            = "KubeNodeInventory"
  name                    = "KubeNodeInventory"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-675" {
  description             = ""
  display_name            = "KubePVInventory"
  name                    = "KubePVInventory"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-676" {
  description             = ""
  display_name            = "KubePodInventory"
  name                    = "KubePodInventory"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-677" {
  description             = ""
  display_name            = "KubeServices"
  name                    = "KubeServices"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-678" {
  description             = ""
  display_name            = "LAJobLogs"
  name                    = "LAJobLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-679" {
  description             = ""
  display_name            = "LAQueryLogs"
  name                    = "LAQueryLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-680" {
  description             = ""
  display_name            = "LASummaryLogs"
  name                    = "LASummaryLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-681" {
  description             = ""
  display_name            = "LIATrackingEvents"
  name                    = "LIATrackingEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-682" {
  description             = ""
  display_name            = "LedgerTransactionLogs"
  name                    = "LedgerTransactionLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-683" {
  description             = ""
  display_name            = "LedgerUserDefinedLogs"
  name                    = "LedgerUserDefinedLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-684" {
  description             = ""
  display_name            = "LogicAppWorkflowRuntime"
  name                    = "LogicAppWorkflowRuntime"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-685" {
  description             = ""
  display_name            = "MCCEventLogs"
  name                    = "MCCEventLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-686" {
  description             = ""
  display_name            = "MCVPAuditLogs"
  name                    = "MCVPAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-687" {
  description             = ""
  display_name            = "MCVPOperationLogs"
  name                    = "MCVPOperationLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-688" {
  description             = ""
  display_name            = "MDCDetectionDNSEvents"
  name                    = "MDCDetectionDNSEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-689" {
  description             = ""
  display_name            = "MDCDetectionFimEvents"
  name                    = "MDCDetectionFimEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-690" {
  description             = ""
  display_name            = "MDCDetectionGatingValidationEvents"
  name                    = "MDCDetectionGatingValidationEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-691" {
  description             = ""
  display_name            = "MDCDetectionK8SApiEvents"
  name                    = "MDCDetectionK8SApiEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-692" {
  description             = ""
  display_name            = "MDCDetectionProcessV2Events"
  name                    = "MDCDetectionProcessV2Events"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-693" {
  description             = ""
  display_name            = "MDCFileIntegrityMonitoringEvents"
  name                    = "MDCFileIntegrityMonitoringEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-694" {
  description             = ""
  display_name            = "MDECustomCollectionDeviceFileEvents"
  name                    = "MDECustomCollectionDeviceFileEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-695" {
  description             = ""
  display_name            = "MDPResourceLog"
  name                    = "MDPResourceLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-696" {
  description             = ""
  display_name            = "MNFDeviceUpdates"
  name                    = "MNFDeviceUpdates"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-697" {
  description             = ""
  display_name            = "MNFSystemSessionHistoryUpdates"
  name                    = "MNFSystemSessionHistoryUpdates"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-698" {
  description             = ""
  display_name            = "MNFSystemStateMessageUpdates"
  name                    = "MNFSystemStateMessageUpdates"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-699" {
  description             = ""
  display_name            = "MPCAuditLogs"
  name                    = "MPCAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-700" {
  description             = ""
  display_name            = "MPCIngestionLogs"
  name                    = "MPCIngestionLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-701" {
  description             = ""
  display_name            = "MeshControlPlane"
  name                    = "MeshControlPlane"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-702" {
  description             = ""
  display_name            = "MicrosoftAzureBastionAuditLogs"
  name                    = "MicrosoftAzureBastionAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-703" {
  description             = ""
  display_name            = "MicrosoftDataShareReceivedSnapshotLog"
  name                    = "MicrosoftDataShareReceivedSnapshotLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-704" {
  description             = ""
  display_name            = "MicrosoftDataShareSentSnapshotLog"
  name                    = "MicrosoftDataShareSentSnapshotLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-705" {
  description             = ""
  display_name            = "MicrosoftDataShareShareLog"
  name                    = "MicrosoftDataShareShareLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-706" {
  description             = ""
  display_name            = "MicrosoftGraphActivityLogs"
  name                    = "MicrosoftGraphActivityLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-707" {
  description             = ""
  display_name            = "MicrosoftGraphPolicyLogs"
  name                    = "MicrosoftGraphPolicyLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-708" {
  description             = ""
  display_name            = "MicrosoftHealthcareApisAuditLogs"
  name                    = "MicrosoftHealthcareApisAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-709" {
  description             = ""
  display_name            = "MicrosoftServicePrincipalSignInLogs"
  name                    = "MicrosoftServicePrincipalSignInLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-710" {
  description             = ""
  display_name            = "MySqlAuditLogs"
  name                    = "MySqlAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-711" {
  description             = ""
  display_name            = "MySqlSlowLogs"
  name                    = "MySqlSlowLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-712" {
  description             = ""
  display_name            = "NCBMBreakGlassAuditLogs"
  name                    = "NCBMBreakGlassAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-713" {
  description             = ""
  display_name            = "NCBMSecurityDefenderLogs"
  name                    = "NCBMSecurityDefenderLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-714" {
  description             = ""
  display_name            = "NCBMSecurityLogs"
  name                    = "NCBMSecurityLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-715" {
  description             = ""
  display_name            = "NCBMSystemLogs"
  name                    = "NCBMSystemLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-716" {
  description             = ""
  display_name            = "NCCIDRACLogs"
  name                    = "NCCIDRACLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-717" {
  description             = ""
  display_name            = "NCCKubernetesAPIAuditLogs"
  name                    = "NCCKubernetesAPIAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-718" {
  description             = ""
  display_name            = "NCCKubernetesLogs"
  name                    = "NCCKubernetesLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-719" {
  description             = ""
  display_name            = "NCCPlatformOperationsLogs"
  name                    = "NCCPlatformOperationsLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-720" {
  description             = ""
  display_name            = "NCCVMOrchestrationLogs"
  name                    = "NCCVMOrchestrationLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-721" {
  description             = ""
  display_name            = "NCMClusterOperationsLogs"
  name                    = "NCMClusterOperationsLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-722" {
  description             = ""
  display_name            = "NCSStorageAlerts"
  name                    = "NCSStorageAlerts"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-723" {
  description             = ""
  display_name            = "NCSStorageAudits"
  name                    = "NCSStorageAudits"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-724" {
  description             = ""
  display_name            = "NCSStorageLogs"
  name                    = "NCSStorageLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-725" {
  description             = ""
  display_name            = "NGXOperationLogs"
  name                    = "NGXOperationLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-726" {
  description             = ""
  display_name            = "NGXSecurityLogs"
  name                    = "NGXSecurityLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-727" {
  description             = ""
  display_name            = "NSPAccessLogs"
  name                    = "NSPAccessLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-728" {
  description             = ""
  display_name            = "NTAInsights"
  name                    = "NTAInsights"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-729" {
  description             = ""
  display_name            = "NTAIpDetails"
  name                    = "NTAIpDetails"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-730" {
  description             = ""
  display_name            = "NTANetAnalytics"
  name                    = "NTANetAnalytics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-731" {
  description             = ""
  display_name            = "NTANspRuleRecommendation"
  name                    = "NTANspRuleRecommendation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-732" {
  description             = ""
  display_name            = "NTARuleRecommendation"
  name                    = "NTARuleRecommendation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-733" {
  description             = ""
  display_name            = "NTATopologyDetails"
  name                    = "NTATopologyDetails"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-734" {
  description             = ""
  display_name            = "NWConnectionMonitorDNSResult"
  name                    = "NWConnectionMonitorDNSResult"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-735" {
  description             = ""
  display_name            = "NWConnectionMonitorDestinationListenerResult"
  name                    = "NWConnectionMonitorDestinationListenerResult"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-736" {
  description             = ""
  display_name            = "NWConnectionMonitorPathResult"
  name                    = "NWConnectionMonitorPathResult"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-737" {
  description             = ""
  display_name            = "NWConnectionMonitorTestResult"
  name                    = "NWConnectionMonitorTestResult"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-738" {
  description             = ""
  display_name            = "NatGatewayFlowlogsV1"
  name                    = "NatGatewayFlowlogsV1"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-739" {
  description             = ""
  display_name            = "NetworkAccessAlerts"
  name                    = "NetworkAccessAlerts"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-740" {
  description             = ""
  display_name            = "NetworkAccessConnectionEvents"
  name                    = "NetworkAccessConnectionEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-741" {
  description             = ""
  display_name            = "NetworkAccessGenerativeAIInsights"
  name                    = "NetworkAccessGenerativeAIInsights"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-742" {
  description             = ""
  display_name            = "NetworkAccessTraffic"
  name                    = "NetworkAccessTraffic"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-743" {
  description             = ""
  display_name            = "NginxUpstreamUpdateLogs"
  name                    = "NginxUpstreamUpdateLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-744" {
  description             = ""
  display_name            = "OEPAirFlowTask"
  name                    = "OEPAirFlowTask"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-745" {
  description             = ""
  display_name            = "OEPAuditLogs"
  name                    = "OEPAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-746" {
  description             = ""
  display_name            = "OEPDataplaneLogs"
  name                    = "OEPDataplaneLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-747" {
  description             = ""
  display_name            = "OEPElasticOperator"
  name                    = "OEPElasticOperator"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-748" {
  description             = ""
  display_name            = "OEPElasticsearch"
  name                    = "OEPElasticsearch"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-749" {
  description             = ""
  display_name            = "OEWAuditLogs"
  name                    = "OEWAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-750" {
  description             = ""
  display_name            = "OEWExperimentAssignmentSummary"
  name                    = "OEWExperimentAssignmentSummary"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-751" {
  description             = ""
  display_name            = "OEWExperimentScorecardMetricPairs"
  name                    = "OEWExperimentScorecardMetricPairs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-752" {
  description             = ""
  display_name            = "OEWExperimentScorecards"
  name                    = "OEWExperimentScorecards"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-753" {
  description             = ""
  display_name            = "OGOAuditLogs"
  name                    = "OGOAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-754" {
  description             = ""
  display_name            = "OLPSupplyChainEntityOperations"
  name                    = "OLPSupplyChainEntityOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-755" {
  description             = ""
  display_name            = "OLPSupplyChainEvents"
  name                    = "OLPSupplyChainEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-756" {
  description             = ""
  display_name            = "OTelEvents"
  name                    = "OTelEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-757" {
  description             = ""
  display_name            = "OTelLogs"
  name                    = "OTelLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-758" {
  description             = ""
  display_name            = "OTelResources"
  name                    = "OTelResources"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-759" {
  description             = ""
  display_name            = "OTelSpans"
  name                    = "OTelSpans"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-760" {
  description             = ""
  display_name            = "OTelTraces"
  name                    = "OTelTraces"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-761" {
  description             = ""
  display_name            = "OTelTracesAgent"
  name                    = "OTelTracesAgent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-762" {
  description             = ""
  display_name            = "OmsCustomerProfileFact"
  name                    = "OmsCustomerProfileFact"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-763" {
  description             = ""
  display_name            = "Operation"
  name                    = "Operation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-764" {
  description             = ""
  display_name            = "OracleCloudDatabase"
  name                    = "OracleCloudDatabase"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-765" {
  description             = ""
  display_name            = "PFTitleAuditLogs"
  name                    = "PFTitleAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-766" {
  description             = ""
  display_name            = "PGSQLAutovacuumStats"
  name                    = "PGSQLAutovacuumStats"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-767" {
  description             = ""
  display_name            = "PGSQLDbTransactionsStats"
  name                    = "PGSQLDbTransactionsStats"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-768" {
  description             = ""
  display_name            = "PGSQLPgBouncer"
  name                    = "PGSQLPgBouncer"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-769" {
  description             = ""
  display_name            = "PGSQLPgStatActivitySessions"
  name                    = "PGSQLPgStatActivitySessions"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-770" {
  description             = ""
  display_name            = "PGSQLQueryStoreQueryText"
  name                    = "PGSQLQueryStoreQueryText"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-771" {
  description             = ""
  display_name            = "PGSQLQueryStoreRuntime"
  name                    = "PGSQLQueryStoreRuntime"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-772" {
  description             = ""
  display_name            = "PGSQLQueryStoreWaits"
  name                    = "PGSQLQueryStoreWaits"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-773" {
  description             = ""
  display_name            = "PGSQLServerLogs"
  name                    = "PGSQLServerLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-774" {
  description             = ""
  display_name            = "PaymentHsmHardwareOperationAuditLogs"
  name                    = "PaymentHsmHardwareOperationAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-775" {
  description             = ""
  display_name            = "Perf"
  name                    = "Perf"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-776" {
  description             = ""
  display_name            = "PerfInsightsFindings"
  name                    = "PerfInsightsFindings"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-777" {
  description             = ""
  display_name            = "PerfInsightsImpactedResources"
  name                    = "PerfInsightsImpactedResources"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-778" {
  description             = ""
  display_name            = "PerfInsightsRun"
  name                    = "PerfInsightsRun"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-779" {
  description             = ""
  display_name            = "PowerBIDatasetsTenant"
  name                    = "PowerBIDatasetsTenant"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-780" {
  description             = ""
  display_name            = "PowerBIDatasetsWorkspace"
  name                    = "PowerBIDatasetsWorkspace"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-781" {
  description             = ""
  display_name            = "PreAuthenticationDiscoveryLogs"
  name                    = "PreAuthenticationDiscoveryLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-782" {
  description             = ""
  display_name            = "PurviewDataSensitivityLogs"
  name                    = "PurviewDataSensitivityLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-783" {
  description             = ""
  display_name            = "PurviewScanStatusLogs"
  name                    = "PurviewScanStatusLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-784" {
  description             = ""
  display_name            = "PurviewSecurityLogs"
  name                    = "PurviewSecurityLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-785" {
  description             = ""
  display_name            = "QuantumProviderAccountDeviceOperationLogs"
  name                    = "QuantumProviderAccountDeviceOperationLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-786" {
  description             = ""
  display_name            = "QuantumProviderAccountJobAuditLogs"
  name                    = "QuantumProviderAccountJobAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-787" {
  description             = ""
  display_name            = "QuantumProviderAccountMessageAuditLogs"
  name                    = "QuantumProviderAccountMessageAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-788" {
  description             = ""
  display_name            = "QuantumProviderAccountQueueAuditLogs"
  name                    = "QuantumProviderAccountQueueAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-789" {
  description             = ""
  display_name            = "QuantumProviderAccountTargetAuditLogs"
  name                    = "QuantumProviderAccountTargetAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-790" {
  description             = ""
  display_name            = "QuantumWorkspaceJobAuditLogs"
  name                    = "QuantumWorkspaceJobAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-791" {
  description             = ""
  display_name            = "REDConnectionEvents"
  name                    = "REDConnectionEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-792" {
  description             = ""
  display_name            = "RemoteNetworkHealthLogs"
  name                    = "RemoteNetworkHealthLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-793" {
  description             = ""
  display_name            = "ResourceManagementPublicAccessLogs"
  name                    = "ResourceManagementPublicAccessLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-794" {
  description             = ""
  display_name            = "RetinaNetworkFlowLogs"
  name                    = "RetinaNetworkFlowLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-795" {
  description             = ""
  display_name            = "SCCMAssessmentRecommendation"
  name                    = "SCCMAssessmentRecommendation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-796" {
  description             = ""
  display_name            = "SCGPoolExecutionLog"
  name                    = "SCGPoolExecutionLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-797" {
  description             = ""
  display_name            = "SCGPoolRequestLog"
  name                    = "SCGPoolRequestLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-798" {
  description             = ""
  display_name            = "SCOMAssessmentRecommendation"
  name                    = "SCOMAssessmentRecommendation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-799" {
  description             = ""
  display_name            = "SPAssessmentRecommendation"
  name                    = "SPAssessmentRecommendation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-800" {
  description             = ""
  display_name            = "SQLAssessmentRecommendation"
  name                    = "SQLAssessmentRecommendation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-801" {
  description             = ""
  display_name            = "SQLSecurityAuditEvents"
  name                    = "SQLSecurityAuditEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-802" {
  description             = ""
  display_name            = "SVMPoolExecutionLog"
  name                    = "SVMPoolExecutionLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-803" {
  description             = ""
  display_name            = "SVMPoolRequestLog"
  name                    = "SVMPoolRequestLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-804" {
  description             = ""
  display_name            = "SecurityCaseEvent"
  name                    = "SecurityCaseEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-805" {
  description             = ""
  display_name            = "ServiceFabricOperationalEvent"
  name                    = "ServiceFabricOperationalEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-806" {
  description             = ""
  display_name            = "ServiceFabricReliableActorEvent"
  name                    = "ServiceFabricReliableActorEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-807" {
  description             = ""
  display_name            = "ServiceFabricReliableServiceEvent"
  name                    = "ServiceFabricReliableServiceEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-808" {
  description             = ""
  display_name            = "SfBAssessmentRecommendation"
  name                    = "SfBAssessmentRecommendation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-809" {
  description             = ""
  display_name            = "SfBOnlineAssessmentRecommendation"
  name                    = "SfBOnlineAssessmentRecommendation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-810" {
  description             = ""
  display_name            = "SharePointOnlineAssessmentRecommendation"
  name                    = "SharePointOnlineAssessmentRecommendation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-811" {
  description             = ""
  display_name            = "SignalRServiceDiagnosticLogs"
  name                    = "SignalRServiceDiagnosticLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-812" {
  description             = ""
  display_name            = "SigninLogs"
  name                    = "SigninLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-813" {
  description             = ""
  display_name            = "StorageAntimalwareScanResults"
  name                    = "StorageAntimalwareScanResults"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-814" {
  description             = ""
  display_name            = "StorageBlobLogs"
  name                    = "StorageBlobLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-815" {
  description             = ""
  display_name            = "StorageCacheOperationEvents"
  name                    = "StorageCacheOperationEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-816" {
  description             = ""
  display_name            = "StorageCacheUpgradeEvents"
  name                    = "StorageCacheUpgradeEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-817" {
  description             = ""
  display_name            = "StorageCacheWarningEvents"
  name                    = "StorageCacheWarningEvents"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-818" {
  description             = ""
  display_name            = "StorageFileLogs"
  name                    = "StorageFileLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-819" {
  description             = ""
  display_name            = "StorageMalwareScanningResults"
  name                    = "StorageMalwareScanningResults"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-820" {
  description             = ""
  display_name            = "StorageMoverAuditLogs"
  name                    = "StorageMoverAuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-821" {
  description             = ""
  display_name            = "StorageMoverCopyLogsFailed"
  name                    = "StorageMoverCopyLogsFailed"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-822" {
  description             = ""
  display_name            = "StorageMoverCopyLogsTransferred"
  name                    = "StorageMoverCopyLogsTransferred"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-823" {
  description             = ""
  display_name            = "StorageMoverJobRunLogs"
  name                    = "StorageMoverJobRunLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-824" {
  description             = ""
  display_name            = "StorageQueueLogs"
  name                    = "StorageQueueLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-825" {
  description             = ""
  display_name            = "StorageTableLogs"
  name                    = "StorageTableLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-826" {
  description             = ""
  display_name            = "SucceededIngestion"
  name                    = "SucceededIngestion"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-827" {
  description             = ""
  display_name            = "SynapseBigDataPoolApplicationsEnded"
  name                    = "SynapseBigDataPoolApplicationsEnded"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-828" {
  description             = ""
  display_name            = "SynapseBuiltinSqlPoolRequestsEnded"
  name                    = "SynapseBuiltinSqlPoolRequestsEnded"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-829" {
  description             = ""
  display_name            = "SynapseDXCommand"
  name                    = "SynapseDXCommand"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-830" {
  description             = ""
  display_name            = "SynapseDXFailedIngestion"
  name                    = "SynapseDXFailedIngestion"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-831" {
  description             = ""
  display_name            = "SynapseDXIngestionBatching"
  name                    = "SynapseDXIngestionBatching"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-832" {
  description             = ""
  display_name            = "SynapseDXQuery"
  name                    = "SynapseDXQuery"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-833" {
  description             = ""
  display_name            = "SynapseDXSucceededIngestion"
  name                    = "SynapseDXSucceededIngestion"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-834" {
  description             = ""
  display_name            = "SynapseDXTableDetails"
  name                    = "SynapseDXTableDetails"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-835" {
  description             = ""
  display_name            = "SynapseDXTableUsageStatistics"
  name                    = "SynapseDXTableUsageStatistics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-836" {
  description             = ""
  display_name            = "SynapseGatewayApiRequests"
  name                    = "SynapseGatewayApiRequests"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-837" {
  description             = ""
  display_name            = "SynapseIntegrationActivityRuns"
  name                    = "SynapseIntegrationActivityRuns"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-838" {
  description             = ""
  display_name            = "SynapseIntegrationPipelineRuns"
  name                    = "SynapseIntegrationPipelineRuns"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-839" {
  description             = ""
  display_name            = "SynapseIntegrationTriggerRuns"
  name                    = "SynapseIntegrationTriggerRuns"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-840" {
  description             = ""
  display_name            = "SynapseLinkEvent"
  name                    = "SynapseLinkEvent"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-841" {
  description             = ""
  display_name            = "SynapseRbacOperations"
  name                    = "SynapseRbacOperations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-842" {
  description             = ""
  display_name            = "SynapseScopePoolScopeJobsEnded"
  name                    = "SynapseScopePoolScopeJobsEnded"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-843" {
  description             = ""
  display_name            = "SynapseScopePoolScopeJobsStateChange"
  name                    = "SynapseScopePoolScopeJobsStateChange"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-844" {
  description             = ""
  display_name            = "SynapseSqlPoolDmsWorkers"
  name                    = "SynapseSqlPoolDmsWorkers"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-845" {
  description             = ""
  display_name            = "SynapseSqlPoolExecRequests"
  name                    = "SynapseSqlPoolExecRequests"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-846" {
  description             = ""
  display_name            = "SynapseSqlPoolRequestSteps"
  name                    = "SynapseSqlPoolRequestSteps"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-847" {
  description             = ""
  display_name            = "SynapseSqlPoolSqlRequests"
  name                    = "SynapseSqlPoolSqlRequests"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-848" {
  description             = ""
  display_name            = "SynapseSqlPoolWaits"
  name                    = "SynapseSqlPoolWaits"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-849" {
  description             = ""
  display_name            = "Syslog"
  name                    = "Syslog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-850" {
  description             = ""
  display_name            = "TOUserAudits"
  name                    = "TOUserAudits"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-851" {
  description             = ""
  display_name            = "TOUserDiagnostics"
  name                    = "TOUserDiagnostics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-852" {
  description             = ""
  display_name            = "TSIIngress"
  name                    = "TSIIngress"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-853" {
  description             = ""
  display_name            = "UCClient"
  name                    = "UCClient"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-854" {
  description             = ""
  display_name            = "UCClientReadinessStatus"
  name                    = "UCClientReadinessStatus"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-855" {
  description             = ""
  display_name            = "UCClientUpdateStatus"
  name                    = "UCClientUpdateStatus"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-856" {
  description             = ""
  display_name            = "UCDOAggregatedStatus"
  name                    = "UCDOAggregatedStatus"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-857" {
  description             = ""
  display_name            = "UCDOStatus"
  name                    = "UCDOStatus"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-858" {
  description             = ""
  display_name            = "UCDeviceAlert"
  name                    = "UCDeviceAlert"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-859" {
  description             = ""
  display_name            = "UCServiceUpdateStatus"
  name                    = "UCServiceUpdateStatus"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-860" {
  description             = ""
  display_name            = "UCUpdateAlert"
  name                    = "UCUpdateAlert"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-861" {
  description             = ""
  display_name            = "Usage"
  name                    = "Usage"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-862" {
  description             = ""
  display_name            = "VCoreMongoRequests"
  name                    = "VCoreMongoRequests"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-863" {
  description             = ""
  display_name            = "VIAudit"
  name                    = "VIAudit"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-864" {
  description             = ""
  display_name            = "VIIndexing"
  name                    = "VIIndexing"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-865" {
  description             = ""
  display_name            = "VMBoundPort"
  name                    = "VMBoundPort"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-866" {
  description             = ""
  display_name            = "VMComputer"
  name                    = "VMComputer"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-867" {
  description             = ""
  display_name            = "VMConnection"
  name                    = "VMConnection"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-868" {
  description             = ""
  display_name            = "VMProcess"
  name                    = "VMProcess"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-869" {
  description             = ""
  display_name            = "W3CIISLog"
  name                    = "W3CIISLog"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-870" {
  description             = ""
  display_name            = "WOUserAudits"
  name                    = "WOUserAudits"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-871" {
  description             = ""
  display_name            = "WOUserDiagnostics"
  name                    = "WOUserDiagnostics"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-872" {
  description             = ""
  display_name            = "WVDAgentHealthStatus"
  name                    = "WVDAgentHealthStatus"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-873" {
  description             = ""
  display_name            = "WVDAutoscaleEvaluationPooled"
  name                    = "WVDAutoscaleEvaluationPooled"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-874" {
  description             = ""
  display_name            = "WVDCheckpoints"
  name                    = "WVDCheckpoints"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-875" {
  description             = ""
  display_name            = "WVDConnectionGraphicsDataPreview"
  name                    = "WVDConnectionGraphicsDataPreview"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-876" {
  description             = ""
  display_name            = "WVDConnectionNetworkData"
  name                    = "WVDConnectionNetworkData"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-877" {
  description             = ""
  display_name            = "WVDConnections"
  name                    = "WVDConnections"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-878" {
  description             = ""
  display_name            = "WVDErrors"
  name                    = "WVDErrors"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-879" {
  description             = ""
  display_name            = "WVDFeeds"
  name                    = "WVDFeeds"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-880" {
  description             = ""
  display_name            = "WVDHostRegistrations"
  name                    = "WVDHostRegistrations"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-881" {
  description             = ""
  display_name            = "WVDManagement"
  name                    = "WVDManagement"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-882" {
  description             = ""
  display_name            = "WVDMultiLinkAdd"
  name                    = "WVDMultiLinkAdd"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-883" {
  description             = ""
  display_name            = "WVDSessionHostManagement"
  name                    = "WVDSessionHostManagement"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-884" {
  description             = ""
  display_name            = "WebPubSubConnectivity"
  name                    = "WebPubSubConnectivity"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-885" {
  description             = ""
  display_name            = "WebPubSubHttpRequest"
  name                    = "WebPubSubHttpRequest"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-886" {
  description             = ""
  display_name            = "WebPubSubMessaging"
  name                    = "WebPubSubMessaging"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-887" {
  description             = ""
  display_name            = "Windows365AuditLogs"
  name                    = "Windows365AuditLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-888" {
  description             = ""
  display_name            = "Windows365CheckpointLogs"
  name                    = "Windows365CheckpointLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-889" {
  description             = ""
  display_name            = "Windows365ConnectionErrorLogs"
  name                    = "Windows365ConnectionErrorLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-890" {
  description             = ""
  display_name            = "Windows365ConnectionLogs"
  name                    = "Windows365ConnectionLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-891" {
  description             = ""
  display_name            = "Windows365NetworkLogs"
  name                    = "Windows365NetworkLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-892" {
  description             = ""
  display_name            = "WindowsClientAssessmentRecommendation"
  name                    = "WindowsClientAssessmentRecommendation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-893" {
  description             = ""
  display_name            = "WindowsServerAssessmentRecommendation"
  name                    = "WindowsServerAssessmentRecommendation"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-894" {
  description             = ""
  display_name            = "WorkloadDiagnosticLogs"
  name                    = "WorkloadDiagnosticLogs"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-895" {
  description             = ""
  display_name            = "ZTSGraph"
  name                    = "ZTSGraph"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-896" {
  description             = ""
  display_name            = "ZTSJobStatus"
  name                    = "ZTSJobStatus"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-897" {
  description             = ""
  display_name            = "ZTSMetadata"
  name                    = "ZTSMetadata"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
resource "azurerm_log_analytics_workspace_table_custom_log" "res-898" {
  description             = ""
  display_name            = "ZTSRequest"
  name                    = "ZTSRequest"
  plan                    = "Analytics"
  retention_in_days       = 0
  total_retention_in_days = 0
  workspace_id            = azurerm_log_analytics_workspace.res-170.id
}
