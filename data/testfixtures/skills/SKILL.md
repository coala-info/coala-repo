---
name: testfixtures
description: testfixtures is a Go library designed to simplify functional testing by managing database state through YAML files.
homepage: https://github.com/go-testfixtures/testfixtures
---

# testfixtures

## Overview
testfixtures is a Go library designed to simplify functional testing by managing database state through YAML files. It mimics the Ruby on Rails approach: before each test, it wipes the specified tables and populates them with predefined fixture data. This allows developers to write tests against a real database rather than relying on complex mocks, ensuring that database-specific behavior and constraints are actually exercised during the test suite.

## Usage and Best Practices

### Database Initialization
To use testfixtures, you must first initialize a `Loader`. The loader requires a database connection and a specific dialect to handle the nuances of different SQL engines.

*   **Supported Dialects**: `postgresql`, `timescaledb`, `mysql`, `mariadb`, `sqlite`, `sqlserver`, `clickhouse`, and `spanner`.
*   **Safety Mechanism**: By default, the tool refuses to run if the database name does not contain "test" to prevent accidental data loss in production. Use `testfixtures.DangerousSkipTestDatabaseCheck()` to override this if necessary.

### Loading Strategies
*   **Directory Loading**: Use `testfixtures.Directory("path/to/fixtures")` to load all `.yml` files in a folder. Each file name must match the target table name.
*   **Specific Files**: Use `testfixtures.Files("file1.yml", "file2.yml")` for granular control over which tables are populated.
*   **Mixed Paths**: Use `testfixtures.Paths("dir/", "file.yml")` to combine directory and individual file loading.
*   **Multi-Table Files**: Use `testfixtures.FilesMultiTables("data.yml")` if you prefer to define multiple tables within a single YAML file.

### Data Handling and Type Conversion
The tool automatically handles complex Go types and SQL columns:
*   **JSON**: YAML objects or arrays are automatically converted to JSON/JSONB for PostgreSQL/CockroachDB or text types for others.
*   **Binary Data**: Represent binary columns as hexadecimal strings starting with `0x` (e.g., `0x1234`).
*   **Dates/Times**: Strings matching standard date/time formats are automatically converted to `time.Time`.
*   **Raw SQL**: To call database functions or prevent automatic conversion, prefix the value with `RAW=`. This is essential for `NOW()`, UUID generation functions, or PostGIS types.

### Integration with Go Tests
*   **TestMain Setup**: Initialize the `Loader` once in `TestMain` to avoid the overhead of re-parsing fixtures for every test.
*   **Pre-test Cleanup**: Call `loader.Load()` inside a setup function at the start of every test case. This ensures a consistent, predictable database state regardless of previous test outcomes.
*   **Template Usage**: If using templates within fixtures, ensure the order of options is correct, as the tool processes them sequentially.

## Reference documentation
- [github_com_go-testfixtures_testfixtures.md](./references/github_com_go-testfixtures_testfixtures.md)