############################
## main.tf Variables ##
############################

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

############################
## sns.tf Variables ##
############################

variable "aws_sns_topic_name" {
  type    = string
  default = "test-sns-topic-name"
}

############################
## sqs.tf Variables ##
############################

variable "aws_sqs_queue_name" {
  type    = string
  default = "test-sqs-queue-name"
}

############################
## lambda.tf Variables ##
############################

variable "aws_lambda_name" {
  type    = string
  default = "test-lambda"
}

variable "main_tags" {
  type = map(string)
  default     = {
      "product" = "sns_sqs_lambda"
      "owner" = "techwhiz"
      "environment" = "dev"
  }
  description = "Main resource tags"
}
