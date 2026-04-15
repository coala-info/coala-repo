---
name: ucsc-fatovcf
description: This tool converts multi-sequence FASTA alignments into VCF (Variant Call Format) files. Use when user asks to convert FASTA alignments to VCF, or represent genomic variants from aligned sequences.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
metadata:
  docker_image: "quay.io/biocontainers/ucsc-fatovcf:482--hdc0a859_1"
---

# ucsc-fatovcf

## Overview
The `ucsc-fatovcf` skill facilitates the conversion of multi-sequence FASTA alignments into VCF (Variant Call Format) files. This is particularly useful when you have a set of sequences already aligned (e.g., from a multiple sequence alignment) and need to represent the differences between them as discrete genomic variants relative to a reference sequence within the alignment.

## Usage Instructions

### Basic Syntax
The underlying binary for this tool is named `faToVcf`. The standard execution pattern is:

```bash
faToVcf [options] input.fa output.vcf
```

### Core Workflow
1.  **Prepare Input**: Ensure your FASTA file contains a multi-sequence alignment where all sequences are of the same length (including gaps represented by `-`).
2.  **Identify Reference**: By default, the first sequence in the FASTA file is treated as the reference sequence.
3.  **Execution**: Run the command to generate the VCF.

### Common CLI Patterns
*   **Standard Conversion**:
    `faToVcf alignment.fa variants.vcf`
*   **Handling Permissions**: If using the direct binary download from UCSC instead of the Bioconda package, you may need to grant execution permissions:
    `chmod +x faToVcf`
*   **Viewing Help**: To see specific version-dependent flags and options, run the tool without arguments:
    `faToVcf`

### Expert Tips
*   **Alignment Consistency**: The tool expects a true alignment. If sequences are not the same length, the tool will likely fail or produce incorrect coordinates.
*   **Reference Selection**: Since the first record is the reference, ensure your FASTA is ordered correctly before running the tool.
*   **UCSC Environment**: If running this tool as part of a larger suite of UCSC "kent" utilities, ensure your environment path includes the directory where the binaries are stored (e.g., `~/bin/x86_64/`).
*   **Bioconda Advantage**: Using `conda install -c bioconda ucsc-fatovcf` is the preferred method as it handles architecture-specific binary selection (linux-64, macOS-arm64, etc.) and path configuration automatically.

## Reference documentation
- [ucsc-fatovcf - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-fatovcf_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)