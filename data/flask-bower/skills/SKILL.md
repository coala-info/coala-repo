---
name: flask-bower
description: The `flask-bower` extension simplifies the integration of Bower-managed packages into a Flask project.
homepage: http://github.com/lobeck/flask-bower
---

# flask-bower

## Overview
The `flask-bower` extension simplifies the integration of Bower-managed packages into a Flask project. It creates a dedicated blueprint that allows you to reference third-party libraries (like jQuery or Bootstrap) using Flask's standard `url_for` syntax, similar to how you serve local static files. This skill helps you configure the extension to handle asset minification, cache-busting via query strings, and custom directory structures.

## Installation and Setup
Install the extension via pip or conda:

```bash
# Using pip
pip install flask-bower

# Using conda (bioconda channel)
conda install bioconda::flask-bower
```

Initialize the extension in your Flask application:

```python
from flask import Flask
from flask_bower import Bower

app = Flask(__name__)
Bower(app)
```

## Configuration
Customize the behavior of the extension by setting these variables in your Flask `app.config`:

| Configuration Key | Default | Description |
|:---|:---|:---|
| `BOWER_COMPONENTS_ROOT` | `bower_components` | The directory containing your bower packages (relative to the app root). |
| `BOWER_URL_PREFIX` | `/bower` | The URL route used to serve bower assets. |
| `BOWER_TRY_MINIFIED` | `True` | Automatically checks for and serves `.min.js` or `.min.css` versions if they exist. |
| `BOWER_QUERYSTRING_REVVING` | `True` | Appends a `?version=` parameter based on `bower.json` or file timestamps for cache busting. |
| `BOWER_SUBDOMAIN` | `None` | Specific subdomain to serve assets from. |
| `BOWER_REPLACE_URL_FOR` | `False` | If True, attempts to intercept all `url_for` calls (not recommended if using other extensions like Flask-CDN). |

## Usage in Templates
The extension registers a blueprint named `bower`. Use the standard `url_for` function to reference your assets.

**Standard Pattern:**
```html
<script src="{{ url_for('bower.static', filename='jquery/dist/jquery.js') }}"></script>
```

**Expert Tips:**
- **Minification:** With `BOWER_TRY_MINIFIED` set to `True`, you can reference the non-minified file in your code, and the extension will automatically serve the `.min` version if available in the same directory.
- **Directory Structure:** Ensure your `bower_components` folder is inside your application directory (e.g., `app/bower_components/`) unless you provide an absolute path in `BOWER_COMPONENTS_ROOT`.
- **Migration:** Avoid using the deprecated `bower_url_for()` function. Always use `url_for('bower.static', ...)` for better compatibility with the Flask ecosystem.

## Common Workflow
1. Install a frontend dependency: `bower install -S jquery`
2. Verify the component exists in `app/bower_components/jquery`.
3. Reference the asset in your Jinja2 template using the `bower.static` endpoint.
4. In production, ensure `BOWER_QUERYSTRING_REVVING` is enabled to prevent clients from loading stale cached assets after updates.

## Reference documentation
- [flask-bower Overview](./references/github_com_lobeck_flask-bower.md)
- [bioconda flask-bower Installation](./references/anaconda_org_channels_bioconda_packages_flask-bower_overview.md)