---
name: ucsc-headrest
description: The ucsc-headrest tool removes a specified number of header lines from a file. Use when user asks to remove header lines from a file, skip initial lines of a file, or prepare data for downstream analysis.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
metadata:
  docker_image: "quay.io/biocontainers/ucsc-headrest:482--h0b57e2e_0"
---

# ucsc-headrest

## Overview

The `headRest` utility is a specialized tool from the UCSC Genome Browser "kent" source tree. While standard Unix tools like `tail -n +N` can achieve similar results, `headRest` is often bundled within bioinformatics pipelines for its simplicity and integration with other UCSC utilities. It is primarily used to strip a fixed number of header lines from a file to prepare the raw data for downstream analysis or database loading.

## Usage Instructions

### Basic Syntax
The tool requires the number of lines to skip and the target file.
```bash
headRest N file
```
- `N`: The number of lines to skip at the beginning of the file.
- `file`: The path to the input file.

### Common Patterns

**1. Removing a Single Header Line**
To skip the first line (usually column headers) and output the data:
```bash
headRest 1 data.tsv
```

**2. Processing Multiple Header Lines**
If a file contains a multi-line metadata block (e.g., 5 lines) before the actual data:
```bash
headRest 5 raw_output.txt
```

**3. Piping into Other UCSC Tools**
`headRest` is frequently used in pipes to clean data before it is passed to tools like `bedToBigBed` or `hgLoadBed`:
```bash
headRest 1 input.bed | bedSort /dev/stdin output.bed
```

### Expert Tips
- **Standard Input**: Like most UCSC utilities, if you need to process a stream, you can often use `/dev/stdin` as the file argument if the specific version supports it, or use it as the first step in a pipeline to clean files before they reach more complex parsers.
- **Permissions**: If using the standalone binary downloaded from UCSC, ensure the execution bit is set: `chmod +x headRest`.
- **Comparison with tail**: While `tail -n +2` is the standard POSIX way to skip the first line, `headRest 1` is the equivalent in the UCSC toolset. Use `headRest` when working in environments where UCSC tools are the primary dependency to ensure consistent behavior.

## Reference documentation
- [UCSC Genome Browser Admin Executables](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-headrest Package Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-headrest_overview.md)
- [UCSC Linux x86_64 Utility List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)