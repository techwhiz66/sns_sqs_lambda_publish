output "topic_arn" {
  value       = aws_sns_topic.my_topic.arn
  description = "ARN of the created SNS topic"
}