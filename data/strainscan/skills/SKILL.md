---
name: strainscan
description: StrainScan is a specialized bioinformatics tool designed for the accurate identification and quantification of bacterial strains within complex microbiome samples.
homepage: https://github.com/liaoherui/StrainScan
---

# strainscan

## Overview

StrainScan is a specialized bioinformatics tool designed for the accurate identification and quantification of bacterial strains within complex microbiome samples. Unlike species-level profilers, StrainScan utilizes a k-mer based approach and reference genome clusters to provide resolution at the strain level. It is particularly effective for tracking specific pathogen strains or analyzing the micro-diversity of microbial communities using Illumina short-read data.

## Installation and Setup

The most efficient way to deploy StrainScan is via Bioconda, which simplifies the command-line interface.

```bash
conda install -c bioconda strainscan
```

Note: If installed via Bioconda, use the commands `strainscan` and `strainscan_build`. If running from source, use `python StrainScan.py` and `python StrainScan_build.py`.

## Core Workflows

### 1. Building a Custom Database
Before identification, you must construct a database from a set of reference genomes (FASTA format, can be gzipped).

```bash
# Basic database construction
strainscan_build -i /path/to/genomes_folder -o /path/to/output_db
```

**Expert Tips for Database Building:**
- **Custom Clustering**: If you have pre-defined clusters (e.g., from PopPunk), use the `-c` flag to provide a cluster file.
- **Redundancy Reduction**: For very large genome sets, use the subsampling script first to select representative strains:
  `python StrainScan_subsample.py -i <Input_Genomes> -o <Output_Dir>`

### 2. Identifying Strains in Sequencing Data
StrainScan accepts single-end or paired-end FASTQ files (including `.gz` format).

```bash
# Paired-end identification
strainscan -i sample_R1.fq.gz -j sample_R2.fq.gz -d /path/to/database -o /path/to/results
```

**Advanced Identification Parameters:**
- **Low Depth Samples**: If the expected sequencing depth of the target strain is <1X, add the `-b` parameter to output the detection probability.
- **Specialized Modes**: Use `plasmid_mode` or `extraRegion_mode` for specific intra-cluster searching requirements.

## Best Practices

- **Input Quality**: Ensure your input genomes for database construction are of high quality (low fragmentation) to improve the identification of unique k-mer regions.
- **Pre-built Databases**: For common species like *E. coli*, *S. aureus*, or *M. tuberculosis*, check the official repository for pre-built databases to save computation time.
- **Resource Management**: Database construction is computationally intensive. Ensure you have sufficient RAM and use multiple threads if the version supports it (V1.0.10+).

## Reference documentation
- [StrainScan GitHub Repository](./references/github_com_liaoherui_StrainScan.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_strainscan_overview.md)