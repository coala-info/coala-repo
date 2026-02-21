---
name: ucsc-ixixx
description: The `ixIxx` utility is a specialized indexing tool from the UCSC Genome Browser "kent" suite.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-ixixx

## Overview
The `ixIxx` utility is a specialized indexing tool from the UCSC Genome Browser "kent" suite. It is designed to transform a sorted text file into a high-performance searchable database. It produces two files: a primary index (`.ix`) and a secondary "index of the index" (`.ixx`). This dual-index system allows for near-instantaneous keyword lookups even in files containing millions of entries, making it a critical component for building searchable Track Hubs and custom genome browser assemblies.

## Command Line Usage

The basic syntax for `ixIxx` requires an input text file and two output paths:

```bash
ixIxx input.txt out.ix out.ixx
```

### Input File Requirements
For `ixIxx` to function correctly, the input file must adhere to a specific structure:
1. **Format**: Each line should start with a unique identifier (the search key), followed by the text or data associated with that key.
2. **Sorting**: The input file **must** be sorted alphabetically by the first column. If the file is not sorted, the resulting index will be corrupted or non-functional.

### Standard Workflow Pattern
To ensure a valid index, always pipe your data through `sort` before indexing:

```bash
# Sort by the first column and then index
sort -k1,1 input_data.txt > input_sorted.txt
ixIxx input_sorted.txt out.ix out.ixx
```

## Best Practices and Expert Tips

### Case Sensitivity
`ixIxx` is generally case-sensitive. If you want your search to be case-insensitive in the final application (like a Genome Browser search bar), ensure that the first column of your input file is converted to lowercase during the sorting phase.

### Handling Multiple Keywords
If a single record needs to be found via multiple different keywords, you should create multiple lines in your input file—one for each keyword—all pointing to the same data or ID, and then sort the file.

### Index File Roles
*   **The .ix file**: This is the primary index. It contains every word found in the first column of your input file followed by a list of offsets where that word appears.
*   **The .ixx file**: This is a much smaller file that contains offsets into the `.ix` file. It acts as a "jump table," allowing search tools to find the correct section of the `.ix` file without reading it from the beginning.

### Verification
You can verify the contents of the generated `.ix` file using standard text tools like `head` or `grep`, as it is a line-oriented text format. The `.ixx` file, however, is designed for programmatic access by the UCSC search binaries.

## Reference documentation
- [ucsc-ixixx Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-ixixx_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)