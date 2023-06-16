
variable "main_tags" {
  type = map(string)
}

# Create SQS Queue 
resource "aws_sqs_queue" "my_queue" {
  name                      = var.queue_name
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 345600
  visibility_timeout_seconds = 30
  # Add any additional SQS queue configurations here
    tags = merge(
    var.main_tags,
    {
      "component" = "aws_sqs_queue"
    }
  )
}

output "sqs_queue_url" {
  value = aws_sqs_queue.my_queue.id
}

output "sqs_queue_arn" {
  value = aws_sqs_queue.my_queue.arn
}



