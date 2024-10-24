resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_s3_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = var.s3_full_access_policy_arn
}

resource "aws_iam_role_policy_attachment" "lambda_kinesis_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = var.kinesis_full_access_policy_arn
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = var.dynamodb_full_access_policy_arn
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = var.lambda_basic_execution_policy_arn
}

resource "aws_lambda_function" "video_processor_lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  filename         = var.lambda_zip_file
  source_code_hash = filebase64sha256(var.lambda_zip_file)

  environment {
    variables = {
      S3_BUCKET    = aws_s3_bucket.video_bucket.bucket
      DYNAMO_TABLE = aws_dynamodb_table.video_metadata.name
    }
  }

  memory_size = var.lambda_memory_size
  timeout     = var.lambda_timeout
}

resource "aws_lambda_permission" "allow_kinesis" {
  statement_id  = "AllowExecutionFromKinesis"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.video_processor_lambda.function_name
  principal     = "kinesis.amazonaws.com"
  source_arn    = aws_kinesis_video_stream.video_stream.arn
}

resource "aws_lambda_event_source_mapping" "kinesis_lambda_trigger" {
  event_source_arn = aws_kinesis_video_stream.video_stream.arn
  function_name    = aws_lambda_function.video_processor_lambda.arn
  batch_size       = 10
  starting_position = "LATEST"
}
