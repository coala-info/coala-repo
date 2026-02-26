---
name: grequests
description: Grequests is a Python library that enables asynchronous HTTP requests by combining the requests library with gevent for concurrent execution. Use when user asks to send multiple HTTP requests concurrently, perform non-blocking network I/O, or stream responses as they arrive using imap.
homepage: https://github.com/spyoungtech/grequests
---


# grequests

## Overview
`grequests` is a Python library that combines the power of the `requests` library with `gevent` to enable asynchronous HTTP requests. It allows you to define a set of requests and execute them concurrently, significantly reducing the total time spent waiting for network I/O compared to standard sequential requests.

## Core Usage Patterns

### Basic Asynchronous Requests
To use `grequests`, you first create a generator or list of unsent request objects using the standard HTTP verbs (get, post, put, etc.), then execute them using `map`.

```python
import grequests

urls = ['https://httpbin.org/get?id=1', 'https://httpbin.org/get?id=2']
# Create unsent request objects
rs = (grequests.get(u) for u in urls)

# Send all requests and wait for results
responses = grequests.map(rs)
```

### Streaming with imap
For better performance and memory management when dealing with large numbers of requests, use `imap`. It returns a generator that yields responses as they arrive.

```python
# size=10 limits the number of concurrent connections
for resp in grequests.imap(rs, size=10):
    print(resp.status_code)
```

### Tracking Requests with imap_enumerated
If you need to know which request produced which response (since `imap` returns them in order of completion), use `imap_enumerated`.

```python
rs = [grequests.get(url) for url in urls]
for index, response in grequests.imap_enumerated(rs, size=5):
    print(f"Request {index} returned {response.status_code}")
```

## Expert Tips and Best Practices

### The Import Order Rule
**Critical:** Because `grequests` uses `gevent` monkeypatching, you must import `grequests` before `requests` (or any other library that might import `requests`). Failure to do so can lead to hangs or non-asynchronous behavior.

```python
# Correct
import grequests
import requests

# Incorrect
import requests
import grequests
```

### Error Handling
Network failures or timeouts return `None` in the result list by default. To handle these gracefully, provide an `exception_handler` function.

```python
def handle_exception(request, exception):
    return f"Failed: {exception}"

reqs = [grequests.get('http://invalid-domain')]
results = grequests.map(reqs, exception_handler=handle_exception)
```

### Performance Tuning
*   **Pool Size:** Use the `size` parameter in `map` or `imap` to control concurrency. Too high a value can lead to "Too many open files" errors or being blocked by the server.
*   **Timeouts:** Always pass a `timeout` argument to the request methods (e.g., `grequests.get(url, timeout=5)`) to prevent a single slow request from hanging the entire batch.
*   **Sessions:** For better performance when hitting the same host, use a session object:
    ```python
    with grequests.Session() as session:
        rs = [grequests.get(u, session=session) for u in urls]
        responses = grequests.map(rs)
    ```

## Reference documentation
- [GRequests: Asynchronous Requests](./references/github_com_spyoungtech_grequests.md)