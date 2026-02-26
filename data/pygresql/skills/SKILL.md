---
name: pygresql
description: PyGreSQL provides a Python interface for the PostgreSQL database through both a standard DB-API 2.0 module and a classic object-oriented wrapper. Use when user asks to connect to PostgreSQL, perform high-performance batch inserts, handle database conflicts, or execute CRUD operations using the classic DB wrapper.
homepage: https://github.com/PyGreSQL/PyGreSQL
---


# pygresql

## Overview
PyGreSQL is a mature Python interface for the PostgreSQL database that wraps the C API library (libpq). It provides two distinct interfaces: a "classic" module (`pg`) that offers a more direct, object-oriented wrapper around PostgreSQL features, and a DB-API 2.0 compliant module (`pgdb`) for standard Python database connectivity. This skill helps in selecting the right interface and implementing efficient database patterns like batch inserts and conflict handling.

## Installation and Requirements
PyGreSQL requires the `libpq` shared library to be installed on the client machine.
- **Install via pip**: `pip install PyGreSQL`
- **Supported Versions**: Python 3.8 to 3.14; PostgreSQL 12 to 18.

## Core Usage Patterns

### 1. DB-API 2.0 Interface (pgdb)
Use this for standard database operations that should remain compatible with other Python database drivers.
```python
import pgdb

# Connection string format: 'host:database:user:password:port'
# Or use keyword arguments
con = pgdb.connect(database='mydb', user='myuser')
cur = con.cursor()
cur.execute("SELECT * FROM my_table WHERE id = %s", (1,))
row = cur.fetchone()
con.close()
```

### 2. Classic Interface (pg)
Use the `pg` module when you need PostgreSQL-specific functionality or prefer the `DB` wrapper class.
```python
import pg

db = pg.DB(dbname='mydb', host='localhost', user='myuser')

# Simple CRUD operations using the wrapper
db.insert('table_name', column1='value1', column2=2)
db.update('table_name', {'column1': 'new_value'}, id=1)
db.delete('table_name', id=1)

# Querying
res = db.query("SELECT * FROM table_name").dictresult()
```

### 3. High-Performance Batch Inserts
The `inserttable` method is a specialized tool for high-speed data loading, significantly faster than standard `INSERT` statements.
- **Usage**: `db.inserttable('table_name', list_of_tuples)`
- **Optimization**: Recent versions include a `freeze` parameter and optimized memory allocation for large batches.
- **Best Practice**: Use `inserttable` when migrating large datasets or performing bulk logging.

## Expert Tips
- **Conflict Handling**: Use `DB.onconflict()` to define behavior (like DO NOTHING or DO UPDATE) when a row already exists, though note it typically requires a primary key to be defined.
- **Type Handling**: PyGreSQL handles standard PostgreSQL types automatically. For specialized date/time handling in `inserttable`, the library uses `str(datetime)` conversions for compatibility.
- **Connection Management**: When using the classic interface, the `DB` object maintains the connection state. For web applications, ensure connections are properly closed or pooled.
- **Schema Specification**: When working with specific schemas, ensure the table name is passed as a qualified string (e.g., `'schema_name.table_name'`).

## Reference documentation
- [PyGreSQL README](./references/github_com_PyGreSQL_PyGreSQL.md)
- [PyGreSQL Commits (Functional Updates)](./references/github_com_PyGreSQL_PyGreSQL_commits_main.md)
- [PyGreSQL Issues (Known Behaviors)](./references/github_com_PyGreSQL_PyGreSQL_issues.md)