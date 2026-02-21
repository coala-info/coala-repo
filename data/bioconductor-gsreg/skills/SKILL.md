---
name: bioconductor-gsreg
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GSReg.html
---

# bioconductor-gsreg

name: bioconductor-gsreg
description: Analyze gene set variability and dysregulation in gene expression data using DIRAC (Differential Rank Conservation) and EVA (Gene Set Expression Variation Analysis). Use this skill to identify pathways with significant changes in expression variability between phenotypes, or to perform SEVA (Splice-EVA) for alternative splicing analysis using junction expression data.

# bioconductor-gsreg

## Overview

The `GSReg` package provides tools for gene set analysis based on expression variability rather than just differential expression. It implements the DIRAC (Differential Rank Conservation) algorithm and a more computationally efficient method called EVA (Gene Set Expression Variation Analysis) based on U-statistics and Kendall-tau distance. These methods are particularly useful for identifying dysregulated pathways in cancers and other diseases where gene-gene coordination is disrupted.

## Data Preparation

To use `GSReg`, you need three primary inputs:

1.  **Gene Expression Matrix**: A matrix where rows are genes (with names) and columns are samples. It must not contain `NA` values.
2.  **Pathways**: A named list of character vectors, where each vector contains gene names corresponding to the rownames of the expression matrix.
3.  **Phenotypes**: A factor with exactly two binary levels (e.g., "Normal" and "Disease").

```R
# Remove NAs from expression data
exprsdata <- exprsdata[!apply(is.na(exprsdata), 1, any), ]

# Ensure phenotypes is a factor
phenotypes <- as.factor(phenotypes)
```

## DIRAC Analysis

DIRAC calculates the variability of gene ordering within a pathway. It uses a permutation test or normal approximation to calculate p-values.

```R
library(GSReg)

# Using Normal Approximation (Nperm=0, default)
DIRAC_results <- GSReg.GeneSets.DIRAC(exprsdata, pathways, phenotypes)

# Using Permutation Test
DIRAC_perm <- GSReg.GeneSets.DIRAC(exprsdata, pathways, phenotypes, Nperm = 1000)

# Accessing results
pvals <- DIRAC_results$pvalues
mu1 <- DIRAC_results$mu1 # Variability in phenotype level 1
mu2 <- DIRAC_results$mu2 # Variability in phenotype level 2
```

## EVA (Gene Set Expression Variation Analysis)

EVA is a faster alternative to DIRAC that uses U-statistics theory to approximate p-values without intensive permutations.

```R
# Run EVA
EVA_results <- GSReg.GeneSets.EVA(geneexpres = exprsdata, 
                                 pathways = pathways, 
                                 phenotypes = phenotypes)

# EVA returns a list where each element is a pathway
pathway_1 <- EVA_results[[1]]
pathway_pvalue <- pathway_1$pvalue
pathway_variability_1 <- pathway_1$E1
pathway_variability_2 <- pathway_1$E2
```

## SEVA (Splice-EVA)

SEVA applies the EVA principle to alternative splicing by analyzing junction expression variability. It requires a junction overlap matrix.

```R
# Generate junction overlap matrix
overlapMat <- GSReg.overlapJunction(juncExprs = junction_matrix, 
                                    geneexpr = gene_expression_matrix)

# SEVA analysis follows a similar pattern to EVA using junction data
# (Requires specific junction-level data structures)
```

## Workflow Tips

*   **Efficiency**: Use `GSReg.GeneSets.EVA` for large-scale pathway analysis or when multiple hypothesis correction requires very low p-values, as it is significantly faster than DIRAC permutations.
*   **Pathway Size**: Use the `minGeneNum` parameter in analysis functions to exclude pathways that are too small (e.g., < 5 genes) after filtering for genes present in your expression data.
*   **Interpretation**: Higher variability (E1 or E2) typically indicates a more "dysregulated" or pathological state. A significant p-value indicates that the coordination of gene expression within that pathway differs significantly between the two groups.

## Reference documentation

- [GSReg: A Package for Gene Set Variability Analysis](./references/GSReg.md)