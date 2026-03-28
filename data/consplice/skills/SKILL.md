---
name: consplice
description: ConSplice is a bioinformatics toolset that measures splicing constraint and integrates machine learning to identify pathogenic alternative splicing variants. Use when user asks to calculate splicing constraint scores, interpret variant pathogenicity using ConSpliceML, or identify rare disease variants outside traditional exon-intron junctions.
homepage: https://github.com/mikecormier/ConSplice
---

# consplice

## Overview

ConSplice is a specialized bioinformatics toolset designed to improve the interpretation of alternative splicing variants, particularly those associated with rare diseases. It functions through two primary components: a statistical model that measures splicing constraint across the human genome using population data (gnomAD) and splicing predictions (SpliceAI), and a machine learning model (ConSpliceML) that integrates these constraint scores with per-nucleotide predictions from SpliceAI and SQUIRLS. This approach allows for the identification of pathogenic variants both within and outside traditional exon-intron junctions.

## Installation and Environment Setup

ConSplice is distributed via Bioconda. It is highly recommended to use `mamba` for faster dependency resolution.

1.  **Configure Conda Channels**:
    Ensure your channels are prioritized correctly to avoid package conflicts:
    ```bash
    conda config --add channels defaults
    conda config --add channels ggd-genomics
    conda config --add channels bioconda
    conda config --add channels conda-forge
    ```

2.  **Install ConSplice**:
    ```bash
    conda install consplice
    ```

## Data Preparation

ConSplice requires specific genomic datasets (gnomAD, SpliceAI, GENCODE). Use the provided "Data Recipes" to ensure data compatibility and reproducibility.

*   **Data Recipes**: Located in the `data_recipes/` directory of the source repository. These scripts automate the curation of required reference files.
*   **Dependencies**: Ensure `htslib`, `bcftools`, and `pysam` are available in your path, as ConSplice relies on these for VCF and fasta processing.

## Core Workflow and CLI Usage

The primary entry point for the tool is the `consplice` command.

### 1. Calculating Splicing Constraint
The tool generates an Observed (O) to Expected (E) ratio to infer genetic constraint:
*   **Low O/E Score**: Indicates fewer observed splicing variants than expected; the region is **constrained** (intolerant to mutation).
*   **High O/E Score**: Indicates more observed variants; the region is **unconstrained** (tolerant).

### 2. Interpreting Percentile Scores
ConSplice transforms O/E ratios into percentiles (0.0 to 1.0):
*   **1.0**: Completely constrained/intolerant against aberrant splicing.
*   **0.0**: Completely unconstrained/tolerant.
*   **Expert Tip**: Focus on variants in regions with high percentile scores (e.g., >0.9) when searching for pathogenic candidates in rare disease cases.

### 3. Running ConSpliceML
ConSpliceML is an ensemble machine learning approach. To score variants, you must provide a feature vector containing:
*   **ConSplice Constraint Score**
*   **SpliceAI Score** (per-base prediction)
*   **SQUIRLS Score** (per-base prediction)

The model uses these features to identify potential pathogenic variants that might be missed by single-tool analysis.

## Best Practices

*   **Beyond the Junction**: Use ConSplice specifically to investigate deep intronic or exonic variants that are outside the standard +/- 2bp splice sites, as these are often ignored in clinical pipelines but are vital for proper splicing.
*   **Feature Integration**: When training or scoring with ConSpliceML, ensure that the SpliceAI and SQUIRLS scores are pre-calculated for the same genomic coordinates as your ConSplice scores.
*   **Platform Compatibility**: While `noarch`, ConSplice has known installation complexities on newer ARM-based macOS (M1/M2). Use a Linux-based environment or a Rosetta-enabled terminal if issues arise.



## Subcommands

| Command | Description |
|---------|-------------|
| ConSplice | ConSplice: error: argument command: invalid choice: 'ml' (choose from 'ML', 'constraint') |
| ConSplice constraint | Module to generate genic or regional splicing constraint using patterns of purifying selection and evidence of alternative splicing |

## Reference documentation
- [ConSplice GitHub README](./references/github_com_mikecormier_ConSplice_blob_main_README.md)
- [ConSplice Setup Configuration](./references/github_com_mikecormier_ConSplice_blob_main_setup.py.md)
- [Data Recipes Overview](./references/github_com_mikecormier_ConSplice_tree_main_data_recipes.md)