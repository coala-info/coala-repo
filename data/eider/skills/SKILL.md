---
name: eider
description: Eider is a command-line utility for executing SQL queries against DuckDB using inline strings, standard input, or external files. Use when user asks to run SQL queries from the terminal, execute templated SQL scripts with parameters, or interact with DuckDB database files and Parquet data.
homepage: https://github.com/heuermh/eider
---


# eider

## Overview

Eider is a specialized command-line utility designed to interface with DuckDB. It provides a streamlined way to execute SQL queries directly from the terminal, supporting inline strings, standard input, or external files. Its primary strength lies in its support for `${key}`-style template parameters, allowing you to create reusable SQL scripts where variables like table names, column identifiers, or filter criteria can be injected at runtime.

## CLI Usage Patterns

### Executing Queries
Eider supports three primary methods for providing SQL:

1.  **Inline Query**: Use the `-q` or `--query` flag for quick, one-off commands.
    ```bash
    eider -q "SELECT * FROM 'data.parquet' LIMIT 10"
    ```
2.  **Standard Input (Pipe)**: Useful for chaining eider with other CLI tools.
    ```bash
    echo "SELECT count(*) FROM read_csv_auto('logs.csv')" | eider
    ```
3.  **Query File**: Use the `-i` or `--query-path` flag to execute complex SQL scripts.
    ```bash
    eider -i analysis_script.sql
    ```

### Using Template Parameters
Eider allows for dynamic SQL generation using placeholders. Placeholders must follow the `${key}` format within your SQL file.

**Template (template.sql):**
```sql
SELECT ${column} FROM ${table} WHERE status = '${status_val}';
```

**Execution:**
```bash
eider -i template.sql -p column=user_id -p table=users -p status_val=active
```

### Connection Management
By default, eider connects to an in-memory DuckDB instance (`jdbc:duckdb:`). To work with a persistent database file, specify the JDBC URL:
```bash
eider -u "jdbc:duckdb:my_database.db" -q "SELECT * FROM my_table"
```

## Expert Tips and Best Practices

*   **Sensitive Data**: Use the `--skip-history` flag when executing queries containing passwords, tokens, or PII to prevent them from being saved to `~/.eider_history`.
*   **Formatting**: If your SQL relies on specific formatting or you are debugging complex joins, use `--preserve-whitespace` to ensure the query is passed to the engine exactly as written.
*   **Debugging**: Enable `--verbose` to see additional logging messages, which is helpful for troubleshooting JDBC connection issues or parameter replacement errors.
*   **Parquet Integration**: Since DuckDB is highly optimized for Parquet, use eider as a fast inspector for Parquet files without needing to write a full Python or R script.
    ```bash
    eider -q "SELECT * FROM 'file.parquet' WHERE 1=0" # Quick schema check
    ```



## Subcommands

| Command | Description |
|---------|-------------|
| eider | Bash completion support for the `eider` command |
| eider | Eider is a command-line tool for interacting with databases using SQL queries. |

## Reference documentation
- [eider GitHub Repository](./references/github_com_heuermh_eider.md)
- [eider README](./references/github_com_heuermh_eider_blob_main_README.md)