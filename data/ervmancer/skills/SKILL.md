---
name: ervmancer
description: ERVmancer is a bioinformatics tool designed to quantify Human Endogenous Retrovirus expression by resolving multi-mapping reads using a phylogenetic tree. Use when user asks to quantify HERV expression from FASTQ or SAM files, perform phylogenetic tree mapping of retroviral counts, or set up the ERVmancer environment.
homepage: https://github.com/AuslanderLab/ervmancer
metadata:
  docker_image: "quay.io/biocontainers/ervmancer:0.0.4--pyhdfd78af_0"
---

# ervmancer

## Overview
ERVmancer is a specialized bioinformatics tool designed to accurately quantify HERV expression. Unlike general-purpose transcriptomics tools, it addresses the challenge of multi-mapping reads in repetitive retroviral elements by aligning sequences to a curated HERV subset and resolving alignment ambiguities using a pre-computed phylogenetic tree. This skill provides the necessary procedures for environment setup, data preparation, and execution of the primary quantification entrypoints.

## Installation and Environment Setup
ERVmancer requires a specific Python environment and external dependencies (Bowtie2, Samtools, Bedtools).

1. **Create Environment**:
   ```bash
   conda create --name ervmancer_env python=3.8
   conda activate ervmancer_env
   conda config --add channels bioconda
   conda config --add channels conda-forge
   conda install ervmancer
   ```

2. **Required External Assets**:
   You must download the following metadata and index files from Zenodo before running the tool:
   - `clean_kmer_31_60_percent_cutoff.pkl`
   - `GRCh38_noalt_as.tar.gz` (Must be extracted using `tar -xzf`)

## Command Line Usage
ERVmancer supports multiple entrypoints depending on the starting data format.

### Entrypoint 1: From FASTQ Files
Use this when starting with raw sequencing reads. This process includes alignment via Bowtie2.
```bash
ervmancer_fastq -1 <read1.fastq> -2 <read2.fastq> -o <output_directory> -i <path_to_extracted_GRCh38_index> -m <path_to_kmer_pkl>
```

### Entrypoint 2: From Aligned SAM Files
Use this if you have already performed alignment and have a SAM file.
```bash
ervmancer_sam -s <input.sam> -o <output_directory> -m <path_to_kmer_pkl>
```

### Entrypoint 3: Phylogenetic Tree Mapping
For advanced users needing to map counts directly to the phylogenetic tree structure for clade-level interpretation.
```bash
ervmancer_tree -c <counts_file> -o <output_directory>
```

## Best Practices and Tips
- **Python Version**: Ensure Python 3.8 is used; higher versions may encounter dependency conflicts with specific bioconda packages.
- **Index Pathing**: When using the `-i` flag, point to the directory containing the extracted Bowtie2 index files, not the `.tar.gz` file itself.
- **Memory Management**: Alignment and phylogenetic resolution can be memory-intensive. Ensure your environment has at least 16GB of RAM available for human genome alignments.
- **Clade Interpretation**: Use the output from Entrypoint 3 to understand expression at the evolutionary level rather than just individual loci, which helps in identifying broad HERV family activations.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_AuslanderLab_ervmancer.md)
- [ERVmancer Wiki and Entrypoint Guides](./references/github_com_AuslanderLab_ervmancer_wiki.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_ervmancer_overview.md)