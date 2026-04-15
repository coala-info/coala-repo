---
name: vcf-validator
description: The vcf-validator suite verifies that VCF files adhere to official specifications and match reference genome sequences. Use when user asks to validate VCF syntax, check for specification errors or warnings, generate validation reports, or verify that reference alleles match a FASTA file.
homepage: https://github.com/EBIVariation/vcf-validator
metadata:
  docker_image: "quay.io/biocontainers/vcf-validator:0.10.2--h7a61d87_0"
---

# vcf-validator

## Overview

The vcf-validator suite is a high-performance C++ toolset designed to ensure VCF files adhere to official specifications. It categorizes issues into "Errors" (specification violations) and "Warnings" (best practice recommendations). Beyond standard syntax checking, it includes a specialized assembly checker to verify that the reference alleles (REF) in a VCF match the actual sequences in a provided FASTA file, which is critical for maintaining data integrity in bioinformatics pipelines.

## Core Validation Patterns

### Standard Validation
The primary command is `vcf_validator`. By default, it checks for both errors and warnings.

```bash
# Basic validation of a local file
vcf_validator -i input.vcf

# Validate compressed files (.gz or .bz2 supported natively)
vcf_validator -i input.vcf.gz

# Strict mode: Stop immediately upon the first syntax error
vcf_validator -i input.vcf -l stop
```

### Generating Reports
Use the `-r` flag to specify report types. Multiple reports can be generated simultaneously using a comma-separated list without spaces.

*   `summary`: A high-level count of error types and their first occurrences (Default).
*   `text`: A verbose, line-by-line description of every error found.

```bash
# Generate both summary and verbose text reports in a specific directory
vcf_validator -i input.vcf -r summary,text -o ./validation_results/
```

### Advanced Validation Logic
*   **Evidence Requirement**: Use `--require-evidence` to ensure the VCF contains either Genotypes (FORMAT/GT) or Allele Frequencies (INFO/AF). This is often required for database submissions.
*   **Streaming**: For unsupported formats like `.zip`, use pipes:
    ```bash
    zcat input.vcf.zip | vcf_validator
    ```

## Assembly Checking

The `vcf_assembly_checker` verifies if the `REF` column matches the reference genome. It requires a FASTA file and its corresponding `.fai` index.

### Basic Assembly Check
```bash
vcf_assembly_checker -i input.vcf -f reference.fasta
```

### Handling Contig Mismatches
If your VCF uses different chromosome naming conventions (e.g., "1" vs "chr1") than your FASTA file, provide an assembly report to map them:
```bash
vcf_assembly_checker -i input.vcf -f reference.fasta -a assembly_report.txt
```

### Filtering Valid Records
You can use the assembly checker to extract only the records that match the reference:
```bash
vcf_assembly_checker -i input.vcf -f reference.fasta -r valid
```

## Expert Tips

1.  **Performance**: The validator is implemented in C++14 and is significantly faster than Python-based validators. For large files, always prefer the binary version over scripted alternatives.
2.  **Output Naming**: Reports are automatically named after the input file with an appended timestamp. If using stdin, the current directory is used for output unless `-o` is specified.
3.  **Validation Levels**:
    *   `error`: Use this if you only care about hard failures that prevent file parsing.
    *   `warning`: Use this for quality control and ensuring compatibility with strict tools (Default).
4.  **Memory Efficiency**: When running the assembly checker, ensure the `.fai` file is present in the same directory as the FASTA file to enable random access and reduce memory overhead.



## Subcommands

| Command | Description |
|---------|-------------|
| vcf-assembly-checker | vcf-assembly-checker version 0.10.2 |
| vcf_validator | vcf_validator version 0.10.2 |

## Reference documentation
- [vcf-validator GitHub Repository](./references/github_com_EBIVariation_vcf-validator.md)