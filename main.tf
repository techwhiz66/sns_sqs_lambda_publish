
module "my_sqs_queue" {
  source      = "./sqs"
  queue_name  = "${var.aws_sqs_queue_name}"
  main_tags =  var.main_tags
}

module "my_sqs_iam_role" {
  source      = "./sqs/sqs_iam_role"
  queue_url = module.my_sqs_queue.sqs_queue_url
  queue_arn = module.my_sqs_queue.sqs_queue_arn
  sns_topic_arn = module.my_sns_topic.sns_topic_arn
}

module "my_sns_topic" {
  source      = "./sns"
  topic_name  = "${var.aws_sns_topic_name}"
  main_tags = var.main_tags
}

module "my_sns_iam_role" {
  source      = "./sns/sns_iam_role"
  sns_topic_arn = module.my_sns_topic.sns_topic_arn
  queue_url = module.my_sqs_queue.sqs_queue_url
  queue_arn = module.my_sqs_queue.sqs_queue_arn

}

resource "aws_sns_topic_subscription" "my_subscription" {
  topic_arn = module.my_sns_topic.sns_topic_arn
  protocol  = "sqs"
  endpoint = module.my_sqs_queue.sqs_queue_arn
}

module "my_lambda" {
  source      = "./lambda"
  aws_lambda_name = var.aws_lambda_name
  main_tags =  var.main_tags
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = module.my_sqs_queue.sqs_queue_arn
  function_name    = module.my_lambda.lambda_arn
  batch_size       = 1
}





