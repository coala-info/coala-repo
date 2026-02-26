---
name: sqlalchemy-datatables
description: This library integrates SQLAlchemy models with the jQuery DataTables plugin to simplify server-side processing of complex data requests. Use when user asks to translate DataTables request parameters into SQLAlchemy queries, implement server-side pagination and filtering, or map database columns to frontend table displays.
homepage: https://github.com/pegase745/sqlalchemy-datatables
---


# sqlalchemy-datatables

## Overview

The `sqlalchemy-datatables` library acts as a bridge between SQLAlchemy models and the jQuery DataTables frontend plugin. It simplifies the process of translating DataTables' complex server-side request parameters (sent via GET or POST) into optimized SQLAlchemy queries. By using this skill, you can efficiently manage data tables that require complex joins, custom column formatting, and server-side searching without manually writing pagination or filtering logic.

## Implementation Guide

### 1. Define Table Columns
Use the `ColumnDT` class to map your SQLAlchemy model attributes to the DataTables columns. The order in the list must match the order of columns defined in your HTML/JavaScript.

```python
from datatables import ColumnDT

columns = [
    ColumnDT(User.id),
    ColumnDT(User.name),
    ColumnDT(Address.description),
    # Use func for formatting or casting to ensure searchability
    ColumnDT(func.strftime('%d-%m-%Y', User.birthday)),
    ColumnDT(User.age)
]
```

### 2. Construct the Base Query
Define the initial SQLAlchemy query. Do not include `.all()` or pagination methods, as the library will append these automatically.

*   **Simple Query:** `query = session.query().select_from(User)`
*   **With Joins:** Always use `.select_from()` when performing joins to ensure the library correctly identifies the primary table for record counting.
    ```python
    query = session.query().select_from(User).join(Address).filter(Address.id > 0)
    ```

### 3. Process the Request
Instantiate the `DataTables` object by passing the request parameters, the base query, and the column definitions.

*   **Flask:** Use `request.args`.
*   **Pyramid:** Use `request.GET`.

```python
from datatables import DataTables

# params is the dictionary of arguments from the web request
rowTable = DataTables(params, query, columns)
return rowTable.output_result()
```

## Best Practices and Tips

*   **Searchable Dates:** When displaying dates, explicitly cast them to strings using SQLAlchemy's `func` (e.g., `strftime`) within `ColumnDT`. This allows the DataTables global search to match date strings as they appear in the UI.
*   **Performance:** For very large tables, ensure that the columns used for sorting and filtering are indexed in your database. `sqlalchemy-datatables` performs a count query to determine the total number of records; ensure your base filters are efficient.
*   **Global vs. Column Search:** The library automatically handles both the global search box and individual column filtering (if enabled in the DataTables configuration).
*   **Framework Agnostic:** While often used with Flask or Pyramid, the library only requires a dictionary-like object for parameters and a SQLAlchemy query object, making it compatible with any Python web framework.

## Reference documentation
- [SQLAlchemy integration of jQuery DataTables](./references/github_com_Pegase745_sqlalchemy-datatables.md)
- [sqlalchemy-datatables Overview](./references/anaconda_org_channels_bioconda_packages_sqlalchemy-datatables_overview.md)