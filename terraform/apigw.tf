resource "aws_api_gateway_rest_api" "api_1" {
  name = local.aws_api_gateway_rest_api__api_1__name
  endpoint_configuration { types = local.aws_api_gateway_rest_api__api_1__endpoint_configuration }
}

resource "aws_api_gateway_resource" "slack_bot" {
  for_each    = toset(local.site_pages)
  parent_id   = aws_api_gateway_rest_api.api_1.root_resource_id
  path_part   = each.value
  rest_api_id = aws_api_gateway_rest_api.api_1.id
}