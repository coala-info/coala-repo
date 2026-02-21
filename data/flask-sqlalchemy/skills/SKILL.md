---
name: flask-sqlalchemy
description: Flask-SQLAlchemy is an extension that simplifies the integration of SQLAlchemy into Flask applications.
homepage: https://github.com/pallets-eco/flask-sqlalchemy
---

# flask-sqlalchemy

## Overview
Flask-SQLAlchemy is an extension that simplifies the integration of SQLAlchemy into Flask applications. It handles the boilerplate of setting up engines and sessions, ensures that database connections are properly cleaned up after requests, and provides helpful utilities for querying and pagination. This skill focuses on the modern implementation of Flask-SQLAlchemy (version 3.0+), which emphasizes the use of SQLAlchemy's 2.0 "DeclarativeBase" and type-hinted "Mapped" columns.

## Core Implementation Patterns

### Basic Configuration
To initialize the extension, provide a database URI and associate the extension with your Flask app.

```python
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import DeclarativeBase

class Base(DeclarativeBase):
    pass

db = SQLAlchemy(model_class=Base)

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///project.db"
db.init_app(app)
```

### Defining Models (SQLAlchemy 2.0 Style)
Modern Flask-SQLAlchemy uses type hints for column definitions.

```python
from sqlalchemy import Integer, String
from sqlalchemy.orm import Mapped, mapped_column

class User(db.Model):
    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    username: Mapped[str] = mapped_column(String, unique=True, nullable=False)
    email: Mapped[str] = mapped_column(String)
```

### Working with the Application Context
Database operations like creating tables or performing queries outside of a request view must be wrapped in the application context.

```python
with app.app_context():
    db.create_all()
```

### CRUD Operations
Use `db.session` to manage transactions.

*   **Create**: `db.session.add(obj)` followed by `db.session.commit()`
*   **Read**: Use `db.select()` with `db.session.execute()` or `db.session.scalars()`
*   **Update**: Modify object attributes and `db.session.commit()`
*   **Delete**: `db.session.delete(obj)` followed by `db.session.commit()`

```python
# Querying example
users = db.session.scalars(db.select(User).order_by(User.username)).all()

# Filtering example
user = db.session.execute(db.select(User).filter_by(username='example')).scalar_one()
```

### Pagination
Flask-SQLAlchemy provides a `paginate` method on the session or via the query object to handle large datasets.

```python
page = 1
per_page = 20
pagination = db.paginate(db.select(User), page=page, per_page=per_page)

# Accessing results
for user in pagination.items:
    print(user.username)

# Metadata
print(f"Total pages: {pagination.pages}")
```

## Expert Tips and Best Practices

1.  **Use Binds for Multiple Databases**: If your app uses multiple databases, define `SQLALCHEMY_BINDS` in your config and use the `__bind_key__` attribute on models to route them to specific engines.
2.  **Avoid Legacy Query Interface**: While `User.query` still exists, prefer `db.select(User)` as it aligns with SQLAlchemy 2.0 standards and provides better IDE support/type hinting.
3.  **Session Management**: Do not manually create sessions or close them. Flask-SQLAlchemy automatically creates a scoped session and removes it at the end of the request.
4.  **Naming Conventions**: For migrations (e.g., with Flask-Migrate), define a explicit naming convention in your `DeclarativeBase` to ensure consistent constraint names across different database backends.
5.  **Type Hinting Relationships**: When defining relationships, use `Mapped` for better static analysis:
    ```python
    posts: Mapped[list["Post"]] = db.relationship(back_populates="author")
    ```

## Reference documentation
- [Flask-SQLAlchemy README](./references/github_com_pallets-eco_flask-sqlalchemy.md)
- [Flask-SQLAlchemy Discussions](./references/github_com_pallets-eco_flask-sqlalchemy_discussions.md)
- [Flask-SQLAlchemy Issues](./references/github_com_pallets-eco_flask-sqlalchemy_issues.md)