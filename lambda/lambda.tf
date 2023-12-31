variable "aws_lambda_name" {
  type = string
}

variable "main_tags" {
  type = map(string)
}



# Create AWS IAM Role to assume Lambda
resource "aws_iam_role" "lambda_role" {
 name   = "terraform_aws_lambda_role"
 assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# IAM policy for logging from a lambda

resource "aws_iam_policy" "iam_policy_for_lambda" {

  name         = "aws_iam_policy_for_terraform_aws_lambda_role"
  path         = "/"
  description  = "AWS IAM Policy for managing aws lambda role"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# IAM policy for receiving message from SQS
resource "aws_iam_policy" "iam_policy_for_receive_sqs_msg" {

  name         = "aws_iam_policy_for_terraform_aws_receive_sqs_role"
  path         = "/"
  description  = "AWS IAM Policy for managing aws receive sqs role"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "sqs:ChangeMessageVisibility"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

# Policy Attachment on the role.

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role        = aws_iam_role.lambda_role.name
  policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}

# Policy Attachment on the role.

resource "aws_iam_role_policy_attachment" "attach_iam_sqs_receive_policy_to_iam_role" {
  role        = aws_iam_role.lambda_role.name
  policy_arn  = aws_iam_policy.iam_policy_for_receive_sqs_msg.arn
}



# Generates an archive from content, a file, or a directory of files.

data "archive_file" "zip_the_python_code" {
 type        = "zip"
 source_dir  = "${path.module}/python/"
 output_path = "${path.module}/python/lambda_function.zip"
}


# Create a lambda function
# In terraform ${path.module} is the current directory.
resource "aws_lambda_function" "terraform_lambda_func" {
 filename                       = "${path.module}/python/lambda_function.zip"
 function_name                  = "${var.aws_lambda_name}"
 role                           = aws_iam_role.lambda_role.arn
 handler                        = "lambda_function.lambda_handler"
 runtime                        = "python3.8"
 depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]

   tags = merge(
    var.main_tags,
    {
      "component" = "aws_lambda_fn"
    }
  )

}

# Create AWS Cloudwatch Log Group 
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.aws_lambda_name}"
  retention_in_days = 30
}


output "lambda_arn" {
  value = aws_lambda_function.terraform_lambda_func.arn
}