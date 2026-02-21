---
name: consplice
description: ConSplice is a Python-based framework designed to improve the interpretation of alternative splicing variants, particularly those located outside of traditional exon-intron junctions.
homepage: https://github.com/mikecormier/ConSplice
---

# consplice

## Overview
ConSplice is a Python-based framework designed to improve the interpretation of alternative splicing variants, particularly those located outside of traditional exon-intron junctions. It functions by combining population-level purifying selection data from gnomAD with per-nucleotide splicing predictions from tools like SpliceAI. By establishing a "splicing constraint" model, it identifies regions of the genome where cryptic splicing is evolutionary discouraged, allowing for the identification of rare disease variants that general-purpose tools might overlook.

## Installation and Environment Setup
ConSplice is distributed via Bioconda. It is recommended to use `mamba` for faster dependency resolution.

```bash
# Configure necessary channels
conda config --add channels defaults
conda config --add channels ggd-genomics
conda config --add channels bioconda
conda config --add channels conda-forge

# Create and activate environment
mamba create --name ConSplice python=3 consplice
mamba activate ConSplice
```

## Core Functional Logic
The tool operates on two primary levels:

1.  **Constraint Modeling**:
    *   **Substitution Matrix**: Built using gnomAD and SpliceAI to create an expectation of splicing mutations.
    *   **O/E Ratio**: Calculates the ratio of Observed (O) variation to Expected (E) variation.
    *   **Percentile Scoring**: O/E ratios are transformed into percentiles (0.0 to 1.0).

2.  **ConSpliceML (Ensemble ML)**:
    *   Integrates ConSplice constraint scores with per-base predictions from **SpliceAI** and **SQUIRLS**.
    *   Requires all three scores (ConSplice, SpliceAI, SQUIRLS) as input parameters for the current version of the ML model.

## Interpreting Results
When analyzing output scores, use the following heuristics:
*   **High Percentile (approaching 1.0)**: Indicates the region is highly constrained (intolerant) against aberrant splicing. Variants here are more likely to be pathogenic.
*   **Low Percentile (approaching 0.0)**: Indicates the region is unconstrained (tolerant). Variants here are more likely to be benign.
*   **Small O/E Ratio**: Suggests fewer observed splicing variants than expected, signifying high constraint.

## Data Preparation
ConSplice is data-intensive and requires specific curation of genomic resources.
*   **Data Recipes**: Use the scripts provided in the `data_recipes` directory of the installation to curate required datasets (gnomAD, SpliceAI, GENCODE).
*   **Prerequisites**: Ensure all data curation recipes are completed before attempting to run the CLI for scoring or modeling.

## Expert Tips
*   **Architecture Note**: If installing on Apple Silicon (M1/M2/M3), force the x86 architecture using `CONDA_SUBDIR=osx-64` during environment creation, as some dependencies do not yet support ARM64.
*   **Beyond Junctions**: Use ConSplice specifically to investigate deep intronic or exonic variants that do not disrupt the canonical +/- 2bp splice sites but are predicted to create cryptic splice sites in constrained regions.

## Reference documentation
- [ConSplice GitHub Repository](./references/github_com_mikecormier_ConSplice.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_consplice_overview.md)