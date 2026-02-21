---
name: nedbit-features-calculator
description: The `nedbit-features-calculator` is a specialized tool designed for bioinformatics workflows that identify candidate disease genes.
homepage: https://github.com/AndMastro/NIAPU
---

# nedbit-features-calculator

## Overview

The `nedbit-features-calculator` is a specialized tool designed for bioinformatics workflows that identify candidate disease genes. It functions as the feature engineering core of the NIAPU pipeline, converting raw biological network data into a multi-dimensional feature set. By combining network diffusion metrics with topological information, it creates a representation of genes that is highly effective for machine learning classifiers, particularly in "positive-unlabelled" scenarios where only a few confirmed disease genes (seeds) are known.

## Usage Instructions

### 1. Data Preparation
Ensure your input files follow these specific formats:
- **PPI File**: A text file containing protein-protein interaction links in the format `gene1 gene2` (space or tab-separated).
- **Seed Genes Scores**: A text file in the format `gene score`, where known disease genes have a specific score and others are typically 0.

### 2. Preprocessing
Before calculating features, you must convert gene names into ordinal numbers using the provided Perl script. This step generates the necessary mapping for the C-based calculator.

```bash
perl preprocess.pl ppi_file seed_genes_scores out_links out_genes
```
- `out_links`: Output file containing PPI links as ordinal numbers.
- `out_genes`: Output file containing all PPI genes (non-seed genes are assigned a score of 0).

### 3. Feature Calculation
Run the primary calculator to generate the NeDBIT feature file.

```bash
nedbit_features_calculator out_links out_genes nedbit_features
```
- `nedbit_features`: The resulting file containing the computed topological and diffusion features.

### 4. Adaptive PU Labelling (Optional)
To generate a gene ranking based on the calculated features, use the label propagation tool.

```bash
./apu_label_propagation nedbit_features HEADER_PRESENCE output_gene_ranking 0.05 0.2
```
- `HEADER_PRESENCE`: Use `1` if the features file has a header, `0` otherwise.
- `0.05`: Quantile threshold for removing weak links.
- `0.2`: Quantile threshold for Reliable Negative computation.

## Best Practices and Tips

- **Efficiency**: The core calculator and label propagation tools are written in C. If you are working with large-scale interactomes (e.g., whole-human Biogrid data), ensure you have compiled the binaries locally or installed via Bioconda for maximum performance.
- **Environment**: If using the Bioconda package, the `nedbit-features-calculator` command is available directly in your PATH.
- **Downstream Analysis**: The output `nedbit_features` file is designed to be used as input for machine learning classifiers like Random Forest (RF), Support Vector Machines (SVM), or Multi-Layer Perceptrons (MLP).
- **Missing Genes**: Ensure that all genes present in your `seed_genes_scores` file also exist within the `ppi_file` to avoid inconsistencies during the preprocessing stage.

## Reference documentation
- [NIAPU GitHub Repository](./references/github_com_AndMastro_NIAPU.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_nedbit-features-calculator_overview.md)