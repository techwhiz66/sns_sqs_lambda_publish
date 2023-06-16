resource "aws_sns_topic" "my_topic" {
  name = var.topic_name
  # Add any additional SNS topic configurations here
}

output "sns_topic_arn" {
  value = aws_sns_topic.my_topic.arn
}




