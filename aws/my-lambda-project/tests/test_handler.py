import os
import pytest
from lambda_function import lambda_handler

@pytest.fixture
def mock_event():
    return {
        'queryStringParameters': {
            'name': 'TestUser'
        }
    }

def test_lambda_handler_returns_200(mock_event):
    os.environ['DEBUG'] = 'true'
    response = lambda_handler(mock_event, None)

    assert response['statusCode'] == 200
    assert 'TestUser' in response['body']

