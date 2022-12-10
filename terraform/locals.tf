resource "random_string" "random" {
  length           = 8
  special          = false
  min_lower        = 8
}

locals {
    #site_pages
    site_pages = ["index", "register", "login", "logout", "dashboard"]

    #aws_api_gateway_rest_api
    project_name = "alanredfordhayes__${random_string.random.result}" 
    aws_api_gateway_rest_api__api_1__name = "${local.project_name}__api_1"
    aws_api_gateway_rest_api__api_1__endpoint_configuration = ["REGIONAL"]

    #aws_api_gateway_resource
}