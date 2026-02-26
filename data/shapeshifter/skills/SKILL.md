---
name: shapeshifter
description: Shapeshifter is a high-performance utility for converting, filtering, and manipulating functional genomics data across various file formats. Use when user asks to convert file formats, filter genomic data by specific criteria, transpose matrices, or export data to Jupyter notebooks.
homepage: https://github.com/srp33/ShapeShifter
---


# shapeshifter

## Overview

Shapeshifter (interfaced via the `expressionable` command) is a high-performance utility designed to handle the "cacophony" of file formats found in functional genomics. It simplifies the data preparation pipeline by providing a unified interface for format conversion, data subsetting, and matrix manipulation. Whether you are moving data from a Gene Expression Omnibus (GEO) file into a Jupyter Notebook or merging multiple TSV files into a single HDF5 archive, this tool automates the translation and filtering logic that would otherwise require custom scripting.

## Core CLI Usage

The primary command is `expressionable` (aliased as `ea`).

### Basic Format Conversion
Shapeshifter automatically infers file types from extensions.
```bash
expressionable input_data.xlsx output_data.tsv
```

### Explicit Format Specification
If using non-standard extensions, use the `-i` (input) and `-o` (output) flags.
- **Supported Inputs:** CSV, TSV, JSON, Excel, HDF5, Parquet, MsgPack, Stata, Pickle, SQLite, ARFF, GCT, GCTX, PDF, GEO, Kallisto, Salmon, STAR, HT-Seq, CBio Portal.
- **Supported Outputs:** CSV, TSV, JSON, Excel, HDF5, Parquet, MsgPack, Stata, Pickle, SQLite, ARFF, GCT, RMarkdown, JupyterNotebook.

```bash
expressionable -i GCT -o Parquet input_file.txt output_file.parquet
```

### Filtering and Column Selection
Filters use Python logical syntax and must be enclosed in quotes. By default, only the columns used in the filter are exported unless specified otherwise.

- **Apply Filter:** `expressionable -f "Gene_Symbol == 'TP53' and Expression > 10.5" input.tsv output.tsv`
- **Include Specific Columns:** `expressionable -f "Age > 50" -c PatientID,TissueType input.csv output.csv`
- **Keep All Columns:** `expressionable -f "Condition == 'Control'" -a input.csv output.csv`

### Matrix Manipulation
- **Transpose:** Use `-t` to swap rows (samples) and columns (variables). This is common when moving between R-style and Python-style data orientations.
- **Set Index:** Use `-s` to define a specific column as the index/row identifier.
- **Compression:** Use `-g` to gzip the output file.

## Expert Tips

- **Gzip Transparency:** The tool can read `.gz` files natively without manual decompression.
- **Notebook Generation:** You can export directly to `.ipynb` or `.Rmd` formats to jumpstart your analysis with the data already loaded.
- **Python Integration:** For complex workflows, use the `ExpressionAble` class directly in Python:
  ```python
  from expressionable import ExpressionAble
  obj = ExpressionAble("data.tsv")
  obj.export_filter_results("output.h5", filters="Sex == 'M'")
  ```

## Reference documentation

- [ExpressionAble-CLI](./references/github_com_srp33_ExpressionAble-CLI.md)
- [ExpressionAble Python Module](./references/github_com_srp33_ExpressionAble.md)