variable "queue_url" {
  description = "URL of the SQS queue"
}

variable "queue_arn" {
  description = "ARN of the SQS queue"
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

# IAM policy for logging from a lambda


resource "aws_sqs_queue_policy" "iam_policy_for_sqs" {
  queue_url = "${var.queue_url}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowSNSToSQS",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
       "Resource": "${var.queue_arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${var.queue_url}"
        }
      }
    }
  ]
}
EOF
}