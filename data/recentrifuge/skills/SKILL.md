---
name: recentrifuge
description: Recentrifuge is a robust computational framework designed for the comparative analysis of metagenomic datasets.
homepage: https://github.com/khyox/recentrifuge
---

# recentrifuge

## Overview

Recentrifuge is a robust computational framework designed for the comparative analysis of metagenomic datasets. Unlike simple visualization tools, it incorporates classification confidence scores and negative control data to provide a statistically grounded view of microbial communities. It excels at identifying shared and exclusive taxa across multiple samples and implementing a sophisticated contamination removal algorithm that accounts for crossovers. This makes it an essential tool for researchers working with sensitive samples where the reliable detection of minority organisms is paramount.

## Core CLI Usage

The Recentrifuge package consists of several specialized scripts. The primary entry point is the `rcf` command (or specific wrappers for different classifiers).

### 1. Running Analysis by Classifier
Recentrifuge provides tailored scripts for major taxonomic classifiers to handle their specific output formats:

*   **Centrifuge**: Use `rcf` with Centrifuge output files.
*   **Kraken**: Use the Kraken-specific workflow to process `.kraken` or report files.
*   **CLARK**: Use the CLARK-specific flags to process `.csv` results.
*   **Generic Classifiers**: Use `rgf` to format results from unsupported classifiers into a Recentrifuge-compatible format.

### 2. Contamination Removal
To perform contamination subtraction, you must include one or more negative control samples in your input list. Recentrifuge will automatically detect these and generate:
*   Standard scored plots for all samples.
*   Control-subtracted plots where pollutants and crossovers are removed.
*   Shared and exclusive taxa plots.

### 3. Read Extraction (`rextract`)
Use `rextract` to retrieve specific sequences from your original FASTQ/FASTA files based on the taxonomic assignment:
*   Filter by TaxID or specific taxonomic rank.
*   Filter by minimum confidence score to ensure high-quality read recovery.
*   Useful for downstream assembly or verification of specific pathogens.

### 4. Database Management and Utilities
*   **`rextraccnt`**: Extract specific entries from large NCBI-like databases (e.g., `nt`) to create smaller, specialized reference sets.
*   **`refasplit`**: Symmetrically split large FASTA files to facilitate parallel processing in high-performance computing environments.
*   **`retaxdump`**: Update or manage local NCBI taxonomy dumps to ensure the 49 supported taxonomic ranks are correctly mapped.

## Expert Tips and Best Practices

*   **Score Thresholding**: Always utilize the scoring capabilities. Recentrifuge uses the arithmetic of scored taxonomic trees; adjusting the score thresholds can help eliminate false positives in clinical or forensic samples.
*   **Low Biomass Strategy**: For low-biomass studies, always run Recentrifuge with at least one "blank" or negative control. The crossover detection algorithm is significantly more reliable than simple presence/absence subtraction.
*   **Nanopore Data**: If working with long-read data (e.g., Oxford Nanopore), use the specialized confidence levels designed for variable-length reads to account for the different error profiles compared to Illumina data.
*   **Parallelization**: For very large datasets, use `refasplit` to divide the workload before classification, then recombine the outputs in Recentrifuge for a unified comparative analysis.
*   **Infraspecific Ranks**: Use the `--strain` flag if your research requires resolution at the strain or isolate level, as Recentrifuge supports several levels below the species rank.

## Reference documentation

- [Recentrifuge Wiki](./references/github_com_khyox_recentrifuge_wiki.md)
- [Recentrifuge Main Repository](./references/github_com_khyox_recentrifuge.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_recentrifuge_overview.md)