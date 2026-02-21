---
name: flask-admin
description: Flask-Admin is a powerful extension that automates the creation of administrative backends for Flask web applications.
homepage: https://github.com/pallets-eco/flask-admin
---

# flask-admin

## Overview
Flask-Admin is a powerful extension that automates the creation of administrative backends for Flask web applications. Unlike many "magic" admin tools, it provides a modular architecture that allows you to start with auto-generated CRUD views and progressively customize them into complex, bespoke interfaces. Use this skill when you need to provide non-technical users with a way to manage database records, upload files, or monitor application state without writing custom HTML forms for every model.

## Core Implementation Patterns

### 1. Basic Initialization
To start, initialize the `Admin` object and attach it to your Flask app. Use `template_mode` to specify the UI framework (Bootstrap 4 is the modern standard for the library).

```python
from flask import Flask
from flask_admin import Admin

app = Flask(__name__)
# template_mode can be 'bootstrap2', 'bootstrap3', or 'bootstrap4'
admin = Admin(app, name='Admin Portal', template_mode='bootstrap4')
```

### 2. Registering Database Models
The most common use case is managing SQLAlchemy models. You must pass the model and the database session to a `ModelView`.

```python
from flask_admin.contrib.sqla import ModelView
from myapp.models import User, db

admin.add_view(ModelView(User, db.session))
```

### 3. Customizing the Interface
Instead of using the raw `ModelView`, create a subclass to control which columns are visible, searchable, or editable.

*   **column_list**: Defines columns shown in the list view.
*   **column_filters**: Adds a filter sidebar for specific fields.
*   **column_searchable_list**: Enables a search box for the specified fields.
*   **form_columns**: Restricts which fields appear in the create/edit forms.

```python
class UserAdmin(ModelView):
    column_list = ('username', 'email', 'is_active')
    column_filters = ('is_active',)
    column_searchable_list = ('username', 'email')
    can_export = True  # Enables CSV export
```

### 4. Implementing Security and Access Control
By default, admin views are public. To secure them, override the `is_accessible` method. This is typically used in conjunction with Flask-Login.

```python
from flask import redirect, url_for, request
from flask_login import current_user

class SecureModelView(ModelView):
    def is_accessible(self):
        return current_user.is_authenticated and current_user.has_role('admin')

    def inaccessible_callback(self, name, **kwargs):
        # Redirect to login page if user doesn't have access
        return redirect(url_for('login', next=request.url))
```

### 5. File Management
Flask-Admin includes a `FileAdmin` tool for managing files on the server (uploading, renaming, deleting).

```python
import os.path as op
from flask_admin.contrib.fileadmin import FileAdmin

path = op.join(op.dirname(__file__), 'static')
admin.add_view(FileAdmin(path, '/static/', name='Static Files'))
```

## Expert Tips
*   **Inline Models**: Use `inline_models` in a `ModelView` to edit related records (e.g., editing a User's Profiles) on the same page.
*   **Custom Templates**: You can override specific templates (like `list.html` or `edit.html`) by placing them in your app's `templates/admin/` directory or specifying `list_template` in your view class.
*   **Database Support**: While SQLAlchemy is most common, use `flask_admin.contrib.peewee` or `flask_admin.contrib.mongoengine` for other ORMs/ODMs.
*   **Localization**: If your app needs multiple languages, install `Flask-Babel`. Flask-Admin has built-in translations for dozens of languages.

## Reference documentation
- [Flask-Admin README](./references/github_com_pallets-eco_flask-admin.md)
- [Security Policy](./references/github_com_pallets-eco_flask-admin_security.md)