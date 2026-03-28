---
name: ucsc-pslsomerecords
description: This tool extracts specific alignment records from a PSL file based on a provided list of identifiers. Use when user asks to filter PSL files, subset sequence alignments by query or target name, or extract specific alignment blocks using a list of names.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-pslsomerecords

## Overview
The `pslSomeRecords` utility is a specialized filtering tool within the UCSC Kent toolkit. It provides an efficient way to subset PSL (Pattern Space Layout) files, which store sequence alignments. Instead of manually parsing large text files, you provide a simple list of target identifiers, and the tool performs a high-speed extraction of the corresponding alignment blocks. This is essential for managing large-scale comparative genomics data where only a specific set of queries or targets is of interest.

## Usage Instructions

### Basic Command Syntax
To extract records, you need a list of names and the source PSL file:

```bash
pslSomeRecords <listFile> <input.psl> <output.psl>
```

*   **listFile**: A plain text file containing one record name per line. These names should correspond to the `Qname` (Query name) field in the PSL file.
*   **input.psl**: The source alignment file.
*   **output.psl**: The file where the extracted records will be saved.

### Common Options
While the tool is designed for simplicity, the following flags are often available in the Kent utility suite:
*   `-v`: Invert the selection. Use this to output all records *except* those listed in the `listFile`.
*   `-t`: Match against the `Tname` (Target name) field instead of the default `Qname` field.

## Expert Tips and Best Practices
*   **Exact Matching**: The tool performs exact string matching. Ensure there is no trailing whitespace in your `listFile` and that the case sensitivity matches your PSL file exactly.
*   **Performance**: `pslSomeRecords` is significantly more memory-efficient and faster than using `grep -f` on large PSL files because it is optimized for the tabular structure of the Kent source formats.
*   **Pipeline Integration**: You can use `/dev/stdin` or `/dev/stdout` to pipe data through `pslSomeRecords` in complex bioinformatics workflows.
*   **Validation**: After extraction, it is good practice to run `pslCheck` on the output file to ensure the resulting PSL structure remains valid, especially if the output is intended for loading into a UCSC Genome Browser track.



## Subcommands

| Command | Description |
|---------|-------------|
| pslCheck | Check PSL files for consistency. |
| pslSomeRecords | Extract PSL records from a file that match a list of names. |

## Reference documentation
- [Bioconda ucsc-pslsomerecords Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-pslsomerecords_overview.md)
- [UCSC Kent Source Tree](./references/github_com_ucscGenomeBrowser_kent.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)