---
name: ucsc-facmp
description: The ucsc-facmp tool compares two FASTA files record-by-record. Use when user asks to compare two FASTA files, verify FASTA file identity, find differences between FASTA files, perform quality control on genome assemblies, or verify sequence manipulation script output.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-facmp

## Overview

The `ucsc-facmp` skill provides guidance on using the `faCmp` utility, a specialized tool from the UCSC Genome Browser "kent" suite. This tool performs a record-by-record comparison of two FASTA files. Unlike a standard `diff`, which compares text line-by-line, `faCmp` understands the FASTA format, making it more robust for biological sequence verification. It is an essential tool for quality control when managing different versions of a genome assembly or verifying the output of sequence manipulation scripts.

## Usage Instructions

### Basic Command Line
The primary binary for this tool is named `faCmp`. The basic syntax is:

```bash
faCmp <file1.fa> <file2.fa>
```

### Common Patterns
- **Verification of Identity**: If the files are identical in sequence and record naming, the tool typically exits without output.
- **Identifying Discrepancies**: If differences are found, the tool will report specific mismatches, such as differences in sequence length or actual base composition for specific records.
- **Help and Versioning**: To see the full usage statement and any available flags (which may vary by version), run the binary with no arguments:
  ```bash
  faCmp
  ```

### Installation and Setup
- **Bioconda**: The easiest way to install the tool is via conda:
  ```bash
  conda install -c bioconda ucsc-facmp
  ```
- **Manual Download**: If downloading the binary directly from the UCSC server, you must set executable permissions:
  ```bash
  chmod +x faCmp
  ./faCmp file1.fa file2.fa
  ```

## Expert Tips
- **Order Sensitivity**: `faCmp` generally expects the records in both files to be in the same order. If your records are shuffled, the tool may report mismatches even if the content is the same. Consider sorting your FASTA files if order is not guaranteed.
- **Large Files**: This utility is optimized for speed and can handle large genomic files (e.g., whole human chromosomes) much more efficiently than generic text comparison tools.
- **Pipeline Integration**: Use the exit status of `faCmp` in shell scripts to halt pipelines if a sequence integrity check fails.
- **MySQL Configuration**: While `faCmp` itself is a standalone file processor, other UCSC tools in the same suite may require an `.hg.conf` file in your home directory to connect to public databases.

## Reference documentation
- [ucsc-facmp Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-facmp_overview.md)
- [UCSC Admin Executables Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary Directory](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)