---
name: cmappy
description: cmappy is a Python suite for processing and manipulating Connectivity Map data in GCT and GCTX formats. Use when user asks to parse or write GCT/GCTX files, perform memory-efficient subsetting of genomic matrices, or convert between biological data formats.
homepage: https://github.com/cmap/cmapPy
---


# cmappy

## Overview
cmappy is a specialized suite of Python tools developed by the Broad Institute for handling Connectivity Map data. It is designed to manage large-scale genomic and proteomic datasets that are typically stored in GCT (Gene Cluster Text) or GCTX (HDF5-based) formats. The tool centers around the `GCToo` object, which integrates a data matrix with row and column metadata using pandas DataFrames. Use this skill to efficiently process biological matrices, perform memory-efficient subsetting on binary files, and convert data for downstream analysis.

## Installation and Setup
Install the package via bioconda to ensure all dependencies (like HDF5 for GCTX support) are correctly configured:
```bash
conda install -c bioconda cmappy
```

## Core Data Formats
- **.gct**: A tab-delimited text file containing a data matrix and metadata. Version 1.3 is the standard for CMap.
- **.gctx**: A binary, HDF5-based version of GCT. It is significantly faster and allows for "random access" (reading specific rows/columns without loading the whole file).
- **.grp**: A simple line-delimited list of identifiers (e.g., a list of gene symbols).
- **.gmt**: Gene Matrix Transposed format, used for storing gene sets.

## Common Python Patterns
The primary way to use cmappy is through its Python API.

### Parsing and Writing
```python
from cmapPy.pandasGEXpress.parse_gct import parse
from cmapPy.pandasGEXpress.write_gct import write
from cmapPy.pandasGEXpress.write_gctx import write as write_gctx

# Parse a full GCT or GCTX file
gctoo = parse("data.gctx")

# Access components
matrix = gctoo.data_df
row_metadata = gctoo.row_metadata_df
col_metadata = gctoo.col_metadata_df

# Write to GCTX (recommended for large files)
write_gctx(gctoo, "output_file.gctx")
```

### Memory-Efficient Subsetting
One of the most powerful features of `cmapPy` is subsetting a `.gctx` file on disk without loading the entire matrix into memory.
```python
# Subset by specific row and column IDs
my_subset = parse("large_data.gctx", rid=["gene1", "gene2"], cid=["sample1", "sample2"])
```

### Matrix Transformations
Use the `transform_gctoo` module for common operations like transposing, which handles both the data matrix and the associated metadata correctly.
```python
from cmapPy.pandasGEXpress.transform_gctoo import transpose

transposed_gctoo = transpose(gctoo)
```

## CLI Tool Patterns
While primarily a library, `cmapPy` provides scripts for common tasks.

### Format Conversion
To convert a text-based GCT file to a binary GCTX file:
```bash
python -m cmapPy.pandasGEXpress.gct2gctx data.gct
```

### Subsetting via CLI
You can subset files using `.grp` files containing the desired IDs:
```bash
python -m cmapPy.pandasGEXpress.subset_gct -i input.gctx -rid rows.grp -cid cols.grp -o subset_output.gctx
```

## Expert Tips
- **GCTX over GCT**: Always prefer `.gctx` for datasets larger than a few hundred megabytes. The HDF5 backend provides much better performance and prevents memory errors.
- **Metadata Integrity**: When manually manipulating the `data_df` within a `GCToo` object, ensure that the index and columns still match the indices of `row_metadata_df` and `col_metadata_df` before writing to disk.
- **Compression**: `cmapPy` supports reading compressed GCT files (`.gct.gz`) directly.
- **Data Types**: If you encounter memory issues, specify the `data_type` during parsing (e.g., `np.float32`) to reduce the memory footprint of the pandas DataFrame.

## Reference documentation
- [cmapPy GitHub Repository](./references/github_com_cmap_cmapPy.md)
- [Bioconda cmappy Overview](./references/anaconda_org_channels_bioconda_packages_cmappy_overview.md)
- [cmapPy Commit History (Functional Details)](./references/github_com_cmap_cmapPy_commits_master.md)