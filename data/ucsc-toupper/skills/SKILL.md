---
name: ucsc-toupper
description: The `ucsc-toupper` tool converts lowercase text to uppercase while preserving other characters. Use when user asks to 'convert soft-masked genomic sequences to uppercase', 'standardize FASTA sequences', or 'convert lowercase identifiers or descriptions to uppercase'.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-toupper

## Overview
`ucsc-toupper` is a high-performance utility from the UCSC Genome Browser "Kent" toolset. It is specifically designed to transform lowercase text into uppercase while preserving the integrity of all other characters, including numbers, punctuation, and whitespace. This is particularly useful in genomic workflows where sequence data (A, C, T, G, N) might be soft-masked (lowercase) and needs to be converted to a uniform uppercase format for specific downstream analysis tools.

## Usage Instructions

### Basic Command Line Pattern
The tool follows the standard UCSC utility pattern of requiring an input file and an output file path:

```bash
toUpper input.txt output.txt
```

### Common Bioinformatics Workflows
1. **Standardizing FASTA Sequences**: Use this to convert soft-masked genomic sequences (where repeats are lowercase) to a standard uppercase format.
2. **Standardizing Metadata**: Convert lowercase identifiers or descriptions in tabular data (BED, GTF, or custom TSV files) to uppercase for consistent joining or searching.

### Expert Tips
* **Performance**: As a compiled C binary, `toUpper` is significantly faster than `sed`, `awk`, or Python scripts for processing multi-gigabyte genomic files.
* **Character Preservation**: Unlike some general-purpose text converters, `toUpper` is "safe" for genomic files because it ignores numbers (coordinates) and special characters (like the `>` in FASTA headers or pipe symbols), only targeting `a-z`.
* **Permissions**: If you have downloaded the binary directly from the UCSC server, ensure it is executable:
  ```bash
  chmod +x toUpper
  ```
* **Help Menu**: To see the version-specific usage statement and any available flags, run the binary without any arguments:
  ```bash
  toUpper
  ```

## Reference documentation
- [ucsc-toupper - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-toupper_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)