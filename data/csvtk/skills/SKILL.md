---
name: csvtk
description: csvtk is a high-performance, header-aware toolkit for manipulating, processing, and analyzing tabular data in CSV or TSV format. Use when user asks to filter rows, join files, select columns, generate summary statistics, or transform data formats.
homepage: https://github.com/shenwei356/csvtk
---

# csvtk

## Overview

`csvtk` is a cross-platform, high-performance toolkit written in Go for manipulating tabular data. It is designed to be "out-of-the-box" with no dependencies, making it ideal for rapid data investigation and integration into automated analysis pipelines. Unlike standard shell tools like `awk` or `cut`, `csvtk` is header-aware and supports complex field selection, including fuzzy matching and negative selection.

## Core Usage Patterns

### Global Flags
*   **TSV Support**: Use `-t` for tab-delimited input.
*   **No Headers**: Use `-H` if the input file lacks a header row.
*   **Lazy Quotes**: Use `-l` to handle messy data with bare double quotes.
*   **Output Control**: Use `-o` to specify an output file (supports `.gz` for automatic compression).

### Field Selection (`-f`)
`csvtk` provides powerful ways to select columns:
*   **By Index**: `-f 1,2,5` or ranges `-f 1-5`.
*   **By Name**: `-f id,name,age`.
*   **Negative Selection**: `-f -1` (all except first column) or `-f -id` (all except "id").
*   **Fuzzy/Regex**: Use `-F` with `-f` (e.g., `-F -f ".*_name"`).

## Common Workflows

### 1. Data Inspection
Quickly view data in a readable, aligned format:
```bash
csvtk pretty data.csv | head -n 15
```
Print column headers with their indices:
```bash
csvtk headers data.csv
```

### 2. Filtering and Searching
Filter rows using awk-like expressions (supports column names):
```bash
csvtk filter2 -f "$age > 20 && $status == 'active'" data.csv
```
Search for patterns in specific columns:
```bash
csvtk grep -f username -p "admin" data.csv
```

### 3. Transformation and Editing
Add a new column based on existing data using regex:
```bash
csvtk mutate -f name -p "^(\w)" -n initial data.csv
```
Replace data in a column:
```bash
csvtk replace -f status -p "0" -r "inactive" data.csv
```
Transpose a table:
```bash
csvtk transpose data.csv
```

### 4. Set Operations and Joins
Join two files on a common key:
```bash
csvtk join -f "id;id" file1.csv file2.csv
```
Concatenate multiple files by row:
```bash
csvtk concat file1.csv file2.csv
```

### 5. Statistics
Generate summary statistics grouped by a specific field:
```bash
csvtk summary -f price:sum,price:mean -g category data.csv
```

## Expert Tips
*   **Piping**: `csvtk` is designed for pipes. Use `-` to explicitly represent STDIN if needed.
*   **Performance**: For very large files, `csvtk` is significantly faster than `csvkit`.
*   **Messy Data**: If you encounter "bare quote" errors, try `csvtk fix-quotes` before processing.
*   **Format Conversion**: Use `csv2md` for GitHub-ready tables or `csv2json` for web integration.



## Subcommands

| Command | Description |
|---------|-------------|
| csvtk add-header | add column names |
| csvtk comb | compute combinations of items at every row |
| csvtk concat | concatenate CSV/TSV files by rows. Note that the second and later files are concatenated to the first one, so only columns match that of the first files kept. |
| csvtk corr | calculate Pearson correlation between two columns |
| csvtk csv2json | convert CSV to JSON format |
| csvtk csv2md | convert CSV to markdown format. csv2md treats the first row as header line and requires them to be unique |
| csvtk csv2rst | convert CSV to readable aligned table |
| csvtk csv2tab | convert CSV to tabular format |
| csvtk csv2xlsx | convert CSV/TSV files to XLSX file. Multiple CSV/TSV files are saved as separated sheets in .xlsx file. All input files should all be CSV or TSV. First rows are freezed unless given '-H/--no-header-row'. |
| csvtk cut | select and arrange fields |
| csvtk del-header | delete column names. It deletes the first lines of all input files. |
| csvtk del-quotes | remove extra double quotes added by 'fix-quotes' |
| csvtk dim | dimensions of CSV file |
| csvtk filter | filter rows by values of selected fields with arithmetic expression |
| csvtk filter2 | filter rows by awk-like arithmetic/string expressions |
| csvtk fix | fix CSV/TSV with different numbers of columns in rows by appending empty cells to rows with fewer columns |
| csvtk fix-quotes | fix malformed CSV/TSV caused by double-quotes to meet the RFC4180 specification |
| csvtk fmtdate | format date of selected fields |
| csvtk freq | frequencies of selected fields |
| csvtk grep | grep data by selected fields with patterns/regular expressions |
| csvtk head | print first N records |
| csvtk headers | print headers |
| csvtk inter | intersection of multiple files. Fields in all files should be the same. |
| csvtk join | join files by selected fields (inner, left and outer join). |
| csvtk mutate | create new column from selected fields by regular expression |
| csvtk ncol | print number of columns |
| csvtk nrow | print number of records |
| csvtk pretty | convert CSV to a readable aligned table |
| csvtk sample | sampling by proportion |
| csvtk space2tab | convert space delimited format to TSV |
| csvtk split | split CSV/TSV into multiple files according to column values |
| csvtk splitxlsx | split XLSX sheet into multiple sheets according to column values |
| csvtk summary | summary statistics of selected numeric or text fields (groupby group fields) |
| csvtk tab2csv | convert tabular format to CSV |
| csvtk uniq | unique data without sorting |
| csvtk watch | monitor the specified fields |
| csvtk xlsx2csv | convert XLSX to CSV format |

## Reference documentation
- [Usage and Examples](./references/bioinf_shenwei_me_csvtk_usage.md)
- [Tutorial: Analyzing OTU table](./references/bioinf_shenwei_me_csvtk_tutorial.md)
- [Frequently Asked Questions](./references/bioinf_shenwei_me_csvtk_faq.md)
- [Main README](./references/github_com_shenwei356_csvtk_blob_master_README.md)