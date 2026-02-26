---
name: eider
description: eider is a command-line interface for DuckDB that enables high-performance SQL query execution and data processing on files or persistent databases. Use when user asks to execute SQL queries on Parquet or CSV files, run parameterized SQL templates, or manage DuckDB databases from the terminal.
homepage: https://github.com/heuermh/eider
---


# eider

## Overview

eider is a specialized command-line interface for DuckDB that facilitates high-performance data processing within a terminal environment. It allows users to execute SQL queries directly against files (such as Parquet or CSV) or persistent DuckDB databases. By supporting SQL templates with runtime parameters, eider enables the creation of reusable data transformation scripts that can be easily integrated into larger bioinformatics workflows.

## Command Line Usage

### Basic Query Execution
Execute SQL directly from the command line using the `-q` or `--query` flag. By default, eider uses an in-memory DuckDB instance.

```bash
eider -q "SELECT * FROM 'data.parquet' LIMIT 5"
```

### Working with SQL Files
For complex queries, store the SQL in a file and reference it with `-i` or `--query-path`.

```bash
eider -i analysis.sql
```

Alternatively, pipe queries into eider via stdin:

```bash
echo "SELECT count(*) FROM 'samples.parquet'" | eider
```

### SQL Templating with Parameters
eider supports `${key}` style placeholders in SQL files. Use the `-p` or `--parameters` flag to inject values at runtime. This is highly effective for creating generic scripts for different datasets.

```bash
# template.sql: SELECT * FROM ${table} WHERE quality > ${min_q}
eider -i template.sql -p table=variants.parquet -p min_q=30
```

### Persistent Databases
To work with a local DuckDB database file instead of an in-memory instance, specify the JDBC connection URL.

```bash
eider -u "jdbc:duckdb:my_bio_data.db" -q "SELECT * FROM gene_expressions"
```

## Best Practices and Tips

- **Query History**: eider saves queries to `~/.eider_history`. If you are working with sensitive data or want to keep your history clean during automated loops, use the `--skip-history` flag.
- **Whitespace Preservation**: If your SQL relies on specific formatting or you are debugging complex nested queries, use `--preserve-whitespace` to ensure the query is passed exactly as written.
- **Bioinformatics Integration**: Since eider is available via Bioconda, it is best used as a "glue" tool to query the output of other bioinformatics tools (like Parquet files generated from VCFs or BAMs) within a shell script.
- **Logging**: Use `--verbose` when debugging connection issues or parameter injection to see additional logging messages.

## Reference documentation
- [eider GitHub Repository](./references/github_com_heuermh_eider.md)
- [eider Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_eider_overview.md)