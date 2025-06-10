# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      hashicorp-learn = "lambda-api-gateway"
    }
  }

}

resource "random_pet" "lambda_bucket_name" {
  prefix = "learn-terraform-functions"
  length = 4
}


module "lambda_function" {
  source = "./modules/handler"

  # CLOUD TO CODE DEMO: MODIFY VARIABLES
  memory_size = var.lambda_memory_size
  timeout     = var.lambda_timeout

  # CLOUD TO CODE DEMO: MODIFY STRING WITH FUNCTIONS AND INTERPOLATION
  environment_variables = {
    ENV_VAR_1 = "${replace(var.aws_region, "-", "")}${var.env}${var.app_tier}${random_pet.lambda_bucket_name.id}"
    ENV_VAR_2 = upper("TESTING")
  }
}


resource "aws_apigatewayv2_api" "lambda" {

  name          = "${replace(var.aws_region, "-", "")}${var.env}${var.app_tier}${random_pet.lambda_bucket_name.id}"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "lambda" {
  api_id = aws_apigatewayv2_api.lambda.id

  name        = "serverless_lambda_stage"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_apigatewayv2_integration" "hello_world" {
  api_id = aws_apigatewayv2_api.lambda.id

  integration_uri    = module.lambda_function.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "hello_world" {
  api_id = aws_apigatewayv2_api.lambda.id

  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.hello_world.id}"
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/env0kaugmcloudtocodetesting"

  retention_in_days = 30
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.lambda.execution_arn}/*/*"
}