---
name: colombo
description: COLOMBO is a bioinformatics framework designed to detect genomic islands acquired through horizontal gene transfer using statistical models like HMMs and CRFs. Use when user asks to identify genomic islands, detect pathogenicity or metabolic islands, or analyze genomic sequences for alien DNA regions.
homepage: https://www.uni-goettingen.de/en/research/185810.html
metadata:
  docker_image: "quay.io/biocontainers/colombo:v4.0--1"
---

# colombo

## Overview
COLOMBO is a specialized bioinformatics framework designed to detect genomic islands—regions of a genome acquired via horizontal gene transfer. It is particularly useful for comparative genomics and identifying pathogenicity or metabolic islands. The tool integrates multiple statistical models, including Hidden Markov Models (SIGI-HMM) and Conditional Random Fields (SIGI-CRF), allowing for the analysis of both annotated and non-annotated genomic sequences.

## Usage Guidelines

### Core Prediction Methods
*   **SIGI-HMM**: Best used for annotated genomes where codon usage bias can be measured against a global or local reference. It utilizes a Hidden Markov Model to transition between "native" and "alien" states.
*   **SIGI-CRF**: Preferred for non-annotated sequences or when higher-order sequence composition (tetramers) is more informative than simple codon bias. It uses order-3 Markov chain transition probabilities.

### Batch Processing with SIGI_CRF-AUTO
For large-scale genomic studies, use the `SIGI_CRF-AUTO` front-end. This component is optimized for:
*   Processing multiple genome sequences in a single batch.
*   Running parameter sweeps to determine the sensitivity of GI predictions.
*   Aggregating results from different parameter sets into a unified graphical representation.

### Installation and Environment
The tool is distributed via Bioconda. Ensure the environment is configured to handle `noarch` packages.
```bash
conda install -c bioconda colombo
```

### Best Practices
*   **Input Preparation**: Ensure prokaryotic sequences are in standard FASTA format. For SIGI-HMM, ensure gene annotations are provided if the specific plugin requires them for codon frequency calculation.
*   **Parameter Tuning**: Genomic island prediction is sensitive to the expected "alien" sequence composition. Use SIGI_CRF-AUTO to test different thresholds if the default settings yield high false-positive rates in AT-rich or GC-rich genomes.
*   **Visualization**: Utilize the GUI components of the framework when manual inspection of predicted islands is required to verify biological relevance (e.g., proximity to tRNA genes or transposases).

## Reference documentation
- [COLOMBO Overview](./references/anaconda_org_channels_bioconda_packages_colombo_overview.md)