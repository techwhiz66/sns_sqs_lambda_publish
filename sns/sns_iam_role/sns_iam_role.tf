variable "sns_topic_arn" {
  description = "ARN  of the SNS Topic "
}

variable "queue_arn" {
  description = "ARN of the SQS queue"
}

variable "queue_url" {
  description = "URL of the SQS queue"
}


resource "aws_sqs_queue_policy" "sns_to_sqs_policy" {
  #arn = "${var.sns_topic_arn}"
  queue_url = var.queue_url
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowSQSPublish",
      "Effect": "Allow",
      "Principal": {
        "Service": "sns.amazonaws.com"
      },
      "Action": "sqs:SendMessage",
       "Resource": "${var.queue_arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${var.sns_topic_arn}"
        }
      }
    }
  ]
}
EOF
}

