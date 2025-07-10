output "api_gateway_invoke_url" {
  value = "${aws_apigatewayv2_api.api.api_endpoint}/time"
}

output "lambda_memory_size" {
  value = aws_lambda_function.time.memory_size
}

output "lambda_timeout" {
  value = aws_lambda_function.time.timeout
}

