from typing import Callable, Dict, Any, Optional, List
from request import Request
import json
import re
import traceback


class Route:
    def __init__(self, method: str, path_pattern: str, handler: Callable[..., Any]) -> None:
        """Initialize a route for a given HTTP method and path pattern."""
        self.method = method.upper()
        self.regex = self._pattern_to_regex(path_pattern)
        self.handler = handler

    def _pattern_to_regex(self, pattern: str) -> re.Pattern:
        """
        Convert a path pattern with {param} segments into a regex pattern with named groups.
        Escapes static parts and allows an optional trailing slash.
        """
        escaped_pattern = re.escape(pattern)
        escaped_pattern = escaped_pattern.replace(r'\{', '{').replace(r'\}', '}')
        regex = re.sub(r'{([^}]+)}', r'(?P<\1>[^/]+)', escaped_pattern)
        return re.compile('^' + regex.rstrip('/') + '/?$')

    def match(self, method: str, path: str) -> Optional[Dict[str, Any]]:
        """
        Attempt to match the given HTTP method and path with this route.
        Returns a dictionary of path parameters if matched, or None otherwise.
        """
        if self.method != method:
            return None
        normalized_path = path if path == '/' else path.rstrip('/')
        match = self.regex.match(normalized_path)
        if not match:
            return None
        return match.groupdict()


class Router:
    def __init__(self) -> None:
        """
        Initialize the Router with a dictionary organizing routes by HTTP method
        for more efficient lookups.
        """
        self.routes_by_method: Dict[str, List[Route]] = {}

    def route(self, method: str, path_pattern: str) -> Callable[[Callable[..., Any]], Callable[..., Any]]:
        """
        Decorator to register a route for a specific HTTP method and path pattern.
        Raises an error if a duplicate route is detected.
        """
        def decorator(func: Callable[..., Any]) -> Callable[..., Any]:
            method_upper = method.upper()
            existing_routes = self.routes_by_method.get(method_upper, [])
            new_regex = Route(method_upper, path_pattern, func).regex.pattern
            for route in existing_routes:
                if route.regex.pattern == new_regex:
                    raise ValueError(f"Duplicate route detected for {method_upper} {path_pattern}")
            route = Route(method_upper, path_pattern, func)
            self.routes_by_method.setdefault(method_upper, []).append(route)
            return func
        return decorator

    # Convenience methods for common HTTP verbs
    def get(self, path_pattern: str) -> Callable[[Callable[..., Any]], Callable[..., Any]]:
        return self.route('GET', path_pattern)

    def post(self, path_pattern: str) -> Callable[[Callable[..., Any]], Callable[..., Any]]:
        return self.route('POST', path_pattern)

    def put(self, path_pattern: str) -> Callable[[Callable[..., Any]], Callable[..., Any]]:
        return self.route('PUT', path_pattern)

    def delete(self, path_pattern: str) -> Callable[[Callable[..., Any]], Callable[..., Any]]:
        return self.route('DELETE', path_pattern)

    def dispatch(self, request: Request) -> Dict[str, Any]:
        """
        Dispatch the incoming event to the corresponding route handler.
        Returns an HTTP-like response dictionary.
        """
        method = request.event.get('httpMethod', 'GET').upper()
        path = request.event.get('path', '/')
        routes = self.routes_by_method.get(method, [])
        
        for route in routes:
            path_params = route.match(method, path)
            if path_params is not None:
                request.event['pathParameters'] = path_params
                try:
                    response = route.handler(request)
                    # Ensure response conforms to expected structure
                    if isinstance(response, dict) and 'statusCode' in response:
                        return response
                    else:
                        return {
                            'statusCode': 200,
                            'body': json.dumps(response)
                        }
                except Exception as e:
                    # Ideally log the exception `e` here
                    print(traceback.format_exc())
                    return {
                        'statusCode': 500,
                        'body': json.dumps({'message': 'Internal Server Error'})
                    }
        # No matching route found
        return {
            'statusCode': 404,
            'body': json.dumps({'message': 'Not Found'})
        }


# Shared router instance for use across the application
router = Router()
