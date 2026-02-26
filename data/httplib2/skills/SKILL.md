---
name: httplib2
description: httplib2 is a comprehensive Python HTTP client library that manages connection pooling, transparent compression, and sophisticated cache validation. Use when user asks to perform HTTP requests, manage persistent caching, handle authentication, or control redirect behavior in web service clients.
homepage: https://github.com/httplib2/httplib2
---


# httplib2

## Overview

httplib2 is a comprehensive HTTP client library for Python that distinguishes itself through its sophisticated handling of the HTTP protocol. It provides a high-level interface for performing requests while managing low-level details like connection pooling, cache validation (using ETags and Last-Modified headers), and transparent compression. Use this skill to implement reliable web service clients that need to be "good citizens" on the web by respecting cache headers and efficiently managing resources.

## Core Usage Patterns

### Basic Request
The primary interface is the `Http` object. In Python 3, the response body is returned as `bytes`.

```python
import httplib2
h = httplib2.Http(".cache") # Directory for persistent caching
resp, content = h.request("http://example.org/", "GET")

# Convert bytes to string if necessary
str_content = content.decode('utf-8')
```

### Authentication
httplib2 supports Basic, Digest, and WSSE authentication. Credentials can be scoped to specific domains.

```python
h = httplib2.Http()
h.add_credentials('username', 'password', domain='example.org')
resp, content = h.request("https://example.org/api/resource", "GET")
```

### Handling Forms and Cookies
To submit forms, use `urllib.parse.urlencode`. For sessions, manually extract the `set-cookie` header and pass it back in subsequent requests.

```python
from urllib.parse import urlencode

# Form Submission
data = {'field1': 'value1', 'field2': 'value2'}
headers = {'Content-type': 'application/x-www-form-urlencoded'}
resp, content = h.request(url, "POST", body=urlencode(data), headers=headers)

# Cookie Persistence
if 'set-cookie' in resp:
    headers['Cookie'] = resp['set-cookie']
    resp2, content2 = h.request(next_url, "GET", headers=headers)
```

## Expert Tips and Best Practices

### Caching Strategy
- **Persistent Cache**: Always provide a path to the `Http` constructor (e.g., `Http(".cache")`) to enable the `FileCache`. This significantly improves performance and reduces server load.
- **Bypassing Cache**: To force a fresh request, use the `cache-control` header:
  `h.request(url, headers={'cache-control': 'no-cache'})`

### Redirect Control
By default, httplib2 only follows "safe" redirects (GET/HEAD). 
- To follow all redirects (including POST to GET): `h.follow_all_redirects = True`
- To disable redirects entirely: `h.follow_redirects = False`
- **Security Note**: Use `h.forward_authorization_headers = True` only if you trust the redirect destination, as it can leak credentials.

### Error Handling
By default, httplib2 raises exceptions for network errors. You can toggle `force_exception_to_status_code = True` to have these errors returned as `Response` objects with appropriate status codes (e.g., 404 or 500) instead of crashing the script.

### Lost Update Protection
httplib2 automatically handles ETags for `PUT` requests. If you have a resource cached, httplib2 will add an `if-match` header to your `PUT` request to ensure you don't overwrite changes made by another client in the interim.

## Reference documentation
- [Examples Python3](./references/github_com_httplib2_httplib2_wiki_Examples-Python3.md)
- [The httplib2 Library](./references/httplib2_readthedocs_io_en_latest_libhttplib2.html.md)
- [httplib2 Wiki Examples](./references/github_com_httplib2_httplib2_wiki_Examples.md)