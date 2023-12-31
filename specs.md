## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_my_lambda"></a> [my\_lambda](#module\_my\_lambda) | ./lambda | n/a |
| <a name="module_my_sns_iam_role"></a> [my\_sns\_iam\_role](#module\_my\_sns\_iam\_role) | ./sns/sns_iam_role | n/a |
| <a name="module_my_sns_topic"></a> [my\_sns\_topic](#module\_my\_sns\_topic) | ./sns | n/a |
| <a name="module_my_sqs_iam_role"></a> [my\_sqs\_iam\_role](#module\_my\_sqs\_iam\_role) | ./sqs/sqs_iam_role | n/a |
| <a name="module_my_sqs_queue"></a> [my\_sqs\_queue](#module\_my\_sqs\_queue) | ./sqs | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_lambda_event_source_mapping.sqs_trigger](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping) | resource |
| [aws_sns_topic_subscription.my_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_lambda_name"></a> [aws\_lambda\_name](#input\_aws\_lambda\_name) | n/a | `string` | `"test-lambda"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | `"us-east-1"` | no |
| <a name="input_aws_sns_topic_name"></a> [aws\_sns\_topic\_name](#input\_aws\_sns\_topic\_name) | n/a | `string` | `"test-sns-topic-name"` | no |
| <a name="input_aws_sqs_queue_name"></a> [aws\_sqs\_queue\_name](#input\_aws\_sqs\_queue\_name) | n/a | `string` | `"test-sqs-queue-name"` | no |

## Outputs

No outputs.
