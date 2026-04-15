---
name: bioconductor-pirat
description: bioconductor-pirat performs specialized missing value imputation for bottom-up proteomics data by leveraging peptide-protein adjacency information and accounting for random left-truncation. Use when user asks to impute missing values in peptide-level abundance matrices, incorporate peptide-protein relationships into imputation, or integrate transcriptomic data to handle singleton peptides.
homepage: https://bioconductor.org/packages/release/bioc/html/Pirat.html
---

# bioconductor-pirat

name: bioconductor-pirat
description: Specialized imputation for bottom-up proteomics data using the Pirat R package. Use this skill to perform single imputation on peptide-level abundance matrices, leverage peptide-protein adjacency information (Peptide Groups), and apply extensions for singleton peptides including sample-wise correlations and transcriptomic integration.

## Overview

Pirat is a Bioconductor package designed for missing value imputation in label-free LC-MS/MS proteomics. It uses a statistical approach that incorporates the relationship between peptides and their parent proteins (Peptide Groups or PGs) and accounts for random left-truncation mechanisms (missingness related to low abundance).

## Installation

The package requires both R and a Python environment (managed automatically via `basilisk`).

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Pirat")
```

## Data Structure

Pirat functions typically expect a list containing:
1. `peptides_ab`: A matrix of log2-abundance values (Samples in rows, Peptides in columns).
2. `adj`: An adjacency matrix (Peptides x Proteins) containing booleans or 0/1 values.

## Standard Workflow

The primary function for imputation is `my_pipeline_llkimpute()`.

```r
library(Pirat)

# Load example data
data(subbouyssie)

# Set seed for reproducibility (large PGs are randomly split for speed)
set.seed(12345)

# Run imputation
imp.res <- my_pipeline_llkimpute(subbouyssie)

# Access results
imputed_matrix <- imp.res$data.imputed
params <- imp.res$params # Contains alpha, beta, gamma0, gamma1
```

**Note on Gamma1:** A positive `gamma1` value in `imp.res$params` indicates the presence of a random left-truncation mechanism in the dataset.

## Diagnostic Tools

Use `plot_pep_correlations` to determine if Peptide Group (PG) information is informative for your dataset.

```r
data(ropers)
plot_pep_correlations(ropers, titlename = "My Dataset")
```
If the distribution of intra-PG correlations (blue) is shifted toward higher values compared to random correlations (red), Pirat's PG-based imputation will be highly effective.

## Handling Singleton Peptides (Extensions)

Singletons (peptides belonging to a PG of size 1) can be handled using the `extension` parameter:

### 1. No Imputation for Singletons ("2")
The "-2" rule skips imputation for singleton PGs.
```r
imp.res <- my_pipeline_llkimpute(subropers, extension = "2")
```

### 2. Sample-wise Correlations ("S")
Leverages the sample-wise covariance matrix to impute singletons.
```r
imp.res <- my_pipeline_llkimpute(subropers, extension = "S")
```

### 3. Transcriptomic Integration ("T")
Uses correlations between peptides and gene/transcript expression. Requires `rnas_ab` (log2-normalized counts) and `adj_rna_pg` (transcript-to-PG adjacency) in the input list.

```r
# For paired samples
imp.res <- my_pipeline_llkimpute(subropers,
    extension = "T",
    rna.cond.mask = seq(nrow(subropers$peptides_ab)),
    pep.cond.mask = seq(nrow(subropers$peptides_ab)),
    max.pg.size.pirat.t = 1)
```

## Reference documentation

- [Pirat Vignette (Rmd)](./references/Pirat.Rmd)
- [Pirat Vignette (Markdown)](./references/Pirat.md)