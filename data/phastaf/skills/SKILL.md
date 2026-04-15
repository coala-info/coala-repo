---
name: phastaf
description: Phastaf identifies phage-like regions within bacterial genome sequences. Use when user asks to detect phage-like regions, mask phage sequences, or identify prophage coordinates in bacterial genomes.
homepage: https://github.com/tseemann/phastaf
metadata:
  docker_image: "quay.io/biocontainers/phastaf:0.1.0--0"
---

# phastaf

## Overview

phastaf is a specialized bioinformatics tool designed to detect phage-like regions within bacterial genomes. By identifying these sequences, researchers can mask them to prevent phage-derived signals from interfering with bacterial comparative genomics or use the coordinates to extract prophage elements for further characterization. It produces standard BED files containing the coordinates and scores of detected phage regions.

## Installation and Setup

The most reliable way to install phastaf is via Bioconda:

```bash
conda install -c bioconda phastaf
```

Before running an analysis, verify that all required dependencies (diamond, bedtools, any2fasta, and sort) are correctly installed and accessible in your PATH:

```bash
phastaf --check
```

## Command Line Usage

### Basic Analysis
To identify phage regions in a FASTA file and save the results to a specific directory:

```bash
phastaf --outdir results_folder contigs.fna
```

### Output Interpretation
The primary output is `phage.bed` located in the specified output directory. The columns follow the standard BED format:
1. **Chromosome/Contig ID**: The name of the sequence where the phage was found.
2. **Start**: The starting coordinate (0-based).
3. **End**: The ending coordinate.
4. **Score**: A numerical value representing the confidence or hit strength.

## Expert Tips and Best Practices

- **Masking Genomes**: To mask the identified phage regions in your original FASTA file for downstream analysis, use the output BED file with `bedtools maskfasta`:
  ```bash
  bedtools maskfasta -fi contigs.fna -bed results_folder/phage.bed -fo masked_contigs.fna
  ```
- **Input Preparation**: While phastaf handles standard FASTA files, ensure your contig headers are concise and do not contain special characters that might interfere with BED format parsing.
- **Early Development Warning**: As of the current version, the software is in early development. It is recommended to manually inspect the `phage.bed` coordinates using a genome browser (like IGV) or compare results with other tools like PHASTER if the regions are critical to your study.
- **Database Management**: phastaf relies on an internal database of phage sequences. If you are running the tool from source, ensure the `db/` directory is intact relative to the binary.

## Reference documentation
- [phastaf GitHub Repository](./references/github_com_tseemann_phastaf.md)
- [phastaf Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_phastaf_overview.md)