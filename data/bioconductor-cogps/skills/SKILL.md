---
name: bioconductor-cogps
description: The coGPS package identifies genes that exhibit outlier expression patterns across multiple integrated high-throughput data types in a subset of samples. Use when user asks to calculate outlier statistics using PCOPA, perform permutation testing for gene significance, visualize top-ranked outlier genes, or generate patient-specific outlier gene lists.
homepage: https://bioconductor.org/packages/release/bioc/html/coGPS.html
---


# bioconductor-cogps

## Overview
The `coGPS` package is designed to identify genes that are disregulated in only a subset of samples, a common occurrence in cancer studies where traditional differential expression (DE) analysis might fail. It integrates multiple types of high-throughput data (e.g., Gene Expression, Methylation, and Copy Number Variation) to find genes that act as outliers. It supports two primary outlier patterns:
1. **Uniform Outliers**: Genes that show outlier behavior across all integrated data types.
2. **Subtype Outliers**: Genes that show outlier behavior in at least one data type or study, even if they behave normally in others.

## Data Preparation
Input data must be organized into a specific list structure called `exprslist`.

1.  **Structure**: A list of lists. Each sub-list represents one study or data type.
2.  **Elements**:
    *   `exprs`: A matrix where rows are genes and columns are samples. Must have `rownames` (gene symbols) and `colnames` (sample IDs).
    *   `classlab`: A 0/1 integer vector. `0` for baseline/control, `1` for comparison/tumor.

```r
library(coGPS)

# Example for one data type
study1 <- list(exprs = as.matrix(exon_data), classlab = as.vector(exon_labels))
study2 <- list(exprs = as.matrix(methy_data), classlab = as.vector(methy_labels))

# Combine into exprslist
trylist <- list(study1, study2)
```

## Main Workflow

### 1. Calculating Outlier Statistics (PCOPA)
The `PCOPA` function is the core tool for calculating outlier scores.

*   **side**: Specifies the direction of the outlier for each data type in `trylist`. Use `"up"` for over-expression/amplification and `"down"` for hypo-methylation/under-expression.
*   **type**: Either `"subtype"` (max outlier count across studies) or `"uniform"` (sum of outliers across studies).

```r
# Find genes over-expressed in Exon, hypo-methylated in Methy, and amplified in CNV
# Using subtype logic
results <- PCOPA(trylist, alpha = 0.05, side = c("up", "down", "up"), type = "subtype")
```

### 2. Permutation Testing
To determine the statistical significance of the PCOPA scores, use `permCOPA`.

```r
# Run permutations (e.g., 100 permutations)
perma_results <- permCOPA(trylist, 0.05, side = c("up", "down", "up"), type = "subtype", perms = 100)

# Calculate p-values for each gene
pvalues <- sapply(1:length(results), function(i) {
  length(which(perma_results[i, ] > results[i])) / ncol(perma_results)
})
```

### 3. Visualization
Visualize the expression patterns of top-ranked outlier genes across the different data types.

```r
# Plot the top 1 ranked gene
PlotTopPCOPA(trylist, results, topcut = 1, typelist = c("Exon", "Methy", "CNV"))
```

### 4. Patient-Specific Outlier Lists
Identify which specific genes are outliers for a specific patient. **Note**: For this function, samples across all data types in `trylist` must be in the same order.

```r
# Get lists of outlier genes for each individual patient
indiv_lists <- PatientSpecificGeneList(trylist, 0.05, side = c("up", "down", "up"), 
                                       type = "subtype", TopGeneNum = 100)

# View outlier genes for the first patient in the first data type
print(indiv_lists[[1]][[1]])
```

## Downstream Analysis (GSEA)
You can use the PCOPA statistics as a ranking metric for Gene Set Enrichment Analysis using the `wilcoxGST` function from the `limma` package.

```r
library(limma)
# Assuming 'gene_set' is a vector of gene names in a pathway
index <- rownames(trylist[[1]]$exprs) %in% gene_set
p_gsea <- wilcoxGST(index, results)
```

## Tips and Best Practices
*   **Sample Matching**: While `PCOPA` and GSEA do not strictly require samples to be matched across data types (they operate on empirical distributions), `PatientSpecificGeneList` **requires** that `exprslist[[i]]$exprs[,j]` refers to the same patient `j` across all `i`.
*   **Alpha Parameter**: The `alpha` in `PCOPA` is used for the internal Bonferroni correction when defining the binary outlier matrix.
*   **Memory**: For large datasets with many permutations, `permCOPA` can be computationally intensive. Consider starting with a low number of permutations to test the pipeline.

## Reference documentation
- [coGPS](./references/coGPS.md)