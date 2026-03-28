---
name: xsv
description: "xsv is a high-performance command-line toolkit for indexing, slicing, filtering, and transforming CSV files. Use when user asks to view headers, count records, calculate column statistics, filter rows with regex, select specific columns, join multiple CSV files, or sample data from large datasets."
homepage: https://github.com/BurntSushi/xsv
---

# xsv

## Overview
The `xsv` utility is a Rust-based toolkit designed for efficient CSV processing. It excels at handling large files that might crash standard spreadsheet software or slow down generic scripting languages. It follows the Unix philosophy of composability, allowing you to pipe CSV data between specialized subcommands to build complex data transformation pipelines without sacrificing performance.

## Core Commands and Usage

### Data Inspection and Statistics
*   **View Headers**: `xsv headers data.csv` (use `--justify` for aligned output).
*   **Quick Count**: `xsv count data.csv` (instantaneous if an index exists).
*   **Column Statistics**: `xsv stats data.csv --everything | xsv table` (provides mean, median, stddev, min/max, and cardinality).
*   **Frequency Tables**: `xsv frequency data.csv` (identifies common values and outliers).
*   **Pretty Printing**: Pipe any output to `xsv table` to view CSV data in aligned columns.

### Selection and Filtering
*   **Select Columns**: `xsv select Column1,Column3 data.csv` or use indices `xsv select 1-3,5 data.csv`.
*   **Regex Search**: `xsv search "pattern" data.csv` (searches all fields) or `xsv search -s Column "pattern" data.csv` (targeted search).
*   **Slicing Rows**: `xsv slice -s 100 -l 10 data.csv` (gets 10 rows starting from index 100).
*   **Random Sampling**: `xsv sample 100 data.csv` (uses reservoir sampling for memory efficiency).

### Transformation and Joining
*   **Sorting**: `xsv sort -s Column data.csv` (use `-N` for numeric sort).
*   **Joining Files**: `xsv join col_a file1.csv col_b file2.csv` (supports inner, left, right, and full outer joins).
*   **Concatenation**: `xsv cat rows file1.csv file2.csv` (vertical) or `xsv cat columns file1.csv file2.csv` (horizontal).
*   **Partitioning**: `xsv partition Column dir/ data.csv` (splits data into files based on column values).
*   **Splitting**: `xsv split out_dir/ -size 1000 data.csv` (chunks large files into smaller ones).

## Expert Tips
*   **Indexing**: For large files, run `xsv index data.csv` first. This creates a `.idx` file that makes `slice`, `count`, and `stats` operations nearly instantaneous.
*   **Performance**: `xsv` is multi-threaded for commands like `stats` and `frequency` when an index is present.
*   **Handling Delimiters**: Use the `-d` flag if your file uses something other than a comma (e.g., `xsv contents -d '\t' data.tsv`).
*   **Flattening**: Use `xsv flatten` to view a single record as a list of key-value pairs, which is helpful for debugging records with many columns.
*   **Fixing Lengths**: If a CSV is malformed with varying record lengths, use `xsv fixlengths` to pad or truncate records to match the header.



## Subcommands

| Command | Description |
|---------|-------------|
| xsv frequency | Compute a frequency table on CSV data. |
| xsv_cat | Concatenates CSV data by column or by row. |
| xsv_count | Prints a count of the number of records in the CSV data. |
| xsv_fixlengths | Transforms CSV data so that all records have the same length. The length is the length of the longest record in the data. Records with smaller lengths are padded with empty fields. |
| xsv_flatten | Prints flattened records such that fields are labeled separated by a new line. This mode is particularly useful for viewing one record at a time. Each record is separated by a special '#' character (on a line by itself), which can be changed with the --separator flag. There is also a condensed view (-c or --condense) that will shorten the contents of each field to provide a summary view. |
| xsv_fmt | Formats CSV data with a custom delimiter or CRLF line endings. |
| xsv_headers | Prints the fields of the first row in the CSV data. |
| xsv_index | Creates an index of the given CSV data, which can make other operations like slicing, splitting and gathering statistics much faster. |
| xsv_input | Read CSV data with special quoting rules. |
| xsv_join | Joins two sets of CSV data on the specified columns. |
| xsv_sample | Randomly samples CSV data uniformly using memory proportional to the size of the sample. |
| xsv_search | Filters CSV data by whether the given regex matches a row. |
| xsv_select | Select columns from CSV data efficiently. |
| xsv_slice | Returns the rows in the range specified (starting at 0, half-open interval). The range does not include headers. |
| xsv_sort | Sorts CSV data lexicographically. |
| xsv_split | Splits the given CSV data into chunks. |
| xsv_stats | Computes basic statistics on CSV data. |
| xsv_table | Outputs CSV data as a table with columns in alignment. |

## Reference documentation
- [GitHub - BurntSushi/xsv](./references/github_com_BurntSushi_xsv.md)