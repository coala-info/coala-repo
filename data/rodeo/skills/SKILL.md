---
name: rodeo
description: RODEO automates the discovery and classification of RiPP biosynthetic gene clusters by analyzing the genomic neighborhood of core enzymes. Use when user asks to identify small precursor peptides, characterize biosynthetic gene neighborhoods, or score the RiPP-likeness of genomic regions using pHMMs and SVM classifiers.
homepage: http://ripp.rodeo/index.html
---


# rodeo

## Overview
The RODEO (Rapid ORF Description and Evaluation Online) tool is designed for the automated discovery and classification of RiPP biosynthetic gene clusters. It excels at identifying small precursor peptides—which are often missed by traditional annotation pipelines—by analyzing the genomic context (neighborhood) of "core" biosynthetic enzymes. Use this skill to guide the identification of novel natural products through pHMM-based neighborhood scoring and specialized heuristic searches for short ORFs.

## Usage Guidelines

### Core Workflow
1.  **Input Preparation**: Provide protein accessions (NCBI/RefSeq) or genomic coordinates as the starting "seed" genes for neighborhood analysis.
2.  **Neighborhood Characterization**: RODEO scans the flanking regions of the seed gene (typically +/- 10 genes) to identify co-localized biosynthetic, transport, and regulatory genes using a library of RiPP-specific pHMMs.
3.  **Precursor Identification**: For intergenic regions, use RODEO's manual translation feature to find small ORFs (30–100 amino acids) that may represent the RiPP precursor.
4.  **Scoring**: Evaluate the "RiPP-likeness" of a cluster based on the presence of expected tailoring enzymes (e.g., cyclases, dehydratases, or proteases) identified by the SVM classifier.

### Best Practices
*   **Seed Selection**: Use well-characterized biosynthetic enzymes (like YcaO cyclodehydratases or radical SAM enzymes) as seeds to increase the likelihood of finding functional clusters.
*   **Intergenic Search**: When standard annotation fails to show a precursor, focus on the 500bp upstream of the core biosynthetic gene; RiPP precursors are frequently located in these regions.
*   **pHMM Customization**: While RODEO provides a robust set of default profiles, ensure the pHMMs match the specific RiPP class (e.g., lanthipeptides, sactipeptides, or lasso peptides) being targeted.

### Common CLI Patterns
*   **Installation**: Ensure the environment is ready via Bioconda:
    `conda install -c bioconda rodeo`
*   **Basic Execution**: Most implementations require a list of accessions or a local BLAST database to initiate the neighborhood search.
*   **Output Analysis**: Review the generated CSV or HTML reports to identify high-scoring clusters where the SVM confirms the presence of a precursor motif consistent with the surrounding tailoring enzymes.

## Reference documentation
- [rodeo - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_rodeo_overview.md)