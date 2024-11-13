import utilities

def query_db(cursor, query):
    try:
        cursor.execute("""SELECT * FROM test_table WHERE val LIKE %(query)s """, {'query': query})
        result_records = utilities.getJSONData(cursor)
        return utilities.createResponse({'results': result_records})
        
    except Exception as e:
        print(traceback.format_exc())
        return utilities.createError(HTTPStatus.INTERNAL_SERVER_ERROR, "Error querying database")
