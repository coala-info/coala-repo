---
name: datamash
description: GNU Datamash is a command-line utility designed to perform basic numeric, textual, and statistical operations on input text files.
homepage: https://github.com/agordon/datamash
---

# datamash

## Overview
GNU Datamash is a command-line utility designed to perform basic numeric, textual, and statistical operations on input text files. It is highly efficient for "group by" operations, allowing you to collapse rows based on a key column and calculate metrics like sums, averages, or counts on associated data columns. It serves as a bridge between raw text data and structured analysis, fitting perfectly into Unix-style pipelines.

## Core CLI Patterns

### Basic Summary Statistics
Perform operations on specific columns (fields) across the entire file.
```bash
# Calculate sum and mean of the first column
seq 10 | datamash sum 1 mean 1

# Calculate statistics on multiple columns
datamash min 1 max 1 median 2 < data.tsv
```

### Grouping and Aggregation
The most common use case is aggregating data based on a specific field.
```bash
# Group by column 2, calculate average of column 3
# Note: Input must be sorted by the grouping column; --sort handles this automatically
datamash --sort --group 2 mean 3 < scores.txt

# Group by multiple columns (e.g., 1 and 2)
datamash -s -g 1,2 sum 3 < data.tsv
```

### Textual Operations
Datamash can also manipulate strings and unique values.
```bash
# Collapse all values in column 2 into a comma-separated list, grouped by column 1
datamash -s -g 1 collapse 2 < data.txt

# Count unique values in column 2 per group in column 1
datamash -s -g 1 countunique 2 < data.txt

# Remove lines with duplicate keys in column 1
datamash rmdup 1 < data.txt
```

### Data Transformation
```bash
# Transpose a matrix (swap rows and columns)
datamash transpose < matrix.txt

# Create a pivot table (crosstab) between column 1 and 2
datamash crosstab 1,2 < data.txt
```

## Expert Tips and Best Practices

- **Sorting**: Datamash requires input to be sorted by the grouping field for `--group` to work correctly. Use the `--sort` (or `-s`) flag to let datamash handle this, or pipe from the system `sort` command for more control.
- **Headers**: If your file has a header row, use `--headers` (or `-H`). This ensures the header is ignored during calculation and preserved in the output.
- **Field Separators**: By default, datamash expects tabs. Use `-t` or `--field-separator` to specify a different delimiter (e.g., `-t ','` for CSV).
- **Column Naming**: When using `-H`, you can often refer to columns by their names instead of indices.
- **Precision**: For scientific data, use `--round` to limit decimal places in the output.
- **Statistical Operations**:
    - `sstdev` / `svar`: Sample standard deviation/variance.
    - `pstdev` / `pvar`: Population standard deviation/variance.
    - `mad`: Median Absolute Deviation.
    - `antimode`: Finds the least frequent value.

## Reference documentation
- [GNU Datamash README](./references/github_com_agordon_datamash.md)
- [Datamash Commit History (Operation details)](./references/github_com_agordon_datamash_commits_master.md)