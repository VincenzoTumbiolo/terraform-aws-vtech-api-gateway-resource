resource "aws_api_gateway_resource" "resource" {
  rest_api_id = var.api_gateway_rest_api_id
  parent_id   = var.api_gateway_root_resource_id
  path_part   = var.path_part
}

resource "aws_api_gateway_account" "account" {
  cloudwatch_role_arn = var.aws_iam_role_cloudwatch_arn
}
resource "aws_api_gateway_method" "ResourceOptions" {
  rest_api_id   = var.api_gateway_rest_api_id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "ResourceOptionsIntegration" {
  rest_api_id = var.api_gateway_rest_api_id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.ResourceOptions.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" = <<PARAMS
{ "statusCode": 200 }
PARAMS
  }
}

resource "aws_api_gateway_integration_response" "ResourceOptionsIntegrationResponse" {
  depends_on          = [aws_api_gateway_integration.ResourceOptionsIntegration]
  rest_api_id         = var.api_gateway_rest_api_id
  resource_id         = aws_api_gateway_resource.resource.id
  http_method         = aws_api_gateway_method.ResourceOptions.http_method
  status_code         = "200"
  response_parameters = var.options
}

resource "aws_api_gateway_method_response" "ResourceOptions200" {
  depends_on      = [aws_api_gateway_method.ResourceOptions]
  rest_api_id     = var.api_gateway_rest_api_id
  resource_id     = aws_api_gateway_resource.resource.id
  http_method     = "OPTIONS"
  status_code     = "200"
  response_models = { "application/json" = "Empty" }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}
