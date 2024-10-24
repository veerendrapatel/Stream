variable "aws_profile" {
  description = "The AWS profile to use"
  type        = string
  default     = "442426871965_AdministratorAccess"  # You can set a default profile or leave it empty
}
variable "region" {
  description = "AWS Region"
  default     = "eu-north-1"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "video-analysis-bucket"
}

variable "kinesis_stream_name" {
  description = "Name of the Kinesis video stream"
  type        = string
  default     = "exhibition-video-stream"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "video_metadata"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "video_processor"
}

variable "lambda_memory_size" {
  description = "Memory size for the Lambda function"
  type        = number
  default     = 1024
}

variable "lambda_timeout" {
  description = "Timeout for the Lambda function (in seconds)"
  type        = number
  default     = 60
}

variable "lambda_zip_file" {
  description = "Path to the Lambda deployment package zip file"
  type        = string
  default     = "path/to/your/lambda_function.zip"
}

variable "s3_full_access_policy_arn" {
  description = "ARN for AmazonS3FullAccess policy"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

variable "kinesis_full_access_policy_arn" {
  description = "ARN for AmazonKinesisFullAccess policy"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonKinesisFullAccess"
}

variable "dynamodb_full_access_policy_arn" {
  description = "ARN for AmazonDynamoDBFullAccess policy"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

variable "lambda_basic_execution_policy_arn" {
  description = "ARN for AWSLambdaBasicExecutionRole policy"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
