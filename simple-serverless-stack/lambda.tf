resource "aws_lambda_function" "time" {
  function_name = "time-function"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "time_function.lambda_handler"
  runtime       = "python3.12"
  filename      = data.archive_file.lambda_zip.output_path

  memory_size = 128
  timeout     = 5
}