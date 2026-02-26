---
name: mob_suite
description: The mob_suite toolkit identifies, reconstructs, and characterizes plasmid sequences from whole genome sequencing data. Use when user asks to reconstruct plasmids from draft assemblies, type plasmid biomarkers, or cluster plasmids into similarity groups.
homepage: https://github.com/phac-nml/mob-suite
---


# mob_suite

## Overview

The `mob_suite` is a specialized bioinformatics toolkit designed for the comprehensive analysis of plasmids within Whole Genome Sequencing (WGS) data. It addresses the challenge of identifying mobile genetic elements in fragmented draft assemblies by using a combination of curated databases and genomic distance estimation. The suite allows you to reconstruct individual plasmid sequences, predict their mobility (transferability), and assign them to similarity clusters (OTUs) for epidemiological surveillance and evolutionary studies.

## Core Workflows

### 1. Database Initialization
Before using the suite, you must initialize the required databases (hosted on Figshare). This happens automatically on the first run of `mob_recon` or `mob_typer`, but manual initialization is recommended to ensure environment stability.

```bash
# Initialize or update databases in the default location
mob_init

# Initialize databases in a specific directory
mob_init --database_directory /path/to/custom_db
```

### 2. Plasmid Reconstruction (`mob_recon`)
This is the primary tool for processing draft assemblies. It identifies plasmid-derived contigs, groups them into individual plasmids, and provides full typing information.

```bash
# Basic reconstruction from a draft assembly
mob_recon --input assembly.fasta --outdir results_dir

# Reconstruction with chromosome depletion (filtering out known chromosomal sequences)
mob_recon --input assembly.fasta --outdir results_dir --force
```

### 3. Plasmid Typing (`mob_typer`)
Use this tool when you have already isolated plasmid sequences (e.g., from a complete assembly or a specific fasta file) and need to characterize their biomarkers.

```bash
# Type a specific plasmid sequence
mob_typer --input plasmid.fasta --outdir typing_results

# Multi-mode typing for a directory of files
mob_typer --input_directory ./plasmids --outdir multi_typing_results
```

### 4. Plasmid Clustering (`mob_cluster`)
Used to group plasmids into similarity groups based on Mash genomic distances. This is useful for determining if a plasmid belongs to a known lineage.

```bash
# Cluster a set of plasmid sequences
mob_cluster --input plasmids.fasta --outdir cluster_output
```

## Best Practices and Expert Tips

- **Input Quality**: `mob_recon` is designed for draft assemblies. While it works on complete genomes, its primary strength is resolving the "plasmid vs. chromosome" ambiguity in fragmented data.
- **Memory Management**: The databases are large. If running in a memory-constrained environment (like a small Docker container), ensure you have at least 4-8GB of RAM available for BLAST and Mash operations.
- **Output Interpretation**:
    - `contig_report.txt`: Provides the assignment of every input contig (Plasmid vs. Chromosome).
    - `mobtyper_results.txt`: Contains the replicon, relaxase, and mate-pair formation (MPF) types, along with predicted mobility (e.g., conjugative, mobilizable, non-mobile).
- **Container Usage**: When using Docker or Singularity, always mount your data volumes to `/mnt` and ensure the tool has write permissions to the output directory.
    ```bash
    docker run --rm -v $(pwd):/mnt kbessonov/mob_suite:latest mob_recon -i /mnt/assembly.fasta -o /mnt/output
    ```

## Reference documentation
- [MOB-suite GitHub Repository](./references/github_com_phac-nml_mob-suite.md)
- [Bioconda mob_suite Overview](./references/anaconda_org_channels_bioconda_packages_mob_suite_overview.md)