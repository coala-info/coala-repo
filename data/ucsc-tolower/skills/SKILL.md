---
name: ucsc-tolower
description: ucsc-tolower is a specialized utility from the UCSC Genome Browser "kent" tool suite.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-tolower

## Overview
ucsc-tolower is a specialized utility from the UCSC Genome Browser "kent" tool suite. It provides a simple, deterministic way to transform text by converting every uppercase letter (A-Z) into its lowercase equivalent (a-z). Unlike general-purpose text editors that might alter file encoding or line endings, this tool is built for high-performance processing of large data files, ensuring that non-alphabetic characters—such as sequence headers, quality scores, or numeric data—remain untouched.

## Usage Instructions

### Basic Command Pattern
The tool typically follows a simple input-output file argument structure:

```bash
toLower input.txt output.txt
```

### Working with Genomic Data
In bioinformatics, this tool is frequently used to normalize FASTA sequences. While many tools are case-insensitive, some pipelines require lowercase sequences to distinguish between masked and unmasked regions or simply for consistency.

**Example: Normalizing a FASTA file**
```bash
toLower sequence_UPPER.fasta sequence_lower.fasta
```

### Permissions and Execution
If you have downloaded the binary directly from the UCSC servers rather than installing via a package manager like Conda, you must ensure the file has execution permissions:

```bash
chmod +x toLower
./toLower input.txt output.txt
```

### Integration in Pipes
While the tool primarily expects file arguments, in many environments it can be used within a shell pipe by targeting standard streams (depending on the specific version compiled):

```bash
cat data.txt | toLower /dev/stdin /dev/stdout
```

## Best Practices
- **Preserve Headers**: When using this on FASTA files, be aware that it will lowercase the headers (the lines starting with `>`) as well. If you only want to lowercase the sequence data, you may need to use `awk` or `sed` to target specific lines.
- **In-place Editing**: The tool does not support in-place editing. Always specify a different filename for the output to avoid data corruption.
- **Character Safety**: Use this tool when you want to ensure that numbers, spaces, and special symbols (like `#`, `@`, or `+`) are not accidentally modified, which can happen with some aggressive locale-based `tr` commands.

## Reference documentation
- [ucsc-tolower Overview - Bioconda](./references/anaconda_org_channels_bioconda_packages_ucsc-tolower_overview.md)
- [UCSC Admin Executables Index](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [UCSC Linux x86_64 Utility List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)