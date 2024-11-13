from waitress import serve
from flask import Flask, Response, request

port = sys.argv[1] if len(sys.argv) == 2 else 5000
app = Flask(__name__.split('.')[0])

log = logging.getLogger('waitress')
log.setLevel(logging.ERROR)

logging.basicConfig(
    level=logging.INFO,
    format='{%(message)s}',
    datefmt='%Y-%m-%dT%H:%M:%S%z',
    filename='/logs/output.log'
)

def log_and_return(resp_obj):
    """ Take in the response object that will be sent back and get the info needed to log
        Then return the response object so it gets propogated back up and sent back to the client
    """

    timestamp = datetime.now(tz=timezone.utc).strftime('%Y-%m-%dT%H:%M:%S+00:00')
    user_id = request.headers.get('X-User-ID', request.headers.get('X-SSL-Client-S-DN'))
    service = request.headers.get('X-Service', '')
    uri = request.headers.get('X-Original-URI', '')
    logging.info(f"'timestamp': '{timestamp}', 'user_id': '{user_id}', 'service': '{service}', 'uri': '{uri}', 'auth_decision': '{resp_obj.status}'")
    return resp_obj


def print_debug(*args, **kwargs):
    if DEBUG == True:
        print(' '.join(map(str,args)), **kwargs, flush=True)


@app.before_request
def before_request():
    global ALB_URL
    ALB_URL = request.headers.get('target-host')


@app.route('/')
def main():
    return render_template('index.html')


@app.route('/auth', methods=['GET', 'POST'])
def auth():
    headers = request.headers
    service = headers.get('X-Service')
    uri = headers.get('X-Original-Uri')
    print_debug('HEADERS:', request.headers)

  try:
      auth_info = parse_info(headers)
      return log_and_return(check_authorization(auth_info, request.headers.get('X-Service')))
  except (urllib3.exceptions.HTTPError, urllib3.exceptions.TimeoutError, urllib3.exceptions.MaxRetryError) as err:
      return log_and_return(Response(status=HTTPStatus.SERVICE_UNAVAILABLE, headers={HEADER_AUTH_MESSAGE: 'Internal Server Error'}))


@app.route('/upload', methods = ['POST'])
def upload():
  # add upload code


if __name__ == '__main__':
    print('Starting Flask with Waitress...')
    serve(app, host='127.0.0.1', port=port, threads=64)
