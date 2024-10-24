resource "aws_dynamodb_table" "video_metadata" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  attribute {
    name = "camera_id"
    type = "S"
  }

  tags = {
    Name = "VideoMetadataTable"
  }
}
