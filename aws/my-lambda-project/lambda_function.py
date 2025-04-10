import os
import boto3

def lambda_handler(event, context):
    name = event.get('name') or event.get('queryStringParameters', {}).get('name', 'World')
    greeting = f"Hello, {name}!"

    if os.environ.get('DEBUG') == 'true':
        print(f"[DEBUG] Event: {event}")

    # Simulate writing to S3 (for integration test)
    if os.environ.get('BUCKET_NAME'):
        s3 = boto3.client('s3', region_name='us-east-1')
        s3.put_object(
            Bucket=os.environ['BUCKET_NAME'],
            Key='greeting.txt',
            Body=greeting
        )

    return {
        'statusCode': 200,
        'body': greeting
    }

