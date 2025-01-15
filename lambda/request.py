import json
from urllib import parse 


class Request:
    def __init__(self, event, context, cursor):
        self.event = event
        self.context = context
        self.cursor = cursor
        self.http_method = event.get('httpMethod', 'GET')
        self.path = event.get('path').replace('/api', '').lower()
        self.path_parts = [p for p in self.path.split('/') if p]
        self.route = '/' + self.path_parts[0]
        self.endpoint = '/' + self.path_parts[-1]
        self.query = parse.unquote_plus(event.queryStringParameters.get('query', ''))

        print('path_parts:', self.path_parts, 'route:', self.route, 'endpoint:', self.endpoint) 
            
        self.headers = event.get('headers', {})
        self.user_dn = self.headers.get('subject-dn', self.headers.get('X-SSL-Client-S-DN', ''))
        self.parameters = event.get('queryStringParameters', {})
        # data = json.loads(body) if (body := event.get('body')) in ['{', '['] else body
        self.is_b64_encoded = event.get('isBase64Encoded', False)
        self.data = json.loads(body) if (body := event.get('body')) and self.headers.get('content-type') == 'application/json' else body
        

    def is_post_req_with_empty_body(self):
        print('checking empty post body')
        return self.http_method == 'POST' and not self.body
