variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_sns_topic_name" {
  type    = string
  default = "test-sns-topic-name"
}

variable "aws_sqs_queue_name" {
  type    = string
  default = "test-sqs-queue-name"
}

variable "aws_lambda_name" {
  type    = string
  default = "test-lambda"
}


