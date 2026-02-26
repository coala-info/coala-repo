---
name: hla-la
description: HLA-LA is a computational tool designed for high-accuracy inference of HLA types from whole-genome sequencing data using a population reference graph. Use when user asks to infer HLA alleles from WGS BAM or CRAM files, perform graph-based HLA typing, or extract HLA types using GRCh38 or T2T reference genomes.
homepage: https://github.com/DiltheyLab/HLA-LA
---


# hla-la

---

## Overview

HLA-LA (formerly HLA*PRG:LA) is a computational tool designed for the high-accuracy inference of HLA types from whole-genome sequencing data. Unlike traditional alignment methods, it utilizes a population reference graph and a linear projection method to align reads, making it faster and less resource-intensive than its predecessor, HLA*PRG. It is the standard choice for researchers needing to extract HLA alleles from standard WGS BAM or CRAM files without requiring targeted HLA sequencing.

## Installation and Setup

The most efficient way to install HLA-LA and its dependencies (including Boost, Bamtools, BWA, Samtools, and Picard) is via Bioconda.

```bash
conda install -c bioconda hla-la
```

**Note:** After installation, you must download the required data packages and index the graph. Follow the instructions provided at the end of the conda installation process to complete the setup.

## Core Usage Patterns

### Standard HLA Typing
The primary script is `HLA-LA.pl`. A typical command requires the input BAM/CRAM, the graph name, and a sample identifier.

```bash
HLA-LA.pl --BAM input.bam --graph PRG_MHC_GRCh38_withIMGT --sampleID MySample --workingDir /path/to/output
```

### Working with CRAM Files
When using CRAM files, the tool often requires the original reference genome to fetch sequences correctly. Use the `--samtools_T` switch to avoid "Unable to fetch reference" errors.

```bash
HLA-LA.pl --BAM sample.cram --graph PRG_MHC_GRCh38_withIMGT --sampleID MySample --samtools_T /path/to/reference_genome.fa
```

### Supported Reference Graphs
Ensure the `--graph` parameter matches your alignment's reference:
- **GRCh38**: `PRG_MHC_GRCh38_withIMGT`
- **T2T (CHM13)**: `chm13v2.0.fa` (Added in July 2023)
- **B37**: Various B37 reference files are supported in the database.

## Expert Tips and Troubleshooting

- **Sample Names**: Recent updates allow for dashes (`-`) and underscores (`_`) in sample names. If using an older version, stick to alphanumeric characters to avoid parsing errors.
- **Memory and Resources**: HLA-LA is optimized for performance, but graph-based alignment is still memory-intensive. Ensure your environment has sufficient RAM (typically 32GB+ for human WGS).
- **Missing Unmapped Reads**: The tool is robust to datasets where unmapped reads have been stripped, but for best results, use the full BAM/CRAM file.
- **HLA-DRB3/4 Caution**: Treat calls for these specific loci with caution as the model does not currently estimate copy number for these genes.
- **Binary Testing**: If you performed a manual installation, verify the build using:
  ```bash
  ../bin/HLA-LA --action testBinary
  ```
  It should return "HLA*LA binary functional!".

## Reference documentation
- [Fast HLA type inference from whole-genome data](./references/github_com_DiltheyLab_HLA-LA.md)
- [HLA-LA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hla-la_overview.md)