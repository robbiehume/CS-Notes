import json, os, urllib3
import uuid, hashlib
import smtplib
from urllib.error import *
from urllib.request import urlopen
# from url_normalize import url_normalize
# from jinja2 import Environment, FileSystemLoader
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

def createError(error_number:int, message:str, headers={}):
    error = {}
    error['error'] = error_number
    error['message'] = message
    return createResponse(error, headers, error_number)


def createResponse(jsonData, headers={}, status_code=200):
    response_object = {}

    if 'error' in jsonData and status_code != 200:
        response_object['statusCode'] = jsonData['error']
        response_object['body'] = jsonData['message']
    elif type(jsonData) in [dict, list]:
        response_object['statusCode'] = status_code
        response_object['body'] = json.dumps(jsonData, indent=4, sort_keys=True, default=str)
        response_object['headers'] = headers
        response_object['headers']['Content-Type'] = 'application/json'
        return response_object
    else:
        response_object['statusCode'] = status_code
        response_object['body'] = jsonData
        
    response_object['headers'] = headers
    response_object['headers']['Content-Type'] = 'text/javascript;charset=UTF-8'

    return response_object
    
    
def is_2xx_resp(resp):
    status = resp.status_code if hasattr(resp, 'status_code') else resp.status
    return True if 200 <= status <= 299 else False


def send_email(message, subject, recipient_email):
    from email.mime.text import MIMEText

    sender_email = os.environ.get('Sender_Email')
    
    email = MIMEText(message)
    email['Subject'] = subject
    email['From'] = sender_email
    email['To'] = recipient_email

    print([sender_email, recipient_email, email.as_string()])
    smtp = smtplib.SMTP(os.environ.get('SMTP_Server'))
    smtp.sendmail(sender_email, recipient_email, email.as_string())
    smtp.close()


def getJSONData(cursor):
    rowHeaders = [x[0] for x in cursor.description] 
    rows = cursor.fetchall()
    results = []
    for row in rows:
        results.append(dict(zip(rowHeaders, row)))

    return results


def get_all_rows_from_table(cursor, table):
    cursor.execute(f'SELECT * from {table}')
    return getJSONData(cursor)

    return createResponse({ 'status': 'Email process complete' })
    
