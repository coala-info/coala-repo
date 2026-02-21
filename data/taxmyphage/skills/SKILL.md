---
name: taxmyphage
description: taxmyphage is a specialized bioinformatics tool that automates the classification of bacteriophages according to the International Committee on Taxonomy of Viruses (ICTV) standards.
homepage: https://github.com/amillard/tax_myPHAGE
---

# taxmyphage

## Overview

taxmyphage is a specialized bioinformatics tool that automates the classification of bacteriophages according to the International Committee on Taxonomy of Viruses (ICTV) standards. It identifies the most similar genomes within the currently classified ICTV set and applies the VIRIDIC formula to calculate intergenomic distances. This allows researchers to determine taxonomic placement without manually running complex comparative genomics pipelines. It is optimized for individual complete isolates rather than metagenomic samples or eukaryotic viruses.

## Installation and Setup

Before running analysis, the environment must be configured and the reference databases must be initialized.

### Environment Setup (Conda/Mamba)
The preferred method is using Mamba to handle dependencies like MASH and BLAST.
```bash
mamba create -n taxmyphage -c conda-forge -c bioconda taxmyphage
mamba activate taxmyphage
```

**Note for Apple Silicon (M1/M2/M3):** Bioconda does not natively support osx-arm64 for this package. Use the x86_64 emulation:
```bash
CONDA_SUBDIR=osx-64 mamba create -n taxmyphage -c conda-forge -c bioconda taxmyphage
```

### Database Initialization
You must download the ICTV databases (MASH index, fasta genomes, and VMR spreadsheet) before the first run:
```bash
taxmyphage install
```

## Command Line Usage

### Basic Taxonomic Assignment
To run the classification on a single or multiple FASTA files:
```bash
taxmyphage run -i query_genome.fna -t 4
```

### Advanced Execution Flags
- **Force Rerun**: Use `-f` or `--force` to overwrite existing results in the output directory.
- **Disable Precomputed Results**: By default, the tool may use pre-computed BLAST results. To force a full BLAST search against the database, use:
  ```bash
  taxmyphage run -i query_genome.fna --no-precomputed
  ```
- **Thread Management**: Use `-t` to specify CPU cores. BLAST and MASH operations scale well with additional threads.

## Expert Tips and Best Practices

- **Input Scope**: Only use this tool for dsDNA phages. While it will produce results for ssDNA or RNA phages, the underlying ICTV cutoffs and similarity metrics used by the tool are not validated for those virus types and may be inaccurate.
- **Database Currency**: Taxonomy is a moving target. If your installation is older than March 2025, you should delete your current environment and reinstall to ensure compatibility with VMR MSL40.
- **Manual Database Updates**: If the automated `taxmyphage install` fails or you need a specific VMR version (e.g., switching between MSL39 and MSL40), you can manually replace the files in the `taxmyphage/database/` directory. Ensure filenames match the expected internal naming convention (e.g., `ICTV.msh`, `Bacteriophage_genomes.fasta.gz`).
- **Output Interpretation**: The tool provides a VIRIDIC-like similarity matrix. A result >95% similarity typically indicates the same species, while >70% typically indicates the same genus, following current ICTV guidelines.

## Reference documentation
- [taxmyphage GitHub Repository](./references/github_com_amillard_tax_myPHAGE.md)
- [taxmyphage Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_taxmyphage_overview.md)
- [taxmyphage Commit History (Flags and Updates)](./references/github_com_amillard_tax_myPHAGE_commits_main.md)