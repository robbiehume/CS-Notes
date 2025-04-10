import os
import boto3
from moto import mock_aws
from lambda_function import lambda_handler

@mock_aws
def test_lambda_s3_integration():
    os.environ['BUCKET_NAME'] = 'test-bucket'
    os.environ['DEBUG'] = 'false'

    # Create mock S3 bucket
    s3 = boto3.client('s3', region_name='us-east-1')
    s3.create_bucket(Bucket='test-bucket')

    event = {
        'queryStringParameters': {
            'name': 'Charlie'
        }
    }

    response = lambda_handler(event, None)

    # Verify S3 object was created
    obj = s3.get_object(Bucket='test-bucket', Key='greeting.txt')
    body = obj['Body'].read().decode()

    assert response['statusCode'] == 200
    assert 'Charlie' in body

