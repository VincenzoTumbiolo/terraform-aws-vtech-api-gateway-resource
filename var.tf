# Input of module

variable "api_gateway_rest_api_id" {
  description = "rest api_gateway_rest_api_id"
}
variable "api_gateway_root_resource_id" {
  description = "rest api_gateway_root_resource_id"
}
variable "path_part" {
  description = "path_part api"
}
variable "aws_iam_role_cloudwatch_arn" {
  description = "aws_iam_role_cloudwatch_arn api"
}

variable "options" {
  default = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS,GET,PUT,PATCH,DELETE'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}
