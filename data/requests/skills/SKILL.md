---
name: requests
description: The requests library provides a human-friendly interface for making HTTP/1.1 requests in Python. Use when user asks to make GET or POST requests, handle JSON data from APIs, manage persistent sessions, or implement robust error handling for web communication.
homepage: https://github.com/psf/requests
metadata:
  docker_image: "quay.io/biocontainers/requests:2.26.0"
---

# requests

## Overview
The `requests` library is the industry standard for making HTTP/1.1 requests in Python. It provides a "human-friendly" abstraction over Python's built-in network modules, automatically handling connection pooling, keep-alive, and content decoding. Use this skill to implement robust web clients that require deterministic behavior, proper error handling, and efficient resource management.

## Core Usage Patterns

### Basic Requests
Always use the `json` parameter for POST requests to automatically set the `Content-Type` header to `application/json` and encode the dictionary.

```python
import requests

# GET request with query parameters
params = {'key1': 'value1', 'key2': 'value2'}
r = requests.get('https://httpbin.org/get', params=params)

# POST request with JSON body
payload = {'user': 'claude'}
r = requests.post('https://httpbin.org/post', json=payload)

# Accessing response data
status = r.status_code
data = r.json()  # Decodes JSON response into a dict
text = r.text    # Decodes response content based on encoding
```

### Session Objects
Use `requests.Session()` for multiple requests to the same host. This enables connection pooling (reusing the same TCP connection) and persists cookies across requests, significantly improving performance.

```python
with requests.Session() as session:
    session.auth = ('user', 'pass')
    session.headers.update({'x-test': 'true'})

    # Both requests will use the same connection and headers
    session.get('https://httpbin.org/cookies/set/sessioncookie/123456789')
    r = session.get('https://httpbin.org/cookies')
```

### Error Handling
Always call `raise_for_status()` to ensure the request was successful (2xx). This raises an `HTTPError` for 4xx or 5xx responses.

```python
try:
    r = requests.get('https://httpbin.org/status/404', timeout=5)
    r.raise_for_status()
except requests.exceptions.HTTPError as err:
    print(f"HTTP error occurred: {err}")
except requests.exceptions.RequestException as e:
    print(f"System error: {e}")
```

## Expert Tips and Best Practices

### Mandatory Timeouts
Never make a request without a timeout. By default, requests will hang indefinitely if the server does not respond. Use a tuple for (connect timeout, read timeout).

```python
# Timeout after 3.05 seconds to connect and 27 seconds to read
requests.get('https://github.com', timeout=(3.05, 27))
```

### Authentication
Requests supports Basic and Digest authentication out of the box. For more complex flows, use the `auth` parameter with specialized objects.

```python
from requests.auth import HTTPDigestAuth
url = 'https://httpbin.org/digest-auth/auth/user/pass'
requests.get(url, auth=HTTPDigestAuth('user', 'pass'))
```

### SSL Verification and Proxies
For internal tools with self-signed certificates, you can disable verification (not recommended for production) or provide a path to a CA bundle.

```python
# Custom CA bundle
requests.get('https://enterprise.internal', verify='/path/to/certfile')

# Using proxies
proxies = {
  'http': 'http://10.10.1.10:3128',
  'https': 'http://10.10.1.10:1080',
}
requests.get('https://httpbin.org/get', proxies=proxies)
```

### Streaming Large Downloads
For large files, use `stream=True` to avoid loading the entire response into memory at once.

```python
r = requests.get('https://httpbin.org/image/jpeg', stream=True)
with open('image.jpg', 'wb') as f:
    for chunk in r.iter_content(chunk_size=128):
        f.write(chunk)
```

## Reference documentation
- [Requests Overview](./references/github_com_psf_requests.md)
- [Community Cookbook and Addons](./references/github_com_psf_requests_wiki.md)
- [Security and Vulnerability Disclosure](./references/github_com_psf_requests_security.md)