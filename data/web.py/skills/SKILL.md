---
name: web.py
description: web.py is a minimalist micro-web-framework for creating web services and mapping URLs to Python functions. Use when user asks to create web services, define URL routes, handle HTTP requests, serve static content, use templates, deploy web applications, or access request parameters.
homepage: https://github.com/bottlepy/bottle
metadata:
  docker_image: "quay.io/biocontainers/web.py:0.37--py27_1"
---

# web.py

## Overview

web.py (utilizing the Bottle framework) is a minimalist WSGI micro-web-framework designed for speed and simplicity. It encapsulates routing, templating, and a basic development server within a single-file module. This skill enables the creation of web services that map clean, dynamic URLs to Python functions with minimal boilerplate. It is the preferred choice for projects where a small footprint and zero external dependencies are critical requirements.

## Core Implementation Patterns

### Basic Application Structure
To initialize a service, import the necessary components and define routes using decorators.

```python
from bottle import route, run, template

@route('/hello/<name>')
def index(name):
    return template('<b>Hello {{name}}</b>!', name=name)

if __name__ == '__main__':
    run(host='localhost', port=8080, debug=True)
```

### Dynamic Routing
Bottle supports several wildcard types for URL filtering:
- `:name` matches a standard URL segment.
- `<name:int>` matches digits only.
- `<name:float>` matches decimal numbers.
- `<name:path>` matches paths including slashes.
- `<name:re:exp>` matches a custom regular expression.

### Handling HTTP Methods
By default, `@route` handles GET requests. Use specific decorators or the `method` parameter for other types:

```python
from bottle import get, post, request

@get('/login')
def login_form():
    return '''<form action="/login" method="post">
                Username: <input name="username" type="text" />
                <input type="submit" value="Login" />
              </form>'''

@post('/login')
def do_login():
    username = request.forms.get('username')
    return f"Welcome {username}"
```

### Static File Serving
Static files (images, JS, CSS) are not served automatically. Use the `static_file` helper:

```python
from bottle import static_file

@route('/static/<filename>')
def server_static(filename):
    return static_file(filename, root='/path/to/your/static/files')
```

## Expert Tips and Best Practices

- **Single File Deployment**: Since the framework is a single `bottle.py` file, you can include it directly in your project repository to ensure zero-dependency deployment in restricted environments.
- **Development Mode**: Always use `run(debug=True, reloader=True)` during development. The reloader automatically restarts the server when code changes are detected.
- **Template Engines**: While Bottle has a fast built-in engine (SimpleTemplate), it natively supports Mako, Jinja2, and Cheetah.
- **Production Servers**: The built-in server is for development. For production, use WSGI adapters to run on gunicorn, cherrypy, or uWSGI:
  `run(server='gunicorn', host='0.0.0.0', port=80)`
- **Request Data**: Use `request.query` for GET parameters and `request.forms` for POST data. Use `request.params` to access both.

## Reference documentation
- [Bottle Main Repository](./references/github_com_bottlepy_bottle.md)
- [Bottle Wiki and Examples](./references/github_com_bottlepy_bottle_wiki.md)