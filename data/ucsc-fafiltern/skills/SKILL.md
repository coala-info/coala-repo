---
name: ucsc-fafiltern
description: This tool filters FASTA files by removing sequences that contain more than a specified number of ambiguous 'N' bases. Use when user asks to filter FASTA sequences by N count, remove sequences with too many ambiguous bases, or perform quality control on genomic assemblies.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-fafiltern

## Overview
The `ucsc-fafiltern` tool (specifically the `faFilterN` binary) is a specialized utility from the UCSC Genome Browser "kent" source tree designed for quality control of FASTA files. It scans sequences and excludes any that contain more than a user-defined number of 'N' bases. This is a critical step in bioinformatics pipelines to ensure that downstream analysis—such as alignment, motif searching, or variant calling—is not biased or hindered by high proportions of ambiguous data.

## Usage Instructions

### Basic Syntax
The tool follows the standard UCSC command-line pattern:
```bash
faFilterN <input.fa> <output.fa> <maxN>
```
- `<input.fa>`: The source FASTA file containing sequences to be filtered.
- `<output.fa>`: The destination file where sequences meeting the criteria will be saved.
- `<maxN>`: An integer representing the maximum allowable number of 'N' bases in a sequence. Any sequence with more than this number will be discarded.

### Common Patterns
- **Strict Filtering**: To remove any sequence containing even a single 'N', set `maxN` to 0.
  ```bash
  faFilterN input.fa clean.fa 0
  ```
- **Scaffold QC**: When working with draft assemblies where small gaps are acceptable but large ones are not, set a threshold based on your project's tolerance (e.g., 50 Ns).
  ```bash
  faFilterN assembly.fa filtered_assembly.fa 50
  ```

### Expert Tips
- **Binary Name**: While the package is often referred to as `ucsc-fafiltern` in package managers like Bioconda, the executable binary is named `faFilterN`.
- **Permissions**: If you download the binary directly from the UCSC server, ensure it is executable:
  ```bash
  chmod +x faFilterN
  ```
- **Piping**: UCSC tools often support `stdin` or `stdout` using the hyphen (`-`) character, allowing you to chain this tool with others like `faSize` or `faCount` without writing intermediate files.
- **Memory Efficiency**: `faFilterN` is designed to handle large genomic files efficiently, but always ensure you have sufficient disk space for the output file, as it creates a copy of the valid sequences.

## Reference documentation
- [ucsc-fafiltern - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-fafiltern_overview.md)
- [Index of /admin/exe/linux.x86_64](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)