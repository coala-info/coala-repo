---
name: maaslin2
description: MaAsLin2 determines associations between clinical metadata and microbial features using multivariable linear models. Use when user asks to perform microbiome association analysis, account for fixed and random effects in longitudinal studies, or identify correlations between metadata and microbial abundances.
homepage: http://huttenhower.sph.harvard.edu/maaslin2
metadata:
  docker_image: "quay.io/biocontainers/maaslin2:1.16.0--r43hdfd78af_0"
---

# maaslin2

## Overview

MaAsLin2 (Microbiome Multivariable Association with Linear Models) is a comprehensive tool for determining associations between clinical metadata and microbial features. It is specifically designed to handle the unique challenges of microbiome data, such as sparsity, compositionality, and non-normality. It allows for complex statistical modeling, including fixed and random effects, making it suitable for both cross-sectional and longitudinal studies.

## Command Line Usage

The command-line interface for MaAsLin2 is typically invoked via an R script wrapper.

### Basic Execution
Run a standard association analysis by providing the feature table, metadata, and an output directory:
`Rscript Maaslin2.R input_data.tsv metadata.tsv output_dir`

### Key Arguments
- `--fixed_effects`: Specify a comma-separated list of metadata columns to include as predictors (e.g., `Age,Diagnosis,Treatment`).
- `--random_effects`: Specify columns for random effects, such as `Subject_ID` for longitudinal data.
- `--reference`: Define the reference level for categorical variables (e.g., `Diagnosis,Control`).
- `--normalization`: Choose the normalization method. Options include `TSS` (default), `CLR`, `CSS`, `NONE`, or `TMM`.
- `--transform`: Choose the transformation method. Options include `LOG` (default), `LOGIT`, or `AST`.
- `--analysis_method`: Select the underlying model. Options include `LM` (Linear Model, default), `GLM`, `NEGBIN` (Negative Binomial), or `ZINB` (Zero-inflated Negative Binomial).

## Expert Tips and Best Practices

### Data Preprocessing
- **Filtering**: Use `--min_abundance` (default 0.0) and `--min_prevalence` (default 0.1) to remove low-signal features before analysis to improve statistical power and reduce the multiple testing burden.
- **Feature Table Format**: Ensure the input feature table has features as columns and samples as rows, or vice versa, but maintain consistency with the metadata row names.

### Model Selection
- **Linear Models (LM)**: Use `LM` with `CLR` normalization for most taxonomic datasets.
- **Count Data**: If using raw counts, consider `NEGBIN` or `ZINB` methods, though `LM` on transformed data is often more robust.
- **Confounder Control**: Always include known technical covariates (e.g., DNA extraction batch, sequencing depth) in the `--fixed_effects` list.

### Interpreting Output
- **Significant Results**: Focus on `all_results.tsv`. The `coef` column indicates the direction and strength of the association, while `qval` provides the Benjamini-Hochberg corrected p-value.
- **Visualizations**: Review the automatically generated heatmaps and boxplots in the output directory to validate the top associations visually.

## Reference documentation
- [MaAsLin2 Overview](./references/anaconda_org_channels_bioconda_packages_maaslin2_overview.md)