---
name: ucsc-bedjointaboffset
description: ucsc-bedjointaboffset joins a BED file with a TAB file to append byte offset and line length information to BED records. Use when user asks to append offset and length to a BED file, join a BED file with a TAB file, create an indexed BED file, or build custom tracks and indices.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---


# ucsc-bedjointaboffset

## Overview
The `ucsc-bedjointaboffset` utility is a specialized tool from the UCSC Genome Browser "Kent" toolkit. It performs a relational join between a BED file and a TAB file based on a shared identifier. Its primary function is to take the byte offset and line length information stored in a TAB file and append them as new columns to the corresponding records in a BED file. This is a critical step when building custom tracks or indices where the BED file serves as a pointer to specific lines in a larger flat file.

## Usage Instructions

### Basic Command Syntax
```bash
bedJoinTabOffset inBed inTab outBed
```

### Input Requirements
*   **inBed**: A standard BED file. The tool specifically looks at the `name` field (typically the 4th column) to perform the match.
*   **inTab**: A tab-separated file where:
    *   Column 0 (the first column) contains the identifier that matches the BED `name` field.
    *   Subsequent columns contain the file offset and line length values.
*   **outBed**: The resulting file, which will be a copy of the input BED file with two additional fields appended to the end of each matching line: the offset and the length.

### Common Workflow Pattern
1.  **Prepare the Tab File**: Ensure your TAB file contains the unique identifiers in the first column, followed by the byte offset and the length of the record in the source file.
2.  **Match Identifiers**: Ensure the `name` field in your BED file (column 4) exactly matches the identifiers in your TAB file.
3.  **Execution**: Run the tool to generate the indexed BED file.
4.  **Verification**: The output file will have two more columns than the input BED file. If the input was a BED6, the output will effectively be a BED8 (though the extra columns are specific to file pointers).

### Expert Tips
*   **Binary Availability**: This tool is part of the UCSC userApps suite. If not found in your path, it is often located in directories named `linux.x86_64` or `macOSX.arm64` depending on your architecture.
*   **Permissions**: If running the binary directly from a download, ensure it has execution permissions: `chmod +x bedJoinTabOffset`.
*   **Data Integrity**: The tool assumes that for every name in the BED file, a corresponding entry exists in the TAB file. Missing matches may result in incomplete output or errors depending on the version.
*   **Sorting**: While `bedJoinTabOffset` does not strictly require sorted input, it is a best practice in the UCSC ecosystem to sort your BED files using `bedSort` before and after processing to ensure compatibility with downstream tools like `bedToBigBed`.

## Reference documentation
- [ucsc-bedjointaboffset overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bedjointaboffset_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)