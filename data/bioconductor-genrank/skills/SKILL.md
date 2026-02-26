---
name: bioconductor-genrank
description: The GenRank package prioritizes candidate genes by integrating results from multiple independent evidence layers such as different -omics studies or experimental contexts. Use when user asks to rank genes using convergent evidence, calculate rank products across replicates, or combine p-values from multiple studies using meta-analysis techniques.
homepage: https://bioconductor.org/packages/3.6/bioc/html/GenRank.html
---


# bioconductor-genrank

## Overview

The `GenRank` package provides methods to prioritize candidate genes by consolidating results from multiple "evidence layers." An evidence layer represents an independent line of investigation, such as different -omics technologies (GWAS, RNA-seq), studies in different tissues, or experiments across different species. By integrating these layers, researchers can identify genes that show consistent significance across diverse biological contexts.

The package implements three primary ranking strategies:
1.  **Convergent Evidence (CE):** A PageRank-inspired voting system.
2.  **Rank Product (RP):** A geometric mean-based method that accounts for consistency across replicates.
3.  **Combined P-values:** Traditional meta-analysis techniques (Fisher, Stouffer/Z-transform, Logit).

## Input Data Format

All functions require a tab-delimited text file with no header. The structure should be:
- **Column 1:** Gene symbols or names.
- **Column 2:** Evidence layer identifier (e.g., "SNP", "RNA", "Study1").
- **Column 3:** Significance statistic (p-value or effect size). *Note: CE method only requires the first two columns.*

Duplicate genes within a single evidence layer are automatically handled by retaining only the most significant entry (lowest p-value or highest effect size).

## Workflows

### 1. Convergent Evidence (CE) Method
Use this when you want to rank genes based on the frequency of their appearance across layers, optionally weighted by the "credibility" of each layer.

```r
library(GenRank)
input_file <- "path/to/your_data.txt"

# Equal weight to all layers
ce_results <- ComputeCE(input_file, PC = "equal")

# Weight by number of genes in each layer (PageRank style)
ce_results_ngene <- ComputeCE(input_file, PC = "ngene")

# Custom weights (e.g., based on sample size or technology reliability)
weights <- c(1.0, 0.8, 0.5) # Must match the order of layers in the data
ce_results_custom <- ComputeCE(input_file, PC = "custom", cust.weights = weights)
```

### 2. Rank Product (RP) Method
Use this to identify genes consistently ranked high across layers. It uses permutations to estimate the Proportion of False Predictions (PFP).

```r
# signif.type: 'L' for low values (p-values), 'H' for high values (effect sizes)
signif_types <- c('L', 'L', 'H') 

rp_results <- ComputeRP(input_file, 
                        signif.type = signif_types, 
                        n.perm = 100, 
                        setseed = 123)
```

### 3. Combining P-values
Use this for traditional meta-analysis when p-values are available across layers.

```r
# method: "fisher", "z.transform", or "logit"
# na.remove: Set to TRUE if genes are missing in some layers
cp_results <- CombP(input_file, 
                    method = "fisher", 
                    na.remove = TRUE)

# Weighted Z-transform (Stouffer's method)
custom_weights <- c(100, 200, 150)
cp_results_z <- CombP(input_file, 
                      method = "z.transform", 
                      na.remove = TRUE, 
                      weight = custom_weights)
```

## Tips for Success
- **Phenotypic Homogeneity:** Ensure that all evidence layers are investigating the same phenotype to make the integration biologically meaningful.
- **Missing Data:** The `CombP` function requires a gene to be present in at least 60% of the evidence layers to return a result.
- **Custom Weights:** When using `PC = "custom"` or `method = "z.transform"`, ensure the length of your weight vector matches the number of unique evidence layers in your input file.

## Reference documentation
- [Introduction to GenRank Package](./references/GenRank_Vignette.Rmd)