---
name: httplib2
description: httplib2 is a comprehensive HTTP client library for Python that provides features often omitted from other libraries.
homepage: https://github.com/httplib2/httplib2
---

# httplib2

## Overview
httplib2 is a comprehensive HTTP client library for Python that provides features often omitted from other libraries. It is designed for efficiency, utilizing persistent connections (HTTP/1.1 Keep-Alive) and a sophisticated private cache that understands `Cache-Control` headers and uses ETag/Last-Modified validators. This makes it particularly effective for high-performance scripts or applications that interact with REST APIs where bandwidth and latency are concerns.

## Core Usage Patterns

### Basic GET Request with Caching
To enable caching, provide a path to a local directory when initializing the `Http` object.
```python
import httplib2
# Initialize with a cache directory
h = httplib2.Http(".cache")
resp, content = h.request("http://example.org/", "GET")

# 'resp' contains response headers as a dictionary-like object
# 'content' is the body as bytes
```

### Authentication
httplib2 supports Basic, Digest, and WSSE authentication. Credentials should be added to the `Http` object before the request is made.
```python
import httplib2
h = httplib2.Http()
h.add_credentials('username', 'password')
resp, content = h.request("https://example.org/protected", "GET")
```

### Performing a PUT Request
When sending data, ensure the body is provided and the appropriate `content-type` header is set.
```python
import httplib2
h = httplib2.Http()
body_data = "Sample text content"
headers = {'content-type': 'text/plain'}
resp, content = h.request("https://example.org/resource", "PUT", body=body_data, headers=headers)
```

## Expert Tips and Best Practices

### String vs. Bytes Requirement
A critical rule for using httplib2: **Headers must be strings, but the content body must be bytes.** When processing the response, always treat `content` as a byte string that may need decoding (e.g., `content.decode('utf-8')`).

### Cache Control
You can override or bypass the local cache on a per-request basis by passing the `cache-control` header in the `request()` method.
```python
# Force a fresh request by bypassing the cache
resp, content = h.request("http://example.org/", "GET", headers={'cache-control': 'no-cache'})
```

### Automatic Decompression
httplib2 automatically handles `gzip` and `deflate` compression. The `content` returned by `h.request()` is already decompressed, so no manual handling of these compression types is required.

### Redirect Handling
The library automatically follows 3XX redirects for GET requests. For other methods, manual handling may be required depending on the specific server implementation and desired behavior.

### Lost Update Support
If you perform a PUT request on a resource that is already in your local cache, httplib2 automatically adds the ETag back into the request headers. This helps prevent the "lost update" problem by ensuring you only update the resource if it hasn't changed since you last cached it.

## Reference documentation
- [httplib2 Main Documentation](./references/github_com_httplib2_httplib2.md)
- [Security Policy](./references/github_com_httplib2_httplib2_security.md)