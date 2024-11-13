import pymysql
import json, os, base64
import traceback
from urllib import parse 
from http import HTTPStatus  
import utilities


#database values set in create_connection() function
server = ''
username = ''
password = ''
database_name = ''

# email to send when a new submission is submitted 
submission_email = ''

#create connection (done in create_connection())
#   - create this outside the handler definition so that it is reused.
#   - if you create it in the handler then a new connection is created everytime the handler is called
#   - since the connection variable is global it is reused on subsiquent calls, we do not close the connection. 
#       It should close after the lambda is destroyed
connection = ''


def lambda_handler(event, context):
    # Only create connection if server isn't already set, i.e. lambda is on it's first run 
    if (server == ''):
        create_connection(context) 
        
    # get the cursor because you cannot pass a paramaterized string to the createJSONData function
    cursor = connection.cursor() 
        
    print('EVENT: ', json.dumps(event))
    print('CONTEXT: ', context)

    queryStringParameters = event.get('queryStringParameters')
    path = event.get('path')
    headers = event['headers']
    query = parse.unquote_plus(queryStringParameters.get('query', ''))

    elif 'test' in path:
        return test_controller.query_db(cursor, query) 
    else:
        return utilities.createError(HTTPStatus.BAD_REQUEST, "Not a valid path")

def create_connection(context):
    global server, username, password, database_name, connection,  submission_email
    # environment variable database values
    username = os.environ.get('user')
    password = os.environ.get('pwd')
    database_name = os.environ.get('database')

    # $LATEST is only used by development and Stage.  Production MUST utilize an Alias that is set to a specific version number
    if (context.function_version == '$LATEST'):
        server = os.environ.get('db_stg')
        submission_email = os.environ.get('email_stg')
    else:
        server = os.environ.get('db_prod')
        submission_email = os.environ.get('email_prod')

    #create connection 
    #   - create this outside the handler definition so that it is reused.
    #   - if you create it in the handler then a new connection is created everytime the handler is called
    #   - since the connection is opened outside the handler and is reused on subsiquent calls we do not close the connect.
    #       It should close after the lambda is destroyed
    connection = pymysql.connect(host=server, user=username, passwd=password, db=database_name)
    connection.autocommit(True) # without this query results are cached, so if you add a record to the database and then select all, 
        # you will not see the latest insert until the lambda is destroyed and a new connection is created
