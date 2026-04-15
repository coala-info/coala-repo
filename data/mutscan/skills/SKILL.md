---
name: mutscan
description: Mutscan rapidly detects targeted mutations directly from raw FASTQ sequencing data using a k-mer based approach. Use when user asks to scan for specific variants, monitor oncogenic mutations, or verify CRISPR editing results without performing full genome alignment.
homepage: https://github.com/OpenGene/genefuse
metadata:
  docker_image: "quay.io/biocontainers/mutscan:1.14.1--h5ca1c30_0"
---

# mutscan

## Overview
Mutscan is a specialized tool designed for the rapid detection of targeted mutations directly from raw sequencing data (FASTQ). Unlike traditional pipelines that require time-consuming alignment to a reference genome, Mutscan uses a k-mer based approach to scan for specific variants. This makes it exceptionally fast and efficient for applications where the targets of interest are known in advance, such as monitoring oncogenic mutations or verifying CRISPR editing results.

## Installation and Setup
Mutscan is most easily installed via Bioconda:
```bash
conda install -c bioconda mutscan
```

## Core Usage Patterns

### Basic Mutation Scanning
To scan for mutations, you typically provide the input FASTQ files and a mutation file defining the targets.

**Single-end data:**
```bash
mutscan -1 sample.R1.fq.gz -m mutations.csv
```

**Paired-end data:**
```bash
mutscan -1 sample.R1.fq.gz -2 sample.R2.fq.gz -m mutations.csv
```

### Output Formats
Mutscan generates visual and machine-readable reports to facilitate both manual review and automated downstream analysis.
- **HTML Report**: Provides an interactive visualization of supporting reads, base quality, and mutation context.
- **JSON Report**: Contains structured data for integration into bioinformatics pipelines.

```bash
mutscan -1 R1.fq.gz -2 R2.fq.gz -m targets.csv -h report.html -j report.json
```

## Defining Target Mutations
The mutation file (`-m`) is a CSV file that defines the genomic context of the mutations you wish to find. While specific schemas can vary by version, a standard entry typically includes:
1. **Mutation Name**: A unique identifier (e.g., EGFR_L858R).
2. **Sequence**: The DNA sequence containing the mutation.
3. **Mutation Position**: The specific coordinate within that sequence.

## Expert Tips and Best Practices
- **Direct Scanning**: Use Mutscan when you have a specific list of variants to check. It is significantly faster than BWA/GATK workflows because it bypasses the alignment step.
- **Read Filtering**: Mutscan performs internal quality filtering. If you are working with very low-quality data, you may need to adjust the quality threshold parameters to avoid false negatives.
- **Thread Optimization**: Use the `-t` or `--thread` flag to increase processing speed on multi-core systems (default is usually 4).
- **Validation**: Always use the HTML report to manually inspect the "supporting reads" visualization, especially for low-frequency variants in liquid biopsy samples, to distinguish true mutations from sequencing artifacts.

## Reference documentation
- [mutscan - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_mutscan_overview.md)