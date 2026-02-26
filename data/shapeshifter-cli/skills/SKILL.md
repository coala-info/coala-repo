---
name: shapeshifter-cli
description: "shapeshifter-cli converts, queries, and subsets diverse functional-genomics file formats into formats compatible with analysis tools like R, Python, or Excel. Use when user asks to convert gene-expression matrices between formats, filter rows using logical expressions, select specific columns, or transpose tabular data."
homepage: https://github.com/srp33/ShapeShifter-CLI
---


# shapeshifter-cli

## Overview
The `shapeshifter-cli` (primarily accessed via the `expressionable` or `ea` command) is designed to bridge the gap between diverse functional-genomics file formats and analysis tools like R, Python, or Excel. It allows for efficient data translation, enabling users to convert, query, and subset large tabular files without writing custom parsing scripts. It is particularly useful for handling gene-expression matrices and outputs from tools like Kallisto, Salmon, and GEO.

## Basic Usage
The tool relies on two positional arguments: the input file and the output file. It automatically infers file types based on extensions.

```bash
# Basic conversion from Excel to TSV
expressionable input_data.xlsx output_data.tsv

# Using the 'ea' alias
ea input_data.csv output_data.parquet
```

## Core Command Options
If file extensions are missing or non-standard, specify types explicitly:

- `-i, --input_file_type`: Specify input format (e.g., CSV, TSV, JSON, Excel, HDF5, Parquet, GCT, Kallisto, Salmon, GEO).
- `-o, --output_file_type`: Specify output format (e.g., CSV, TSV, Parquet, SQLite, ARFF, GCT, RMarkdown, JupyterNotebook).
- `-t, --transpose`: Swap rows and columns in the output.
- `-s, --set_index`: Define a specific column as the index/row names.
- `-g, --gzip`: Compress the output file.

## Filtering and Column Selection
You can subset data during the transformation process using Python-style logic.

### Filtering Rows
Use the `-f` flag followed by a quoted Python logical expression. Note that by default, only the columns used in the filter will be exported unless additional columns are specified.
```bash
expressionable -f "Gene_Value > 15.0 and (Status == 'Active' or Status == 'Treated')" input.tsv output.tsv
```

### Selecting Columns
- `-c, --columns`: A comma-separated list (no spaces) of specific columns to include.
- `-a, --all_columns`: Overrides default behavior to include every column from the source file.

```bash
# Filter rows and include specific extra columns
expressionable -f "Expression > 10" -c GeneID,Symbol,p_value input.csv output.csv

# Filter rows but keep all original columns
expressionable -f "Control == 1" -a input.tsv output.tsv
```

## Supported Formats
- **Input**: CSV, TSV, JSON, Excel, HDF5, Parquet, MsgPack, Stata, Pickle, SQLite, ARFF, GCT, GCTX, PDF, Gene Expression Omnibus (GEO), Kallisto, Salmon, STAR, HT-Seq, CBio Portal.
- **Output**: CSV, TSV, JSON, Excel, HDF5, Parquet, MsgPack, Stata, Pickle, SQLite, ARFF, GCT, RMarkdown, Jupyter Notebook.

## Expert Tips
- **Notebook Generation**: Exporting to `.ipynb` (Jupyter) or `.Rmd` (RMarkdown) creates a template for further analysis of the transformed data.
- **Gzipped Inputs**: The tool natively reads `.gz` files; you do not need to decompress them manually before running `expressionable`.
- **Index Handling**: When working with GCT or gene matrices, always verify if the first column should be set as the index using `-s` to ensure downstream tools read the matrix correctly.

## Reference documentation
- [ExpressionAble-CLI GitHub Repository](./references/github_com_srp33_ExpressionAble-CLI.md)