resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "kaugm-testing-bucket-sdfkj3248g"
}

resource "aws_s3_bucket_ownership_controls" "lambda_bucket" {
  bucket = aws_s3_bucket.lambda_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "lambda_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.lambda_bucket]

  bucket = aws_s3_bucket.lambda_bucket.id
  acl    = "private"
}


resource "aws_lambda_function" "hello_world" {
  function_name = "HelloWorld"

  runtime = "nodejs20.x"
  handler = "hello.handler"

  environment {
    variables = {
      ENV_VAR_1 = "useast1PRODweblearn-terraform-functions-externally-randomly-loving-sheep"
      ENV_VAR_2 = "TESTING123"
    }
  }

  filename         = "${path.module}/lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda.zip")

  role = aws_iam_role.lambda_exec.arn

  # CLOUD TO CODE TESTING: MODIFY LAMBDA MEMORY_SIZE AND TIMEOUT ATTRIBUTES
  memory_size = 512
  timeout     = 15
}

resource "aws_cloudwatch_log_group" "hello_world" {
  name = "/aws/lambda/${aws_lambda_function.hello_world.function_name}"

  retention_in_days = 30
}

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
