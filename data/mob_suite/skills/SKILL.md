---
name: mob_suite
description: MOB-suite is a bioinformatics framework for the reconstruction, typing, and clustering of plasmid sequences from draft genome assemblies. Use when user asks to reconstruct plasmids from assemblies, identify plasmid biological characteristics, or cluster plasmid sequences into similarity groups.
homepage: https://github.com/phac-nml/mob-suite
---


# mob_suite

## Overview

The MOB-suite is a specialized bioinformatics framework designed to handle the complexities of plasmid analysis in draft genome assemblies. Plasmids are often difficult to assemble and distinguish from chromosomal fragments; this toolset provides a modular approach to solve this by using a combination of marker-based typing and sequence-based clustering. It is essential for researchers studying horizontal gene transfer, antimicrobial resistance (AMR) spread, and bacterial evolution.

## Core Workflows

### 1. Database Initialization
Before running any analysis, the local databases must be initialized. These databases include reference plasmid sequences, sketches, and biomarkers.

```bash
# Standard initialization (downloads to default location)
mob_init

# Initialize in a specific directory
mob_init -d /path/to/custom_db_dir
```

### 2. Plasmid Reconstruction (MOB-recon)
This is the primary tool for most users. It takes a draft assembly (FASTA) and separates contigs into chromosomal or specific plasmid groups.

```bash
# Basic reconstruction
mob_recon --input <assembly.fasta> --outdir <output_directory>

# Reconstruction with automated database download (if not already done)
mob_recon -i <assembly.fasta> -o <out_dir>

# Using chromosome depletion (filtering out known chromosomal sequences)
mob_recon -i <assembly.fasta> -o <out_dir> --filter <chromosome_sequences.fasta>
```

### 3. Plasmid Typing (MOB-typer)
Use this tool when you already have a purified or reconstructed plasmid sequence and need to identify its biological characteristics.

```bash
# Type a single plasmid file
mob_typer --input <plasmid.fasta> --outdir <output_directory>
```

### 4. Plasmid Clustering (MOB-cluster)
This tool groups plasmids into similarity groups (clusters) using Mash genomic distances. It is useful for nomenclature and identifying operational taxonomic units (OTUs) for plasmids.

```bash
# Cluster a set of plasmid sequences
mob_cluster --input <all_plasmids.fasta> --outdir <cluster_results>
```

## Expert Tips and Best Practices

- **First Run Latency**: The first execution of `mob_recon` or `mob_typer` will trigger a large database download if `mob_init` hasn't been run. Ensure you have a stable internet connection and sufficient disk space.
- **Draft vs. Complete Assemblies**: While optimized for draft assemblies, MOB-suite is highly effective on complete genomes to confirm plasmid boundaries and mobility markers.
- **Interpreting Cluster Codes**: MOB-cluster accessions provide a sequence-based nomenclature. Highly similar plasmids will share cluster codes, which often correlate with specific replicon and relaxase types.
- **Memory Management**: For large batches of assemblies, ensure the system has enough RAM for `blast+` and `mash` operations, which are the primary computational bottlenecks.
- **Chromosome Depletion**: If you have a high-quality reference chromosome for your specific strain, use the `--filter` option in `mob_recon` to significantly improve the accuracy of plasmid contig assignment.



## Subcommands

| Command | Description |
|---------|-------------|
| mob_cluster | MOB-Cluster: Generate and update existing plasmid clusters' version: 3.1.9 |
| mob_init | MOB-INIT: initialize databases |
| mob_recon | MOB-Recon: Typing and reconstruction of plasmids from draft and complete assemblies |
| mob_typer | Plasmid typing and mobility prediction |

## Reference documentation
- [MOB-suite GitHub Repository](./references/github_com_phac-nml_mob-suite.md)
- [MOB-suite README and Usage Guide](./references/github_com_phac-nml_mob-suite_blob_master_README.md)