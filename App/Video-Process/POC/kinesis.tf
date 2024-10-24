resource "aws_kinesis_video_stream" "video_stream" {
  name                    = var.kinesis_stream_name
  data_retention_in_hours  = 24
}
