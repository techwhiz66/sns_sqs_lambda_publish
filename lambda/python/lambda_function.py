import json

def lambda_handler(event, context):
    # Your Lambda function logic here
    print("The Event : ",event['Records'][0]['body'])
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
