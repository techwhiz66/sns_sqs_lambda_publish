# Pre-requisites 

- Make sure S3 Bucket exists to store the terraform state and update provider.tf file 
- Currently the code is implemented using AWS Credentials set locally/profile  
	- aws configure --profile default
	 			-- # Set the AWS Access Key & Secret Key 
- Make sure that the user used to execute the cide should  have the below permissions:
	- AllowSNS 
		- "sns:CreateTopic",
        - "sns:GetTopicAttributes",
        - "sns:SetTopicAttributes",
        - "sns:Subscribe",
        - "sns:Publish"
	- Allow SQS 
		- "sqs:CreateQueue",
        - "sqs:GetQueueAttributes",
        - "sqs:SetQueueAttributes"
	- Allow Lambda
		- "lambda:CreateFunction",
        - "lambda:GetFunction",
        - "lambda:UpdateFunctionCode",
        - "lambda:UpdateFunctionConfiguration",
        - "lambda:InvokeFunction"
	- Allow S3 
		- "s3:PutObject"

# Usage

- Clone the Repository to your local machine 
- Run terraform init to initiate the Terraform working directory 
- Run terraform plan to preview the resources that will be created
- Run terraform apply to create the specified resources 

# Variables

The configuration uses the following variables :

- aws_sqs_queue_name - Name of the SQS Queue 
- aws_lambda_name - Name of the Lambda 
- aws_sns_topic_name - Name of the SNS Topic 
- aws_region - AWS Region - to which the stack should belong to 

## Resources
The Terraform Configuration creates the following resources : 

- An S3 Bucket to store the Terraform State File
- An SNS Topic 
	-  A Policy set to allow SNS to Publish to SQS Queue 
- An SQS Queue
	- A Policy set to allow SQS to send Messages from SQS Queue
- A Lambda 
	- A policy set to allow to receive messages from SQS Queue 

## Cleanup
To delete the created resources, run terraform destroy 