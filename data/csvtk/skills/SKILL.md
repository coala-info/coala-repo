---
name: csvtk
description: csvtk is a high-performance, header-aware toolkit for processing and manipulating tabular data in CSV and TSV formats. Use when user asks to inspect headers, filter rows, join files, reshape data between wide and long formats, or convert between CSV and other formats like JSON and XLSX.
homepage: https://github.com/shenwei356/csvtk
---


# csvtk

## Overview
csvtk is a high-performance, multi-functional toolkit written in Go, designed to handle tabular data manipulation with ease. Unlike standard Unix tools like `awk` or `sed`, csvtk is "header-aware," meaning it understands column names and preserves them during operations. It is particularly useful for data scientists and bioinformaticians who need to perform rapid data investigation, cleaning, and reshaping within a terminal environment or automated pipeline.

## Core Usage Patterns

### Global Flags
- `-t`: Use for TSV (tab-separated) input and output.
- `-H`: Use if the input data does not have a header row.
- `-l`: Use if the CSV has a "meta line" (e.g., `sep=,`).

### Field Selection (`-f`)
Most subcommands use the `-f` flag to specify columns:
- **By Name**: `csvtk cut -f id,name,date data.csv`
- **By Index**: `csvtk cut -f 1,2,5 data.csv`
- **Ranges**: `csvtk cut -f 1-5,10 data.csv`
- **Unselecting**: `csvtk cut -f -id,-name` (everything except id and name)
- **Fuzzy Matching**: Use `-F` with `-f` to use wildcards: `csvtk cut -F -f "sample_*"`

### Common Workflows

#### 1. Data Inspection
- **View Headers**: `csvtk headers data.csv`
- **Dimensions**: `csvtk dim data.csv` (rows and columns)
- **Pretty Print**: `csvtk pretty data.csv | head` (aligns columns for terminal viewing)
- **Summary Stats**: `csvtk summary -f price:mean,price:stdev -g category data.csv`

#### 2. Filtering and Searching
- **Grep by Column**: `csvtk grep -f status -p "Active" data.csv`
- **Arithmetic Filtering**: `csvtk filter2 -f "$price > 100 && $status == 'Active'"` (uses awk-like expressions)
- **Unique Records**: `csvtk uniq -f id data.csv`

#### 3. Transformation and Editing
- **Add New Column**: `csvtk mutate2 -n new_col -e '$col1 + $col2' data.csv`
- **Find and Replace**: `csvtk replace -f name -p "(.+)" -r "Prefix_$1" data.csv`
- **Reshaping**:
  - `csvtk gather -k Key -v Value -f col1,col2 data.csv` (Wide to Long)
  - `csvtk spread -k Key -v Value data.csv` (Long to Wide)
- **Sorting**: `csvtk sort -f "price:n,name" data.csv` (`:n` for numeric, `:r` for reverse)

#### 4. File Operations
- **Joining**: `csvtk join -f "id" file1.csv file2.csv` (Supports inner, left, and outer joins)
- **Concatenation**: `csvtk concat file1.csv file2.csv` (By rows)
- **Splitting**: `csvtk split -f category data.csv` (Creates files based on column values)

### Format Conversion
- **To Markdown**: `csvtk csv2md data.csv`
- **To JSON**: `csvtk csv2json data.csv`
- **To XLSX**: `csvtk csv2xlsx data.csv -o data.xlsx`
- **From XLSX**: `csvtk xlsx2csv data.xlsx`

## Expert Tips
- **Compression**: csvtk automatically detects and handles `.gz`, `.bz2`, `.xz`, `.zst`, and `.lz4` files for both input and output.
- **Piping**: Always use pipes to chain commands for efficiency: `csvtk cut -f 1,2 data.csv | csvtk filter2 -f '$1 > 10' | csvtk pretty`
- **Performance**: For very large files, `csvtk` is significantly faster than `csvkit` and many Python-based alternatives due to its Go implementation and multi-CPU support for specific commands.
- **Standard Input**: Use `-` to represent STDIN if needed, though most commands accept it by default.

## Reference documentation
- [csvtk GitHub Repository](./references/github_com_shenwei356_csvtk.md)
- [csvtk Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_csvtk_overview.md)