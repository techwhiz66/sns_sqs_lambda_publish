variable "queue_url" {
  description = "URL of the SQS queue"
}

variable "queue_arn" {
  description = "ARN of the SQS queue"
}

variable "sns_topic_arn" {
  description = "ARN  of the SNS Topic "
}

resource "aws_iam_role" "sqs_role" {
 name   = "Role_Test_AWS_SQS_STSAssume"
 assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "sqs.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "SQSSTSAssumeRole"
    }
  ]
}
EOF
}

# Create SQS Resource Policy to allow SNS To Send MEssage to SQS Queue 
resource "aws_sqs_queue_policy" "iam_policy_for_sqs" {
  queue_url = "${var.queue_url}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowSNSToSendMessageToSQS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["sqs:SendMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes"],
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