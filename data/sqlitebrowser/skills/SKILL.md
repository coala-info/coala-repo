---
name: sqlitebrowser
description: DB Browser for SQLite is a graphical interface for managing, designing, and editing SQLite-compatible database files. Use when user asks to browse database records, modify table schemas, run SQL queries, or import data from CSV files.
homepage: https://github.com/sqlitebrowser/sqlitebrowser
---


# sqlitebrowser

## Overview

DB Browser for SQLite (DB4S) is a visual, open-source tool for working with SQLite-compatible database files. It bridges the gap between raw SQL command-line interfaces and spreadsheet applications, allowing you to browse data, design tables, and run queries through a structured GUI. This skill provides guidance on leveraging its interface for efficient database management, data visualization, and schema design.

## Command Line Usage

While primarily a GUI application, `sqlitebrowser` supports several command-line arguments for automation and quick access:

- **Open a database**: `sqlitebrowser path/to/database.db`
- **Open multiple databases**: `sqlitebrowser db1.db db2.db`
- **Open in Read-Only mode**: `sqlitebrowser -r path/to/database.db` (Prevents accidental "Write Changes" operations)
- **Open a Project file**: `sqlitebrowser path/to/project.sqbpro` (Restores your SQL tabs and filters)

## Expert Tips and Best Practices

### Data Management and Browsing
- **Multi-Column Sorting**: In the "Browse Data" tab, hold `Ctrl` (or `Cmd` on macOS) while clicking column headers to sort by multiple fields simultaneously.
- **Regular Expression Filtering**: The filter row at the top of the "Browse Data" tab supports standard SQL wildcards and, if enabled, Regular Expressions for complex data lookups.
- **Display Formats**: Use "Edit Display Format" on a column to transform data visually (e.g., converting Unix timestamps to readable dates or displaying BLOBs as images/hex) without altering the actual database values.

### Schema Design
- **Table Modification**: Use the "Modify Table" dialog instead of manual `ALTER TABLE` statements. DB4S handles the complex background process of creating temporary tables and migrating data for SQLite versions that don't support certain `ALTER` operations.
- **Compact Database**: Regularly use "Compact Database" (VACUUM) to reduce file size and defragment the database after large deletions.

### Workflow Efficiency
- **Transactions**: Remember that changes made in the GUI are stored in a memory buffer. You must click **Write Changes** to commit them to the disk or **Revert Changes** to discard them.
- **Project Files (.sqbpro)**: Always save your work as a Project file if you are writing complex SQL queries or have configured specific filters. This saves your SQL scripts, open tabs, and display settings.
- **CSV Import Wizard**: When importing CSVs, use the "Import -> Table from CSV file" option. It provides a preview and allows you to define column types and skip rows, which is safer than raw SQL imports.

### Advanced Features
- **Plotting**: Use the "Plot Dock" to create simple graphs (Line, Bar, etc.) directly from your table data or query results for quick visual analysis.
- **SQLCipher Support**: If using the SQLCipher-enabled version, you can open and create encrypted databases by providing the key in the password prompt upon opening the file.

## Reference documentation
- [DB Browser for SQLite Home](./references/github_com_sqlitebrowser_sqlitebrowser.md)
- [Wiki Home](./references/github_com_sqlitebrowser_sqlitebrowser_wiki.md)
- [Browse Data Guide](./references/github_com_sqlitebrowser_sqlitebrowser_wiki_Browse-Data.md)
- [Keyboard Shortcuts](./references/github_com_sqlitebrowser_sqlitebrowser_wiki_Keyboard-shortcuts.md)
- [Transactions and Changes](./references/github_com_sqlitebrowser_sqlitebrowser_wiki_Transactions.md)