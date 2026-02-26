---
name: gtdbtk
description: GTDB-Tk provides phylogenetically consistent and rank-normalized taxonomic assignments for microbial genomes by integrating marker gene identification, alignment, and phylogenetic placement. Use when user asks to classify genomes, assign taxonomy to metagenome-assembled genomes, or run the GTDB-Tk classification workflow.
homepage: http://pypi.python.org/pypi/gtdbtk/
---


# gtdbtk

## Overview
GTDB-Tk is a standardized software toolkit designed to provide phylogenetically consistent and rank-normalized taxonomic assignments. It integrates marker gene identification, multiple sequence alignment, and phylogenetic placement (using pplacer) or Average Nucleotide Identity (ANI) comparisons (using skani) to classify genomes against the GTDB reference database. It is particularly effective for classifying Metagenome-Assembled Genomes (MAGs) and ensuring reproducibility in microbial ecology and genomics.

## Core Workflows and CLI Patterns

### The Standard Classification Workflow
The most common entry point is the `classify_wf`, which runs the full pipeline (identify, align, and classify).

```bash
# Basic classification of a directory of FASTA files
gtdbtk classify_wf --genome_dir <input_dir> --out_dir <output_dir> --extension fa --cpus 16
```

### Optimization and Performance
*   **ANI Screening**: By default, GTDB-Tk uses an ANI screen to rapidly classify genomes belonging to existing GTDB species clusters. This can reduce computation time by 25% to 60%.
*   **Dense Genera**: In versions 2.6.0+, the limit on genomes compared in dense genera has been removed to improve accuracy. If you previously used `--skip-ani-screen` to avoid this limit, it is now generally recommended to let the default ANI screen run unless you have specific reasons to bypass it.
*   **Memory Management**: The `pplacer` step is memory-intensive. Ensure your environment meets the hardware requirements (typically 100GB+ RAM for the full database).

### Common Command Flags
*   `--genome_dir`: Path to the folder containing input genomes.
*   `--out_dir`: Path for output files (directory will be created if it doesn't exist).
*   `--extension`: Specify the file extension of your genomes (e.g., `fasta`, `fna`, `fa`).
*   `--cpus`: Number of threads to use.
*   `--skip-ani-screen`: Bypasses the initial ANI-based classification and forces all genomes through the phylogenetic placement pipeline. Use this if you suspect the ANI screen is missing specific assignments in highly novel lineages.
*   `--scratch_dir`: Use a local scratch directory to improve I/O performance if working on a cluster.

## Expert Tips and Best Practices
*   **Database Setup**: GTDB-Tk requires a specific reference database. Ensure the `GTDBTK_DATA_PATH` environment variable is set to the location of the unarchived GTDB data.
*   **Reproducibility**: GTDB-Tk v2.6.0+ uses fixed versions of `skani` (v0.3.1) and `pplacer` (v1.1.alpha19). Always report the GTDB-Tk version and the database version (e.g., R220) in publications.
*   **Input Quality**: Ensure input genomes are of sufficient quality. Low-completeness or high-contamination MAGs may result in "Unclassified" or unreliable assignments.
*   **Parallelization**: For very large datasets (thousands of MAGs), consider splitting the input into batches or utilizing the `--cpus` flag to maximize throughput during the HMMER and alignment phases.

## Reference documentation
- [GTDB-Tk Overview (Bioconda)](./references/anaconda_org_channels_bioconda_packages_gtdbtk_overview.md)
- [GTDB-Tk Project Description (PyPI)](./references/pypi_org_project_gtdbtk.md)