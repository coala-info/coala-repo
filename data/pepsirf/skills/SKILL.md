---
name: pepsirf
description: PepSIRF processes peptide microarray or PhIP-seq data to transform raw sequencing reads into immunological insights. Use when user asks to demultiplex FASTQ files, normalize peptide counts, calculate Z-scores, or perform enrichment analysis and epitope mapping.
homepage: https://github.com/LadnerLab/PepSIRF
---


# pepsirf

## Overview
The Peptide-based Serological Immune Response Framework (PepSIRF) is a specialized suite of tools designed to handle the end-to-end workflow of peptide microarray or PhIP-seq data analysis. It transforms raw sequencing data into interpretable immunological insights by providing modules for data preprocessing, statistical normalization, and epitope-level analysis. Use this skill to navigate the multi-step pipeline required to move from FASTQ files to enriched peptide matrices.

## Core Modules and CLI Usage
PepSIRF is typically invoked through specific modules. While specific flags depend on the version, the following functional areas represent the standard workflow:

### 1. Demultiplexing (demux)
Used to assign raw sequencing reads to specific samples based on barcodes or index sequences.
- **Purpose**: Separate pooled library reads into individual sample files.
- **Key Task**: Use this module first when starting with raw FASTQ data.
- **Tip**: Ensure your mapping file correctly associates barcodes with sample IDs.

### 2. Normalization (norm)
Adjusts raw peptide counts to account for differences in sequencing depth across samples.
- **Purpose**: Make counts comparable across different runs or samples.
- **Workflow**: Run this after demultiplexing and alignment/counting.

### 3. Statistical Scoring (zscore)
Calculates Z-scores for peptides, typically by comparing experimental samples against a set of negative controls (e.g., mock IP or pre-pandemic sera).
- **Purpose**: Identify peptides with signals significantly higher than background noise.
- **Best Practice**: Use a robust set of negative controls to ensure accurate Z-score distribution.

### 4. Enrichment Analysis (penrich)
Identifies peptides that show significant enrichment across the dataset.
- **Purpose**: Filter for high-confidence hits.
- **Output**: Often results in a matrix of enriched peptides used for downstream visualization or epitope mapping.

### 5. Subsetting and Joining (subjoin)
Manipulates peptide matrices by joining multiple datasets or subsetting based on specific criteria.
- **Purpose**: Data management and preparation for meta-analyses.

## Script-Based Utilities
The framework includes several specialized Python scripts for advanced analysis:
- **Epitope Mapping**: Use `findEpitopes_highDensityTiling.py` and `epitopeLevelScores.py` to move from individual peptide hits to localized epitopes.
- **Clustering**: Use `bulkClustering.py` or `clustTaxSum.py` to group peptides by sequence similarity or taxonomic origin.
- **Correlation**: Use `matrixCorrelations.py` to assess reproducibility between replicates.

## Best Practices
- **Environment**: Install via Bioconda (`conda install bioconda::pepsirf`) to ensure all C++ and Boost dependencies are correctly linked.
- **Memory Management**: For large-scale demultiplexing or deconvolution, ensure the system has sufficient RAM, as these processes can be memory-intensive.
- **Parallelization**: Many PepSIRF modules support multi-threading; always check for thread-related flags to speed up processing of large FASTQ files.

## Reference documentation
- [PepSIRF GitHub Repository](./references/github_com_LadnerLab_PepSIRF.md)
- [Bioconda PepSIRF Overview](./references/anaconda_org_channels_bioconda_packages_pepsirf_overview.md)