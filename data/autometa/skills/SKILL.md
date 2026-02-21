---
name: autometa
description: Autometa is a bioinformatics pipeline designed to recover high-quality microbial genomes from metagenomic datasets.
homepage: https://github.com/KwanLab/Autometa
---

# autometa

## Overview
Autometa is a bioinformatics pipeline designed to recover high-quality microbial genomes from metagenomic datasets. It is particularly effective for host-associated metagenomes where traditional binning methods might struggle with complexity or contamination. The tool integrates sequence composition (k-mers), abundance (coverage), and phylogeny to cluster contigs into bins, providing a comprehensive workflow from raw contigs to refined Metagenome-Assembled Genomes (MAGs).

## Installation and Setup
The most reliable way to install Autometa is via the Bioconda channel using Mamba or Conda.

```bash
# Create a new environment and install autometa
mamba create -n autometa -c conda-forge -c bioconda autometa
mamba activate autometa
```

## Core Workflows
Autometa provides two primary ways to execute its pipeline: a native Bash workflow and a Nextflow implementation.

### 1. Bash Workflow
This is the standard approach for single-sample processing.
- **Template**: Download the `autometa.sh` script from the official repository.
- **Configuration**: Edit the input parameters within the script to point to your assembly (FASTA) and mapping files (BAM/SAM).
- **Execution**: Run the script directly: `bash autometa.sh`.

### 2. Nextflow Workflow
For scalable, reproducible runs, use the nf-core compatible Nextflow pipeline.
- **Requirement**: Ensure `nextflow` and `nf-core` are installed.
- **Launch**:
  ```bash
  nf-core launch KwanLab/Autometa
  ```

## Key CLI Entrypoints
Autometa installs several specialized commands for modular processing:

- `autometa-config`: Manage and view the pipeline configuration.
- `autometa-kmers`: Perform k-mer counting, normalization, and embedding (supports t-SNE and UMAP).
- `autometa-binning`: Execute the core clustering algorithms to group contigs.
- `autometa-coverage`: Calculate contig coverage from read mapping files (supports BAM, SAM, and BED).
- `autometa-cami-format`: Convert binning results into the CAMI (Critical Assessment of Metagenome Interpretation) format for benchmarking.

## Best Practices
- **Database Preparation**: Autometa requires taxonomic databases (NCBI or GTDB). Ensure these are properly initialized using the provided setup utilities before running the binning step.
- **Kingdom-Specific Binning**: When possible, specify the target kingdom (e.g., Bacteria or Archaea) to improve the accuracy of marker gene detection and binning.
- **Coverage Calculation**: For the best results, provide high-quality mapping files. Autometa uses `bedtools` and `samtools` internally to process these files.
- **Complexity Handling**: For highly complex samples, consider using UMAP for k-mer embedding as it often preserves global structure better than t-SNE for large datasets.

## Reference documentation
- [GitHub Repository](./references/github_com_KwanLab_Autometa.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_autometa_overview.md)