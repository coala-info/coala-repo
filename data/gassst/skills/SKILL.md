---
name: gassst
description: GASSST performs fast gapped alignments of DNA sequences against large reference databases for reads up to 1000bp. Use when user asks to map DNA sequences to a reference, perform gapped alignments, or convert GASSST results to SAM format.
homepage: https://www.irisa.fr/symbiose/projects/gassst/
---


# gassst

## Overview
GASSST is a specialized alignment tool designed for mapping DNA sequences against large reference databases. It excels at performing fast gapped alignments, making it particularly effective for sequences ranging from short reads to longer fragments up to 1000bp. The tool utilizes a seed-based approach with automatic seed length calculation to balance sensitivity and speed.

## Command Line Usage

### Basic Alignment
To perform a standard alignment with a minimum similarity threshold:
```bash
gassst -d bank.fasta -i query.fasta -o results -p 90
```
- `-d`: Reference DNA bank (FASTA)
- `-i`: Query sequences (FASTA)
- `-o`: Output prefix for results
- `-p`: Minimum similarity percentage (e.g., 90 for 90%)

### Gap Management
Control the sensitivity of gapped alignments using the `-g` flag:
- `-g`: Specifies the maximum number of gaps allowed as a percentage of the query length.

### SAM Format Conversion
GASSST produces a native output format that must be converted for use in standard bioinformatics pipelines:
```bash
gassst_to_sam results results.sam
```
*Note: The converter ensures results are in the same order as the query file and supports multiple hits per read.*

## Best Practices
- **Read Length**: While optimized for reads up to 500bp, version 1.28 supports reads exceeding 1000nt.
- **Sensitivity**: Adjust the `-p` parameter to control the stringency of the search. Higher values (95-99) increase speed but may miss divergent sequences.
- **Memory**: For very large reference banks, ensure the system has sufficient RAM as GASSST loads the bank for processing.
- **Output Handling**: Always use the `gassst_to_sam` utility provided with the package to ensure coordinate accuracy and proper strand orientation in downstream analysis.

## Reference documentation
- [GASSST Project Homepage](./references/www_irisa_fr_symbiose_projects_gassst.md)
- [Bioconda GASSST Package Overview](./references/anaconda_org_channels_bioconda_packages_gassst_overview.md)