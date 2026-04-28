---
name: csvkit
description: csvkit is a suite of command-line utilities for processing, transforming, and analyzing tabular data. Use when user asks to convert files to CSV, filter rows and columns, join datasets, generate summary statistics, or execute SQL queries on flat files.
homepage: https://github.com/wireservice/csvkit
metadata:
  docker_image: "ghcr.io/wireservice/csvkit:latest"
---


# csvkit

## Overview
csvkit is a powerful suite of command-line tools designed to handle tabular data with the same philosophy as classic Unix text-processing utilities. It excels at transforming messy data into clean CSVs, extracting specific subsets of information, and bridging the gap between flat files and relational databases. Use this skill to perform complex data manipulation tasks—such as joining files, generating statistics, or converting Excel/JSON to CSV—using efficient, pipeable CLI commands.

## Core Toolset & Workflows

### 1. Conversion and Input
*   **Convert Excel/JSON to CSV**: Use `in2csv` to standardize input.
    *   `in2csv data.xlsx > data.csv`
    *   `in2csv data.json > data.csv`
*   **SQL to CSV**: Use `sql2csv` to pull data from databases.
    *   `sql2csv --db postgresql:///database --query "SELECT * FROM table" > data.csv`

### 2. Inspection and Cleaning
*   **Examine Structure**: Use `csvcut -n` to see column names and indices.
*   **Preview Data**: Use `csvlook` to render a pretty-printed table.
    *   `csvcut -c 1,3 data.csv | csvlook | head`
*   **Validate and Fix**: Use `csvclean` to find and fix common syntax errors (e.g., mismatched column counts).
    *   `csvclean -a data.csv` (Enables all checks)

### 3. Processing and Filtering
*   **Select Columns**: Use `csvcut` to filter or reorder columns by name or index.
    *   `csvcut -c "ID","User Name",3 data.csv`
*   **Filter Rows**: Use `csvgrep` for string or regex matching.
    *   `csvgrep -c "State" -m "IL" data.csv` (String match)
    *   `csvgrep -c 1 -r "^I" data.csv` (Regex match)
*   **Sort Data**: Use `csvsort` for type-aware sorting.
    *   `csvsort -c "Date" data.csv`

### 4. Analysis and Transformation
*   **Summary Statistics**: Use `csvstat` for a quick data profile (mean, median, unique values, etc.).
    *   `csvstat data.csv`
*   **SQL Queries on CSV**: Use `csvsql` to run complex queries directly on files.
    *   `csvsql --query "SELECT name, SUM(total) FROM data GROUP BY name" data.csv`
*   **Merge Files**: Use `csvjoin` for SQL-like joins (inner, left, right, outer).
    *   `csvjoin -c "id" file1.csv file2.csv`
*   **Stack Files**: Use `csvstack` to append multiple CSVs with the same schema.
    *   `csvstack file1.csv file2.csv > combined.csv`

## Expert Tips & Best Practices
*   **Disable Inference for Speed**: On large files, use `-I` or `--no-inference` to prevent csvkit from guessing data types, which significantly speeds up processing.
*   **Handle Non-Standard CSVs**: Use common arguments to handle different dialects:
    *   `-t` for tabs.
    *   `-d "|"` for pipe-delimited.
    *   `-e "latin1"` for specific encodings.
*   **Piping is Key**: Chain commands to build complex pipelines.
    *   `in2csv data.xlsx | csvcut -c 1,5 | csvgrep -c 1 -m "Active" | csvstat`
*   **Output Formatting**: Use `csvformat` as the final step in a pipeline to change the output delimiter or line endings for legacy systems.
    *   `csvformat -D "|" data.csv > pipe_delimited.csv`
*   **Sniffing Limits**: If a file has a messy header, use `--snifflimit 0` to disable automatic format detection and manually specify the delimiter.



## Subcommands

| Command | Description |
|---------|-------------|
| csvclean | Report and fix common errors in a CSV file. |
| csvcut | Filter and truncate CSV files. Like the Unix "cut" command, but for tabular data. |
| csvformat | Convert a CSV file to a custom output format. |
| csvgrep | Search CSV files. Like the Unix "grep" command, but for tabular data. |
| csvjoin | Execute a SQL-like join to merge CSV files on a specified column or columns. |
| csvlook | Render a CSV file in the console as a Markdown-compatible, fixed-width table. |
| csvsort | Sort CSV files. Like the Unix "sort" command, but for tabular data. |
| csvsql | Generate SQL statements for one or more CSV files, or execute those statements directly on a database, and execute one or more SQL queries. |
| csvstack | Stack up the rows from multiple CSV files, optionally adding a grouping value. |
| csvstat | Print descriptive statistics for each column in a CSV file. |
| in2csv | Convert common, but less awesome, tabular data formats to CSV. |

## Reference documentation
- [Common arguments](./references/csvkit_readthedocs_io_en_latest_common_arguments.html.md)
- [csvcut reference](./references/csvkit_readthedocs_io_en_latest_scripts_csvcut.html.md)
- [csvsql reference](./references/csvkit_readthedocs_io_en_latest_scripts_csvsql.html.md)
- [csvstat reference](./references/csvkit_readthedocs_io_en_latest_scripts_csvstat.html.md)
- [csvclean reference](./references/csvkit_readthedocs_io_en_latest_scripts_csvclean.html.md)
- [Tips and Troubleshooting](./references/csvkit_readthedocs_io_en_latest_tricks.html.md)