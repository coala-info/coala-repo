---
name: artic-tools
description: artic-tools provides utilities for managing primer schemes and processing amplicon-based sequencing data within the ARTIC bioinformatics pipeline. Use when user asks to download or validate primer schemes, softmask primer sites in alignments, or filter VCF files for viral genomics.
homepage: https://github.com/will-rowe/artic-tools
---


# artic-tools

## Overview
The `artic-tools` suite provides essential utilities for the ARTIC bioinformatics pipeline, specifically designed for viral genomics and nanopore sequencing. It streamlines the preparation and processing of amplicon-based sequencing data by ensuring primer schemes are biologically valid and by programmatically handling the "softmasking" of primer sites in alignments to prevent biased variant calling.

## Common CLI Patterns

### Primer Scheme Management
Use these commands to prepare the environment for a specific viral target (e.g., SARS-CoV-2).

*   **Download a scheme**:
    `artic-tools get_scheme --scheme <scheme_name> --version <version>`
*   **Validate a local scheme**:
    `artic-tools validate_scheme <scheme.bed>`
    *Tip: Always validate custom or modified BED files before running the full pipeline to ensure primer pairs are correctly defined and overlapping regions are handled.*

### Alignment Softmasking
This is a critical step to mask primer sequences in BAM files, ensuring that the primer-derived sequence does not influence the final consensus or variant frequencies.

*   **Basic softmasking**:
    `artic-tools softmask <scheme.bed> <input.bam> <output.bam>`
*   **Expert Tip**: Ensure your BAM file is indexed (`samtools index`) before running softmasking for optimal performance.

### VCF Filtering
Filter variants based on ARTIC-specific criteria to reduce false positives in viral surveillance.

*   **Filter a VCF**:
    `artic-tools filter_vcf <input.vcf> <output.vcf>`

## Best Practices
1.  **Environment Setup**: Install via Bioconda (`conda install -c bioconda artic-tools`) to ensure all C++ dependencies like HTSlib and Boost are correctly linked.
2.  **Scheme Consistency**: Always use the exact same primer BED file for softmasking that was used during the physical lab amplification process.
3.  **Pipeline Integration**: Run `artic-tools` commands as intermediate steps between alignment (e.g., `minimap2`) and variant calling (e.g., `nanopolish` or `medaka`).



## Subcommands

| Command | Description |
|---------|-------------|
| align_trim | Trim alignments from an amplicon scheme |
| check_vcf | Check a VCF file based on primer scheme info and user-defined cut offs |
| get_scheme | Download an ARTIC primer scheme and reference sequence |
| validate_scheme | Validate an amplicon scheme for compliance with ARTIC standards |

## Reference documentation
- [ARTIC tools README](./references/github_com_will-rowe_artic-tools_blob_master_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_artic-tools_overview.md)