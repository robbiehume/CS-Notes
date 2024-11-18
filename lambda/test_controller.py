import utilities
import traceback

def handle_test(path, headers, data, parameters, cursor, query):
    routes = {
        '/query':  lambda: handle_query(cursor, query),
        '/test':   lambda: handle_test(cursor),
        '/insert': lambda: handle_insert(cursor)
    }

    try:
        return routes.get(path, lambda: None)()
    except:
        print(traceback.format_exc())
        return utilities.createError(HTTPStatus.BAD_REQUEST, 'Not a valid endpoint')


def query_db(cursor, query):
    try:
        cursor.execute("""SELECT * FROM test_table WHERE val LIKE %(query)s """, {'query': query})
        result_records = utilities.getJSONData(cursor)
        return utilities.createResponse({'results': result_records})
        
    except Exception as e:
        print(traceback.format_exc())
        return utilities.createError(HTTPStatus.INTERNAL_SERVER_ERROR, "Error querying database")
