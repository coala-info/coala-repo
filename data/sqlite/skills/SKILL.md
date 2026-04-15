---
name: sqlite
description: This tool provides a high-level interface for database administration, schema design, and data manipulation using the DB Browser for SQLite ecosystem. Use when user asks to create tables, import or export data, modify database schemas, perform integrity checks, or visualize data through plots and filters.
homepage: https://github.com/sqlitebrowser/sqlitebrowser
metadata:
  docker_image: "quay.io/biocontainers/sqlite:3.33.0"
---

# sqlite

## Overview
The `sqlite` skill leverages the DB Browser for SQLite (DB4S) ecosystem to provide a high-level interface for database administration. Unlike standard command-line clients, this approach emphasizes visual schema design and spreadsheet-like data manipulation while maintaining full support for complex SQL operations. Use this skill to streamline the creation of tables and indexes, import/export data across various formats, and perform health checks on database files.

## Command Line Usage
The `sqlitebrowser` executable supports several flags for automated or specific startup behaviors:

- **Open a database**: `sqlitebrowser path/to/database.db`
- **Read-only mode**: `sqlitebrowser -r path/to/database.db` (Prevents accidental writes to production data)
- **Load a project**: `sqlitebrowser path/to/project.sqbpro` (Restores previous SQL tabs and UI state)
- **Attach multiple databases**: Pass multiple file paths to open them in the same session.

## Data Management Patterns

### Importing Data
- **CSV Import**: Use the "Import Table from CSV file" wizard. Ensure "Column names in first line" is checked for automatic schema generation.
- **SQL Dumps**: Use "Import Database from SQL file" to reconstruct databases from text-based backups.

### Exporting Data
- **SQL Dump**: Export the entire database or specific tables to a `.sql` file for migration to other SQL engines (e.g., PostgreSQL, MySQL).
- **CSV/JSON**: Use for sharing data with non-database applications or web frontends.

### Schema Modification
- **Table Design**: Use the "Edit Table" dialog to add, modify, or delete columns without manually writing `ALTER TABLE` statements, which are limited in standard SQLite.
- **Compacting**: Use "Compact Database" to run the `VACUUM` command, reducing file size and defragmenting the database.

## Advanced Filtering and Visualization

### Browse Data Tab
- **Multi-Column Sort**: Hold `Ctrl` (or `Cmd`) while clicking column headers to define primary, secondary, and tertiary sort orders.
- **Dynamic Filters**:
    - **Numeric**: Use operators like `>100`, `<=50`, or `10...50` for ranges.
    - **Text**: Use `LIKE %term%` for partial matches.
    - **Regex**: Enable "Use Regular Expressions" in the filter context menu for complex pattern matching (e.g., `^[0-9]{3}-` for area codes).

### Plotting
- Use the **Plot Dock** to generate simple visual graphs (Line, Bar, or Pie) directly from table data or the results of an SQL query.

## Database Maintenance
- **Integrity Check**: Regularly run "Integrity Check" from the "Tools" menu to execute `PRAGMA integrity_check` and ensure no file corruption exists.
- **Encryption**: When using the SQLCipher-enabled version, you can set or change database keys via the "Set Password" option under the "File" menu.
- **Transaction Management**: By default, changes are cached. Use "Write Changes" (`Ctrl+S`) to commit or "Revert Changes" to roll back to the last saved state.

## Reference documentation
- [Home Wiki](./references/github_com_sqlitebrowser_sqlitebrowser_wiki.md)
- [Browse Data Guide](./references/github_com_sqlitebrowser_sqlitebrowser_wiki_Browse-Data.md)
- [Using Filters](./references/github_com_sqlitebrowser_sqlitebrowser_wiki_Using-the-Filters.md)
- [Regular Expressions](./references/github_com_sqlitebrowser_sqlitebrowser_wiki_Regular-Expressions.md)
- [Transactions](./references/github_com_sqlitebrowser_sqlitebrowser_wiki_Transactions.md)