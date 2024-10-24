# outputs.tf

output "aws_account_id" {
  description = "The AWS account ID that Terraform is operating in"
  value       = data.aws_caller_identity.current.account_id
}

output "aws_user_arn" {
  description = "The AWS IAM User ARN"
  value       = data.aws_caller_identity.current.arn
}
