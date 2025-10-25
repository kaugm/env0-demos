resource "aws_lambda_function" "time" {
  function_name = "time-function"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "time_function.lambda_handler"
  runtime       = "python3.12"
  filename      = data.archive_file.lambda_zip.output_path

  memory_size = 512
  timeout     = 5

  environment {
    variables = {
      NEW_VAR_TESTING = "DRIFT"
    }
  }
}