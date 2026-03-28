---
name: pbh5tools
description: pbh5tools provides a suite of utilities for manipulating and extracting data from legacy PacBio HDF5 sequencing files. Use when user asks to summarize base call files, generate alignment statistics, filter reads by quality or length, subsample alignments, or convert HDF5 records to CSV format.
homepage: https://github.com/zkennedy/pbh5tools
---

# pbh5tools

## Overview
pbh5tools serves as a specialized "swiss-army knife" for handling legacy PacBio sequencing data stored in HDF5 formats. While modern PacBio systems have moved toward BAM files, pbh5tools remains essential for workflows involving older datasets or specific HDF5-based pipelines. The toolset primarily consists of two command-line utilities, `bash5tools.py` and `cmph5tools.py`, which allow users to perform complex data extraction and filtering tasks without writing custom HDF5 parsing scripts.

## Core CLI Tools

### bash5tools.py
Used for interacting with `.bas.h5` files containing raw or processed base calls.

*   **summarize**: Provides a high-level overview of the base call file, including read types and counts.
*   **stats**: Generates quality and length statistics for the reads.
*   **select**: Extracts specific reads based on criteria like read length or quality.

### cmph5tools.py
Used for interacting with `.cmp.h5` files containing aligned/mapped read data.

*   **stats**: Calculates alignment metrics, such as accuracy and mapped read lengths.
*   **select**: Filters alignments based on reference sequence, mapping quality, or other metadata.
*   **SubSample**: Randomly samples a subset of alignments. Use the `-n` flag to specify a fixed number of random reads.
*   **rec2tbl / csv**: Converts internal HDF5 records into tabular text or CSV files for use in spreadsheets or R/Python dataframes.

## Common Usage Patterns

### Inspecting a File
Before processing, always check the file contents to ensure the `readType` and metadata match your expectations:
```bash
bash5tools.py summarize input.bas.h5
```

### Generating Statistics
To get a quick report on the quality of a dataset:
```bash
cmph5tools.py stats aligned_reads.cmp.h5
```

### Subsampling for Testing
When working with large datasets, it is often useful to extract a small, random subset of reads for pipeline validation:
```bash
cmph5tools.py SubSample --n 1000 input.cmp.h5
```

### Data Conversion
To export alignment data for external analysis:
```bash
cmph5tools.py csv input.cmp.h5 > output.csv
```

## Expert Tips
*   **Error Handling**: If you encounter exceptions during execution, verify that the `readType` in the HDF5 file is compatible with the specific subcommand you are running.
*   **Performance**: For large `.cmp.h5` files, using the `stats` command is significantly faster than manual extraction due to optimized core metrics calculations in the underlying C extensions.
*   **Environment**: Ensure `pbcore`, `numpy`, and `h5py` are installed in your Python environment, as these are the primary dependencies for the toolset.



## Subcommands

| Command | Description |
|---------|-------------|
| bash5tools.py | Tool for extracting data from .bas.h5 files |
| cmph5tools.py | Toolkit for command-line tools associated with cmp.h5 file processing. |

## Reference documentation
- [pbh5tools Overview](./references/github_com_zkennedy_pbh5tools.md)
- [README](./references/github_com_zkennedy_pbh5tools_blob_master_README.txt.md)
- [Setup and Scripts](./references/github_com_zkennedy_pbh5tools_blob_master_setup.py.md)
- [Commit History and Subcommands](./references/github_com_zkennedy_pbh5tools_commits_master.md)