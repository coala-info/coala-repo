---
name: datamash
description: GNU Datamash is a command-line utility for performing basic numeric, textual, and statistical operations on structured text files. Use when user asks to perform group-by operations, calculate statistics like mean or sum, transpose matrices, or create crosstab tables from delimited data.
homepage: https://github.com/agordon/datamash
---


# datamash

## Overview
GNU Datamash is a powerful command-line utility designed for rapid data analysis. It bridges the gap between basic Unix tools like `grep`/`sed`/`awk` and full-scale statistical environments. You should use this skill to process structured text data where you need to perform group-by operations, basic statistical calculations, or matrix transformations (like transposing) with high performance and minimal syntax.

## Core CLI Patterns

### Basic Aggregation
To perform a calculation on a specific column (e.g., column 1):
```bash
datamash sum 1 mean 1 < data.txt
```

### Grouping Data (Group-By)
Datamash requires input to be sorted by the grouping column unless the `--sort` flag is used.
```bash
# Group by column 2, calculate mean of column 3
datamash --sort --group 2 mean 3 < scores.txt
```

### Common Operations
- **Numeric**: `sum`, `min`, `max`, `absmin`, `absmax`
- **Statistical**: `mean`, `median`, `mode`, `stdev`, `sstdev` (sample), `pstdev` (population), `perc:95` (95th percentile)
- **Textual**: `unique`, `collapse`, `count`, `first`, `last`

### Working with Headers
If your file has a header row, use the `--headers` (or `-H`) flag to preserve it or use field names.
```bash
datamash --headers --group "Department" sum "Salary" < employees.csv
```

### Table Transformations
- **Transpose**: Swap rows and columns.
  ```bash
  datamash transpose < matrix.txt
  ```
- **Reverse**: Reverse the order of fields in each line.
  ```bash
  datamash reverse < data.txt
  ```

## Expert Tips

1. **Field Delimiters**: By default, datamash expects tabs. Use `-t ','` for CSV files or `-t ' '` for space-delimited data.
2. **Multiple Operations**: You can chain multiple operations in a single command: `datamash min 1 max 1 mean 1`.
3. **Handling Missing Data**: Use `--narm` to ignore missing/empty values in calculations.
4. **Rounding**: Use `-R [N]` to round results to N decimal places.
5. **Crosstab/Pivoting**: Use the `crosstab` command to create a contingency table from two columns.
   ```bash
   datamash crosstab 1,2 < data.txt
   ```



## Subcommands

| Command | Description |
|---------|-------------|
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |
| datamash | Performs numeric/string operations on input from stdin. |

## Reference documentation
- [GNU Datamash README](./references/github_com_agordon_datamash_blob_master_README.md)
- [Hacking and Building Datamash](./references/github_com_agordon_datamash_blob_master_HACKING.md)