---
name: xsv
description: `xsv` is a specialized command-line toolkit designed for the rapid manipulation and analysis of CSV files.
homepage: https://github.com/BurntSushi/xsv
---

# xsv

## Overview
`xsv` is a specialized command-line toolkit designed for the rapid manipulation and analysis of CSV files. It is built for speed and can handle massive datasets that typically overwhelm standard spreadsheet applications. By utilizing optional indexing, `xsv` provides constant-time access to records, making it perfect for slicing, counting, and searching through millions of rows. Use this skill to inspect data structures, filter columns, merge datasets, or generate descriptive statistics with minimal resource overhead.

## Core Workflows

### 1. Initial Data Inspection
Before processing, always check the structure and data quality:
- **View Headers**: `xsv headers data.csv`
- **Generate Statistics**: `xsv stats data.csv --everything | xsv table`
- **Check Frequencies**: `xsv frequency --limit 10 data.csv` (identifies common values and potential outliers)

### 2. Performance Optimization
For files larger than a few hundred megabytes, create an index to enable constant-time slicing and faster statistics:
- **Create Index**: `xsv index data.csv` (creates a companion `data.csv.idx` file)
- **Fast Slicing**: `xsv slice -s 1000 -l 10 data.csv` (extracts 10 rows starting at index 1000 instantly)

### 3. Data Transformation and Filtering
- **Select Columns**: `xsv select Column1,Column3 data.csv` (supports names or indices)
- **Regex Search**: `xsv search "pattern" data.csv` (applies regex to each field)
- **Reformat Delimiters**: `xsv fmt -t '\t' data.csv` (converts CSV to TSV)
- **Fix Lengths**: `xsv fixlengths data.csv` (pads or truncates records to ensure every row matches the header length)

### 4. Combining Datasets
- **Join Files**: `xsv join id_col file1.csv id_col file2.csv` (supports inner, outer, and cross joins)
- **Concatenate**: `xsv cat rows file1.csv file2.csv` (stacking) or `xsv cat columns file1.csv file2.csv` (side-by-side)

## Expert Tips
- **Piping to Table**: Always append `| xsv table` when viewing output in the terminal to ensure columns are aligned and readable for humans.
- **Random Sampling**: Use `xsv sample 100 data.csv` to get a representative subset of data for testing scripts without processing the full file.
- **Flattening**: Use `xsv slice -i 0 data.csv | xsv flatten` to view a single record as a vertical list of key-value pairs. This is significantly easier to read than a horizontal row for wide CSVs.
- **Memory Efficiency**: Most `xsv` commands use a streaming approach. Only `sort` and `stats` (when run without an index) require memory proportional to the number of rows.
- **Partitioning**: Use `xsv partition column_name dir/ data.csv` to split a large file into multiple files based on the values in a specific column.

## Reference documentation
- [xsv README and Command Guide](./references/github_com_BurntSushi_xsv.md)