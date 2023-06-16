variable "sns_topic_arn" {
  description = "ARN  of the SNS Topic "
}

variable "queue_arn" {
  description = "ARN of the SQS queue"
}

variable "queue_url" {
  description = "URL of the SQS queue"
}


# Create SNS Topic Policy to allow SNS To publish to SQS Queue 
resource "aws_sns_topic_policy" "sns_to_sqs_policy" {
  arn = var.sns_topic_arn
  #queue_url = var.queue_url
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowSNSToPublishToSQS",
      "Effect": "Allow",
      "Principal": {
        "Service": "sns.amazonaws.com"
      },
      "Action": "sns:Publish",
       "Resource": "${var.sns_topic_arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${var.queue_arn}"
        }
      }
    }
  ]
}
EOF
}

