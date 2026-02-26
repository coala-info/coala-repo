---
name: urllib3
description: `urllib3` is a high-performance, low-level HTTP client for Python that handles network requests, connection pooling, and advanced communication patterns. Use when user asks to make HTTP requests, manage connection pools, implement retry strategies, set timeouts, parse JSON responses, use proxies, stream large downloads, or upload files and form data.
homepage: https://github.com/urllib3/urllib3
---


# urllib3

## Overview
`urllib3` is a high-performance, low-level HTTP client for Python that provides features missing from the standard library. It is designed for reliability and concurrency, offering built-in connection pooling and thread safety. This skill helps you implement efficient network requests, manage secure connections, and handle complex communication patterns like multipart uploads and custom retry strategies.

## Core Implementation
The most efficient way to use `urllib3` is through a `PoolManager`, which handles connection reuse automatically.

```python
import urllib3

# Initialize the PoolManager (re-use this across your application)
http = urllib3.PoolManager()

# Make a request
resp = http.request("GET", "https://httpbin.org/robots.txt")

print(f"Status: {resp.status}")
print(f"Body: {resp.data.decode('utf-8')}")
```

## Expert Patterns

### 1. Robust Retries and Timeouts
Avoid using default settings for production network calls. Use the `Retry` object to handle transient network errors and set explicit timeouts to prevent hanging.

```python
from urllib3.util import Retry

# Configure retry logic: 5 total attempts, exponential backoff, retry on specific status codes
retries = Retry(total=5, backoff_factor=0.2, status_forcelist=[500, 502, 503, 504])

# Apply retries and a 3-second timeout to the manager
http = urllib3.PoolManager(retries=retries, timeout=3.0)

resp = http.request("GET", "https://httpbin.org/status/500")
```

### 2. Handling JSON Responses
`urllib3` returns response data as bytes. You must decode the bytes and use the `json` module to parse the content.

```python
import json

resp = http.request("GET", "https://httpbin.org/json")
if resp.status == 200:
    data = json.loads(resp.data.decode('utf-8'))
    print(data)
```

### 3. Proxy Support
Use `ProxyManager` to route requests through an HTTP or SOCKS proxy.

```python
proxy = urllib3.ProxyManager("http://proxy.example.com:8080/")
resp = proxy.request("GET", "https://httpbin.org/ip")
```

### 4. Streaming Large Downloads
For large files, disable `preload_content` to stream the response data without loading it all into memory at once.

```python
resp = http.request("GET", "https://httpbin.org/bytes/1024", preload_content=False)

for chunk in resp.stream(128):
    # Process chunk (bytes)
    pass

resp.release_conn() # Ensure the connection is returned to the pool
```

### 5. Form Data and File Uploads
Pass a dictionary to the `fields` parameter to automatically encode data as `multipart/form-data`.

```python
# Simple form fields
resp = http.request("POST", "https://httpbin.org/post", fields={"key": "value"})

# File upload
with open("example.txt", "rb") as f:
    resp = http.request(
        "POST", 
        "https://httpbin.org/post",
        fields={"filefield": ("example.txt", f.read(), "text/plain")}
    )
```

## Best Practices
- **Reuse PoolManagers**: Do not create a new `PoolManager` for every request. Reusing the instance allows `urllib3` to manage a pool of connections, significantly improving performance.
- **Thread Safety**: A single `PoolManager` instance can be safely shared across multiple threads.
- **Header Management**: Use `headers={...}` in the `request` method to pass custom User-Agents or Authentication tokens.
- **SSL/TLS**: `urllib3` performs client-side verification by default. For custom environments, you can specify `ca_certs` or `cert_reqs` in the `PoolManager` constructor.
- **Decompression**: `urllib3` automatically handles `gzip`, `deflate`, `brotli`, and `zstd` encoding if the necessary libraries are installed.

## Reference documentation
- [urllib3 README](./references/github_com_urllib3_urllib3.md)
- [Security Policy](./references/github_com_urllib3_urllib3_security.md)