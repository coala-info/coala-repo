---
name: requests-toolbelt
description: The requests-toolbelt is a collection of utility classes and functions that extend the requests library to handle complex HTTP scenarios. Use when user asks to stream multipart form-data for large file uploads, construct custom user-agent strings, enforce specific SSL/TLS protocols, or implement stateless sessions with a forgetful cookie jar.
homepage: https://github.com/requests/toolbelt
---


# requests-toolbelt

## Overview
The `requests-toolbelt` is a utility belt for the `requests` library, providing classes and functions that handle complex HTTP scenarios not covered by the core library. It is primarily used to improve memory efficiency during file uploads and to provide finer control over session behavior, such as SSL configuration and cookie persistence.

## Implementation Patterns

### Streaming Multipart/Form-Data
Use `MultipartEncoder` when uploading large files or complex form data. Unlike the default `requests` behavior, this tool streams the data from disk, preventing high memory consumption.

```python
from requests_toolbelt import MultipartEncoder
import requests

# Prepare the encoder with fields and files
m = MultipartEncoder(
    fields={
        'field_name': 'value',
        'file_field': ('filename.txt', open('large_file.txt', 'rb'), 'text/plain')
    }
)

# You must pass the encoder's content_type to the headers
r = requests.post(
    'https://httpbin.org/post', 
    data=m, 
    headers={'Content-Type': m.content_type}
)
```

### Custom User-Agent Construction
Standardize your identifying headers using the `user_agent` helper to ensure a consistent format across your application.

```python
from requests_toolbelt import user_agent
import requests

headers = {
    'User-Agent': user_agent('my_app_name', '1.0.2')
}
r = requests.get('https://api.example.com', headers=headers)
```

### Enforcing SSL/TLS Protocols
If a server requires a specific TLS version (e.g., TLS v1.0 for legacy systems), use the `SSLAdapter` to mount the protocol to a session.

```python
from requests_toolbelt import SSLAdapter
import requests
import ssl

s = requests.Session()
# Force TLS v1.0 for all https:// calls in this session
s.mount('https://', SSLAdapter(ssl.PROTOCOL_TLSv1))
```

### Stateless Sessions (ForgetfulCookieJar)
To ensure a session never stores or sends cookies (useful for certain API interactions or privacy-sensitive tasks), replace the default cookie jar.

```python
from requests_toolbelt.cookies.forgetful import ForgetfulCookieJar
import requests

session = requests.Session()
session.cookies = ForgetfulCookieJar()
```

## Expert Tips
- **Content-Type Header**: Always use `m.content_type` from the `MultipartEncoder` instance. It automatically generates the necessary boundary string required for the multipart request to be valid.
- **Memory Efficiency**: When using `MultipartEncoder` with files, ensure the files are opened in binary mode (`'rb'`).
- **Compatibility**: The toolbelt is designed for `requests` version 2.1.0 and higher.

## Reference documentation
- [The Requests Toolbelt](./references/github_com_requests_toolbelt.md)