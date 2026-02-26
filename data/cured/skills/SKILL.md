---
name: cured
description: CURED identifies unique sequence biomarkers and restriction enzyme sites to design diagnostic tests for distinguishing specific strains from background diversity. Use when user asks to identify unique k-mers, find restriction enzyme sites for diagnostics, or download and compare genomes from NCBI to find clonal biomarkers.
homepage: https://github.com/microbialARC/CURED
---


# cured

## Overview
CURED (Classification Using Restriction Enzyme Diagnostics) is a bioinformatics pipeline designed to bridge the gap between high-cost whole genome sequencing and field-deployable diagnostics. It identifies unique sequence biomarkers (k-mers) that distinguish a "case" group (e.g., a specific outbreak strain) from a "control" group (e.g., background diversity). Once unique sequences are found, the tool identifies specific restriction enzyme sites within those sequences to facilitate the creation of simple, enzyme-based diagnostic tests.

## Core Workflows

### 1. Identifying Unique Biomarkers (CURED_Main.py)
The primary entry point for finding clonal biomarkers. It supports several data input methods:

*   **Local Curated Dataset**: Use a CSV to define cases and controls.
    `CURED_Main.py --case_control_file sample.csv --genomes_folder ./data/`
    *Note: CSV format should be `filename,label` (e.g., `GCA_001.fna,case`).*

*   **Automated NCBI Discovery**: Download genomes by species and Sequence Type (ST).
    `CURED_Main.py --species "Staphylococcus aureus" --sequence_type 300 --database RefSeq`

*   **Hybrid Approach**: Use local case genomes and download species-specific controls.
    `CURED_Main.py --case_genomes --genomes_folder ./my_cases/ --species "Pseudomonas putida"`

*   **Simple K-mer Query**: Search for specific known k-mers across a dataset.
    `CURED_Main.py --use_simple --kmer_list kmers.txt --case_control_file sample.csv --genomes_folder ./data/`

### 2. Finding Restriction Enzyme Sites (CURED_FindREs.py)
After identifying unique k-mers, use this script to find unique restriction sites.
*   By default, it requires 100% specificity (the site must not exist in any control).
*   It outputs the information required to design the physical diagnostic test.

## Expert Tips and Best Practices

*   **Sensitivity vs. Specificity**: If no unique k-mers are found at the default 100/100 thresholds, try lowering them slightly (e.g., `--sensitivity 95 --specificity 95`) to account for sequencing errors or minor genomic variations.
*   **K-mer Length**: The default is 20-mer. For highly repetitive genomes or very closely related strains, increasing this (e.g., `--kmer_length 31`) can improve specificity.
*   **NCBI Pre-check**: Use the `--summary` flag when downloading from NCBI to see how many genomes will be retrieved before starting the full pipeline.
*   **File Extensions**: Ensure all local genome files share the same extension. Use the `--extension` flag (e.g., `--extension .fa`) if your files do not use the default `.fna`.
*   **Performance**: Use the `--threads` flag to speed up k-mer calling and BLAST searches on multi-core systems.

## Reference documentation
- [CURED GitHub Repository](./references/github_com_microbialARC_CURED.md)
- [Bioconda CURED Overview](./references/anaconda_org_channels_bioconda_packages_cured_overview.md)