---
name: bioconductor-comethdmr
description: This tool identifies co-methylated and differentially methylated regions in Illumina 450k or EPIC array data using mixed-effects models. Use when user asks to identify clusters of correlated CpGs, perform regional methylation analysis, or test associations between genomic regions and continuous phenotypes.
homepage: https://bioconductor.org/packages/release/bioc/html/coMethDMR.html
---

# bioconductor-comethdmr

name: bioconductor-comethdmr
description: Identify co-methylated and differentially methylated regions (DMRs) in Illumina 450k/EPIC array data. Use this skill to perform regional methylation analysis using random coefficient mixed effects models, specifically for identifying contiguous co-methylated sub-regions associated with continuous phenotypes.

## Overview

coMethDMR is a Bioconductor package designed to identify genomic regions that are both co-methylated and differentially methylated. Unlike methods that test every CpG individually, coMethDMR first identifies co-methylated sub-regions (clusters of CpGs with high correlation) in a data-driven manner without using outcome information. It then tests these sub-regions for association with a continuous phenotype using mixed-effects models, which account for both the correlation between CpGs and the variation within the region.

## Core Workflow

### 1. Data Preparation
Input data should be a data frame of methylation beta values (rows = CpGs, columns = Samples) and a phenotype data frame containing a "Sample" column to link to the methylation data.

```r
library(coMethDMR)
data(betasChr22_df)
data(pheno_df)

# Optional: Remove technical/biological noise before identifying clusters
resid_mat <- GetResiduals(
  dnam = betasChr22_df,
  betaToM = TRUE, 
  pheno_df = pheno_df,
  covariates_char = c("age.brain", "sex", "slide")
)
```

### 2. Define Genomic Regions
You can use pre-defined regions (genic/intergenic) or define your own based on proximity.

```r
# Load pre-defined genic regions for 450k array
gene_ls <- readRDS(system.file("extdata", "450k_Gene_3_200.rds", package = 'coMethDMR'))

# Or define regions for a specific set of CpGs
my_regions <- CloseBySingleRegion(
  CpGs_char = c("cg00079563", "cg01029450", "cg02351223"),
  arrayType = "450k",
  maxGap = 200,
  minCpGs = 3
)
```

### 3. Identify Co-methylated Sub-regions
Use `CoMethAllRegions` to find contiguous clusters of CpGs where each CpG has a correlation (r-drop) > 0.4 with the rest of the cluster.

```r
coMeth_ls <- CoMethAllRegions(
  dnam = resid_mat, # Use residuals if available
  betaToM = FALSE,
  method = "pearson",
  CpGs_ls = gene_ls,
  arrayType = "450k",
  nCores_int = 1 # Increase for parallel processing
)
```

### 4. Statistical Testing
Test the identified regions against a continuous phenotype using `lmmTestAllRegions`. The "randCoef" model is recommended as it models random probe effects.

```r
results_df <- lmmTestAllRegions(
  betas = betasChr22_df,
  region_ls = coMeth_ls,
  pheno_df = pheno_df,
  contPheno_char = "stage",
  covariates_char = c("age.brain", "sex"),
  modelType = "randCoef",
  arrayType = "450k"
)
```

### 5. Annotation and Inspection
Annotate the results with gene names and relation to CpG islands.

```r
# Annotate summary results
annotated_results <- AnnotateResults(lmmRes_df = results_df, arrayType = "450k")

# Inspect individual CpG p-values within a specific significant region
cpg_info <- CpGsInfoOneRegion(
  regionName_char = "chr22:18268062-18268249",
  betas_df = betasChr22_df,
  pheno_df = pheno_df,
  contPheno_char = "stage",
  arrayType = "450k"
)
```

## Parallel Computing
For large datasets (entire arrays), use the `nCores_int` argument in `GetResiduals`, `CoMethAllRegions`, and `lmmTestAllRegions` to leverage `BiocParallel`.

```r
library(BiocParallel)
# Example: Using 4 cores
coMeth_ls <- CoMethAllRegions(..., nCores_int = 4)
```

## Tips and Troubleshooting
- **Convergence Warnings**: If a mixed model fails to converge, the p-value is set to 1. This usually happens in regions with high noise.
- **Singular Fit**: A "boundary (singular) fit" message means a variance component is estimated at 0. The p-values remain valid; the model effectively reduces to a fixed-effects model.
- **M-values vs Beta-values**: While beta values are used for input, the package often converts them to M-values (`betaToM = TRUE`) for statistical testing as they are more homoscedastic.
- **Sample Column**: Ensure your phenotype data frame has a column named exactly "Sample" to match the column names of your methylation matrix.

## Reference documentation
- [Introduction to coMethDMR](./references/vin1_Introduction_to_coMethDMR_geneBasedPipeline.md)
- [coMethDMR with Parallel Computing](./references/vin2_BiocParallel_for_coMethDMR_geneBasedPipeline.md)