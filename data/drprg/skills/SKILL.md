---
name: drprg
description: drprg (Drug Resistance Prediction with Reference Graphs) is a specialized bioinformatics tool that identifies drug resistance markers by leveraging the power of genome graphs.
homepage: https://github.com/mbhall88/drprg
---

# drprg

## Overview
drprg (Drug Resistance Prediction with Reference Graphs) is a specialized bioinformatics tool that identifies drug resistance markers by leveraging the power of genome graphs. By using reference graphs instead of linear references, it achieves higher sensitivity and specificity in complex genomic regions. It is primarily used for Mycobacterium tuberculosis (MTB) but is designed to be species-agnostic provided a suitable index is available.

## Installation
The tool is primarily supported on Linux. The recommended installation method is via Bioconda:
```bash
conda install -c bioconda drprg
```

## Core Workflows

### 1. Managing Indices
Before running a prediction, you must have a reference graph index. The tool provides a built-in mechanism to download pre-built indices for supported species.

**Download the M. tuberculosis index:**
```bash
drprg index --download mtb
```

### 2. Predicting Drug Resistance
The `predict` command is the primary interface for analyzing sequencing data. It requires an index, input reads, and an output directory.

**Standard Illumina Run:**
```bash
drprg predict -x mtb -i reads.fq --illumina -o output_directory/
```

**Key Arguments:**
- `-x, --index`: The name or path of the species index (e.g., `mtb`).
- `-i, --input`: Path to the input fastq file (supports gzipped files).
- `--illumina`: Specifies that the input data is from an Illumina platform.
- `-o, --outdir`: Directory where results will be stored.
- `-t, --threads`: Number of CPU cores to utilize (default is 1).

### 3. Building Custom Indices
If a pre-built index is not available for your target organism, use the `build` command to create one from a VCF of known resistance-associated variants and a reference genome.

```bash
drprg build --vcf variants.vcf --ref reference.fasta -o custom_index/
```

## Expert Tips and Best Practices
- **Resource Allocation**: For large datasets, always specify the `-t` flag to match your available CPU cores to significantly reduce processing time.
- **Platform Specifics**: Ensure you use the correct platform flag (e.g., `--illumina`). While the tool is optimized for Illumina, it is designed to handle different error profiles.
- **Output Inspection**: The output directory contains detailed prediction reports. Check the verbose output (`-v`) if a prediction fails to identify expected markers or if mapping rates are low.
- **Docker for Non-Linux Systems**: Since Linux is the only natively supported platform, use the official Docker container for macOS or Windows environments to ensure binary compatibility.

## Reference documentation
- [drprg Overview](./references/anaconda_org_channels_bioconda_packages_drprg_overview.md)
- [drprg GitHub Repository](./references/github_com_mbhall88_drprg.md)