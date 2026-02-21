---
name: flask-basicauth
description: flask-basicauth is a lightweight Flask extension that provides a straightforward way to protect web applications with HTTP basic access authentication.
homepage: https://github.com/jpvanhal/flask-basicauth
---

# flask-basicauth

## Overview
flask-basicauth is a lightweight Flask extension that provides a straightforward way to protect web applications with HTTP basic access authentication. It is designed for scenarios where a full-blown user database or complex authentication system is unnecessary. The extension allows for global protection of all routes or selective protection of specific view functions using a decorator.

## Implementation Patterns

### Basic Configuration
To use the extension, you must define the credentials in your Flask application's configuration.

```python
from flask import Flask
from flask_basicauth import BasicAuth

app = Flask(__name__)

# Configuration
app.config['BASIC_AUTH_USERNAME'] = 'admin'
app.config['BASIC_AUTH_PASSWORD'] = 'secret'

basic_auth = BasicAuth(app)
```

### Protecting Specific Routes
Use the `@basic_auth.required` decorator to protect individual view functions.

```python
@app.route('/secret')
@basic_auth.required
def secret_view():
    return "This view requires authentication."
```

### Protecting the Entire Application
To require authentication for every route in the application, set the `BASIC_AUTH_FORCE` configuration variable to `True`.

```python
app.config['BASIC_AUTH_FORCE'] = True
```

## Expert Tips and Best Practices

- **Environment Variables**: Never hardcode credentials in your source code. Use environment variables to populate `BASIC_AUTH_USERNAME` and `BASIC_AUTH_PASSWORD`.
- **Security over HTTPS**: Basic authentication sends credentials in a header that is only Base64 encoded, not encrypted. Always use this extension in conjunction with HTTPS to prevent credential sniffing.
- **Staging Environments**: `BASIC_AUTH_FORCE = True` is a highly effective way to keep search engine crawlers and unauthorized users out of staging or development servers.
- **Custom Challenges**: If you need to customize the authentication logic beyond a single username/password, you may need to subclass `BasicAuth` and override the `check_credentials` method.
- **Proxy Considerations**: If your Flask app is behind a proxy (like Nginx), ensure the proxy is configured to pass the `Authorization` header to the application.

## Reference documentation
- [Flask-BasicAuth Repository Overview](./references/github_com_jpvanhal_flask-basicauth.md)