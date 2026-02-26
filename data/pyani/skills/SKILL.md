---
name: pyani
description: pyani calculates genome-scale similarity and average nucleotide identity between microbial sequences to define species boundaries. Use when user asks to calculate ANI, compare microbial genomes, generate identity heatmaps, or automate pairwise genomic alignments.
homepage: https://github.com/widdowquinn/pyani
---


# pyani

## Overview

pyani is a specialized toolset for calculating genome-scale similarity between microbial sequences. It automates the pairwise comparison of multiple genomes to produce identity matrices, alignment coverage statistics, and high-quality visualizations like heatmaps. It is primarily used in bioinformatics to define species boundaries and explore the relatedness of bacterial strains.

## Installation and Setup

Install pyani via bioconda for the most reliable dependency management (MUMmer, BLAST+, and fastANI):

```bash
conda create --name pyani_env python=3.8
conda activate pyani_env
conda install -c bioconda pyani
```

## Core Workflow (v0.3+)

The modern version of pyani uses a unified CLI and a database-centric workflow to manage multiple analysis runs.

### 1. Prepare the Environment
Initialize a local SQLite database to store analysis metadata and results:
```bash
pyani createdb
```

### 2. Index Genomes
Index your input FASTA files to calculate MD5 hashes and prepare the database:
```bash
pyani index -i <INPUT_DIRECTORY>
```

### 3. Run ANI Analysis
Choose an algorithm based on your needs:
- **ANIm**: Uses MUMmer (nucmer). Best for closely related genomes.
- **ANIb**: Uses BLAST+. More sensitive but slower.
- **fastANI**: Optimized for speed on large datasets.

```bash
# Example using ANIm
pyani anim -i <INPUT_DIRECTORY> -o <OUTPUT_DIRECTORY> --name "Project_Name"
```

### 4. Generate Reports
Extract results from the database into readable formats (HTML, Excel, or TSV):
```bash
pyani report --run_id <RUN_NUMBER> --formats html,excel
```

### 5. Visualization
Generate heatmaps for identity and coverage:
```bash
pyani plot --run_id <RUN_NUMBER> --method seaborn
```

## Legacy Usage (v0.2.x)

If using the stable legacy version, use the standalone script for a single-step analysis:

```bash
average_nucleotide_identity.py -i <INPUT_DIR> -o <OUTPUT_DIR> -m ANIm -g
```
- `-m`: Method (ANIm, ANIb, ANIblastall, or TETRA).
- `-g`: Generate graphical output (requires matplotlib/seaborn).

## Expert Tips and Best Practices

- **Database Management**: Use `pyani listruns` to see previous analyses and their IDs. This allows you to re-generate plots or reports without re-running the expensive alignment steps.
- **Large Datasets**: For hundreds of genomes, prefer `fastANI` or use the `--scheduler SGE` flag if working on a High-Performance Computing (HPC) cluster with a Grid Engine.
- **Input Validation**: Ensure all input files have the `.fasta`, `.fna`, or `.fa` extension. Use `genbank_get_genomes_by_taxon.py` to automate the downloading of reference genomes from NCBI.
- **Interpretation**: A common threshold for species delimitation is 95-96% ANI. Always check the "alignment coverage" report alongside the "identity" report; low coverage can make high identity scores misleading.
- **Archival Note**: As of July 2025, this tool is archived. For new projects requiring long-term support and better scaling, consider transitioning to `pyani-plus`.

## Reference documentation

- [pyani GitHub Repository](./references/github_com_widdowquinn_pyani.md)
- [pyani Wiki](./references/github_com_widdowquinn_pyani_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pyani_overview.md)