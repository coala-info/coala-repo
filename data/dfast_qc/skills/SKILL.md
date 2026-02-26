---
name: dfast_qc
description: dfast_qc evaluates the quality of prokaryotic genome assemblies by integrating taxonomic identification, assembly statistics, and completeness checks. Use when user asks to assess genome quality, identify taxonomic relatives, or estimate assembly completeness and contamination.
homepage: https://dfast.nig.ac.jp
---


# dfast_qc

## Overview
The dfast_qc skill provides a streamlined workflow for evaluating the quality of prokaryotic genome sequences. It integrates taxonomic identification with assembly statistics and marker-gene based completeness checks. This tool is essential for identifying potential contamination in genomic data and ensuring that assemblies meet the necessary standards for functional annotation or comparative genomics.

## Usage Patterns

### Basic Quality Check
To run a standard quality assessment on a FASTA file:
```bash
dfast_qc -i genome.fasta -o output_dir
```

### Taxonomic Identification and Completeness
DFAST-QC can automatically determine the closest taxonomic relative and estimate completeness:
```bash
dfast_qc --genome genome.fasta --out out_qc --checkm
```

### Common CLI Options
- `-i`, `--input`: Path to the input genomic FASTA file.
- `-o`, `--out`: Directory for output files.
- `--checkm`: Enable completeness and contamination check (requires CheckM).
- `--gtdb`: Use GTDB-Tk for taxonomic assignment (if installed).
- `--cpu`: Specify the number of threads to use for parallel processing.

## Expert Tips
- **Database Preparation**: Ensure that the necessary reference databases (e.g., for taxonomic assignment) are properly indexed and accessible to the tool.
- **Resource Management**: Completeness checks (like CheckM) are computationally intensive; always specify the `--cpu` parameter to match your environment's capabilities.
- **Output Interpretation**: Review the `summary.txt` file in the output directory for a quick glance at N50, total length, and taxonomic hits.

## Reference documentation
- [dfast_qc Overview](./references/anaconda_org_channels_bioconda_packages_dfast_qc_overview.md)