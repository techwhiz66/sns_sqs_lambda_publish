variable "main_tags" {
  type = map(string)
}



# Create SNS Topic 

resource "aws_sns_topic" "my_topic" {
  name = var.topic_name
  # Add any additional SNS topic configurations here
  tags = merge(
    var.main_tags,
    {
      "component" = "aws_sns_topic"
    }
  )
}

output "sns_topic_arn" {
  value = aws_sns_topic.my_topic.arn
}




