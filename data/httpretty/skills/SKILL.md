---
name: httpretty
description: HTTPretty is a Python library that mocks HTTP requests by intercepting network traffic at the socket level. Use when user asks to mock API responses, intercept outgoing HTTP requests for testing, or simulate various network conditions like status codes and streaming data.
homepage: https://github.com/gabrielfalcao/HTTPretty
---


# httpretty

## Overview

HTTPretty is a powerful HTTP client mocking tool for Python that operates by faking the underlying socket module. Because it intercepts traffic at the transport layer, it is agnostic to the high-level library being used (e.g., `requests`, `urllib3`, `httpx`, or `boto3`). It allows you to define mock responses for specific URIs, status codes, and headers, while providing a mechanism to inspect the outgoing requests made by your application to verify correctness.

## Core Usage Patterns

### Basic Mocking
The most common way to use HTTPretty is via the `@httpretty.activate` decorator.

```python
import httpretty
import requests

@httpretty.activate(verbose=True, allow_net_connect=False)
def test_api_call():
    # Register a mock URI
    httpretty.register_uri(
        httpretty.GET, 
        "https://api.example.com/data",
        body='{"status": "success"}',
        content_type="application/json"
    )

    response = requests.get("https://api.example.com/data")
    
    assert response.json() == {"status": "success"}
    assert httpretty.last_request().path == "/data"
```

### Dynamic and Sequential Responses
You can register the same URI multiple times to simulate a sequence of events, such as a successful call followed by a failure.

```python
url = "https://api.example.com/status"
httpretty.register_uri(httpretty.GET, url, status=200)
httpretty.register_uri(httpretty.GET, url, status=500)

# First call returns 200
requests.get(url).status_code == 200
# Second call returns 500
requests.get(url).status_code == 500
```

### Inspecting Requests
HTTPretty captures all outgoing requests, allowing you to assert that your application is sending the correct data.

- `httpretty.last_request()`: Returns the most recent request object.
- `httpretty.latest_requests()`: Returns a list of all requests intercepted during the current session.

Key attributes of the request object:
- `request.body`: The raw request body.
- `request.headers`: A dictionary-like object of request headers.
- `request.querystring`: A dictionary of parsed query parameters.
- `request.method`: The HTTP method used.

## Expert Tips and Best Practices

- **Strict Isolation**: Always set `allow_net_connect=False` in the `@httpretty.activate` decorator. This ensures that if your code attempts to hit an unregistered URI, HTTPretty will raise an error instead of allowing a real network request, which prevents flaky or slow tests.
- **Regex Matching**: You can use compiled regular expressions for URIs if the exact path is dynamic (e.g., contains IDs).
  ```python
  import re
  httpretty.register_uri(httpretty.GET, re.compile(r"https://api.com/user/\d+"), body="{}")
  ```
- **Streaming Responses**: To simulate a streaming API, pass an iterable or a generator as the `body` argument.
- **Thread Safety**: Be cautious when using HTTPretty in multi-threaded environments, as it patches the global socket module. It is generally best suited for single-threaded test execution.
- **Cleanup**: If using HTTPretty without the decorator (manually calling `httpretty.enable()`), ensure you call `httpretty.disable()` and `httpretty.reset()` in your test teardown to avoid side effects in other tests.

## Reference documentation
- [HTTPretty Main Documentation](./references/github_com_gabrielfalcao_HTTPretty.md)