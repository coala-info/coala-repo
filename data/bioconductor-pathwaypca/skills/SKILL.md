---
name: bioconductor-pathwaypca
description: This tool performs integrative pathway analysis using Principal Component Analysis approaches to test associations between gene sets and various phenotypes. Use when user asks to test pathway associations with binary, continuous, or survival phenotypes, extract genes driving pathway significance, or compute subject-specific pathway activity scores for multi-omics integration.
homepage: https://bioconductor.org/packages/release/bioc/html/pathwayPCA.html
---

# bioconductor-pathwaypca

name: bioconductor-pathwaypca
description: Perform integrative pathway analysis using Principal Component Analysis (PCA) based approaches (AES-PCA and Supervised PCA). Use this skill to test pathway associations with binary, continuous, or survival phenotypes, extract relevant genes driving pathway significance, and compute subject-specific pathway activity scores (PCs) for multi-omics integration.

# bioconductor-pathwaypca

## Overview

The `pathwayPCA` package implements advanced PCA-based methodologies for gene set enrichment and pathway analysis. It is particularly powerful for analyzing multi-omics data and complex experimental designs (e.g., interaction effects). The package supports two primary methods:
1. **AES-PCA (Adaptive, Elastic-net, Sparse PCA):** An unsupervised approach for extracting pathway-specific latent variables, followed by association testing.
2. **Supervised PCA (SuperPCA):** A supervised approach that selects a subset of genes most associated with the phenotype before estimating the latent variables.

## Typical Workflow

### 1. Data Preparation
Data must be organized into three components: assay data (features in columns, samples in rows), phenotype/response data, and a pathway collection (typically from a `.gmt` file).

```r
library(pathwayPCA)
library(tidyverse)

# 1. Load Assay Data (Samples in rows, Genes in columns)
# If your data has genes in rows, use TransposeAssay()
assay_df <- read_csv("your_data.csv")
assayT_df <- TransposeAssay(assay_df)

# 2. Load Pathway Collection
# Supports MSigDB or WikiPathways .gmt files
gmt_path <- system.file("extdata", "wikipathways_human_symbol.gmt", package = "pathwayPCA")
pathways_ls <- read_gmt(gmt_path, description = TRUE)

# 3. Load Phenotype Data
pheno_df <- read_csv("phenotype.csv")
```

### 2. Create Omics Data Objects
The `CreateOmics` function acts as a container for the three data components. Specify the `respType` based on your study design.

```r
# For Survival Analysis
my_omics <- CreateOmics(
  assayData_df = assayT_df,
  pathwayCollection_ls = pathways_ls,
  response = pheno_df,
  respType = "survival", # Options: "survival", "regression", "categorical"
  minPathSize = 5
)
```

### 3. Test Pathway Significance
Use `AESPCA_pVals` or `SuperPCA_pVals`. AES-PCA is generally recommended for its computational efficiency and ability to handle sparse data.

```r
# Perform AES-PCA
results <- AESPCA_pVals(
  object = my_omics,
  numPCs = 1,
  parallel = TRUE,
  numCores = 2,
  numReps = 0,        # 0 for parametric p-values; >0 for permutation
  adjustment = "BH"   # FDR control
)

# View top pathways
getPathpVals(results, numPaths = 10)
```

### 4. Extract and Visualize Results
You can extract subject-specific scores (PCs) and gene-specific loadings to understand what drives the pathway significance.

```r
# Extract PCs and Loadings for a specific pathway (e.g., "WP195")
path_data <- getPathPCLs(results, "WP195")

# Extract raw data for a pathway for custom plotting (e.g., Heatmaps)
pathway_raw <- SubsetPathwayData(my_omics, "WP195")

# Plotting pathway scores (Negative LN p-values)
score_df <- getPathpVals(results, score = TRUE)
ggplot(score_df) + aes(x = reorder(terms, score), y = score) + geom_col() + coord_flip()
```

## Advanced Usage: Interaction Effects
To test if pathway associations differ between groups (e.g., Sex), extract the first PC and fit a model with an interaction term.

```r
# Extract PC1 for a pathway
pc1 <- getPathPCLs(results, "WP1559")$PCs %>% select(PC1 = V1)
data_int <- bind_cols(pheno_df, pc1)

# Fit Cox model with interaction
fit <- coxph(Surv(time, status) ~ PC1 * group_var, data = data_int)
summary(fit)
```

## Tips for Success
- **Gene Symbols:** Ensure the gene identifiers in your assay data match the identifiers in your `.gmt` file (e.g., both use HGNC Symbols or both use Entrez IDs).
- **Data Cleaning:** Use `TransposeAssay()` if your input file has genes as rows. `pathwayPCA` expects samples as rows for the `Omics` object.
- **Parallelization:** For large datasets (especially CNV or RNA-seq), always set `parallel = TRUE` in the testing functions to reduce computation time.
- **S4 Accessors:** Use `getAssay()`, `getPathwayCollection()`, and `getEventTime()` to inspect `Omics` objects rather than accessing slots directly.

## Reference documentation
- [Integrative Pathway Analysis with pathwayPCA](./references/Introduction_to_pathwayPCA.md)
- [Quickstart Guide for New R Users](./references/Supplement1-Quickstart_Guide.md)
- [Importing and Tidying Data](./references/Supplement2-Importing_Data.md)
- [Creating Omics Data Objects](./references/Supplement3-Create_Omics_Objects.md)
- [Test Pathway Significance Walkthrough](./references/Supplement4-Methods_Walkthrough.md)
- [Visualizing and Analyzing Results](./references/Supplement5-Analyse_Results.md)