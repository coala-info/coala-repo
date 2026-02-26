---
name: sqlsoup
description: SQLSoup is a minimalist database abstraction layer that automatically maps Python objects to relational tables at runtime without requiring explicit class definitions. Use when user asks to interact with databases without boilerplate code, explore legacy schemas, or perform quick data manipulations using SQLAlchemy's query interface.
homepage: https://github.com/kenwilcox/sqlsoup
---


# sqlsoup

## Overview
SQLSoup is a minimalist database abstraction layer built on top of the SQLAlchemy ORM. It provides a "no-boilerplate" approach to database interaction by automatically mapping Python objects to relational tables at runtime. Unlike standard SQLAlchemy usage, which requires explicit class and mapping definitions, SQLSoup allows you to treat database tables as attributes of a central database object, making it highly efficient for working with legacy schemas or performing quick data manipulations.

## Usage Instructions

### Initialization
Connect to your database using a standard SQLAlchemy connection string.
```python
import sqlsoup
db = sqlsoup.SQLSoup("postgresql://user:password@localhost/dbname")
```

### Data Retrieval
Tables are accessed as attributes of the `db` object. SQLSoup uses SQLAlchemy's query interface.
- **Fetch all records**: `db.users.all()`
- **Filter records**: `db.users.filter_by(name="ed").all()`
- **Get one record**: `db.users.filter_by(id=1).one()`

### Data Manipulation
- **Update**: Use the `update` method on a filtered result set.
  ```python
  db.users.filter_by(name="ed").update({"name": "jack"})
  ```
- **Commit Changes**: Always call `db.commit()` to persist changes to the database.
  ```python
  db.commit()
  ```

## Best Practices and Tips
- **Connection Strings**: Ensure you have the appropriate database driver installed (e.g., `psycopg2` for PostgreSQL, `mysqlclient` for MySQL).
- **Table Discovery**: SQLSoup reflects the database schema upon initialization. If the schema changes while the script is running, you may need to re-initialize the object.
- **Complex Queries**: For complex joins or advanced ORM features, consider using the underlying SQLAlchemy `session` or `engine` which SQLSoup wraps.
- **Legacy Databases**: SQLSoup is particularly powerful for "read-only" exploration of large, complex legacy databases where writing models for every table would be time-prohibitive.

## Reference documentation
- [SQLSoup Repository and README](./references/github_com_kenwilcox_sqlsoup.md)