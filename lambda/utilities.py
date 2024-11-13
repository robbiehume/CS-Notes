import json, os, urllib3
import smtplib
import lambda_function


def createError(errorNumber:int, message:str):
    error = {}
    error['error'] = errorNumber
    error['message'] = message
    return createResponse(error)


def getJSONData(cursor):
    rowHeaders = [x[0] for x in cursor.description] 
    rows = cursor.fetchall()
    results = []
    for row in rows:
        results.append(dict(zip(rowHeaders, row)))

    return results


def createResponse(jsonData, headers={}):
    responseObject = {}
    if ('error' in jsonData):
        responseObject['statusCode'] = jsonData['error']
        responseObject['body'] = jsonData['message']
    else:
        responseObject['statusCode'] = 200

    responseObject['headers'] = headers
    responseObject['headers']['Content-Type'] = 'application/json'
    responseObject['body'] = json.dumps(jsonData, indent=4, sort_keys=True, default=str)
    
    return responseObject

def send_email(cursor, recipient_email):
    from email.mime.text import MIMEText

    sender_email = os.environ.get('Sender_Email')
    
    message = 'sample email'

    email = MIMEText(message)
    email['Subject'] = 'Test'
    email['From'] = sender_email
    email['To'] = recipient_email

    print([sender_email, recipient_email, email.as_string()])
    smtp = smtplib.SMTP(os.environ.get('SMTP_Server'))
    smtp.sendmail(sender_email, recipient_email, email.as_string())
    smtp.close()

    return createResponse({ 'status': 'Email process complete' })
    
