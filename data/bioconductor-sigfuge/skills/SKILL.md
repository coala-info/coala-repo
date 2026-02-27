---
name: bioconductor-sigfuge
description: SigFuge analyzes RNA-seq read depth coverage using functional data analysis to identify differential splicing and expression patterns. Use when user asks to cluster samples based on genomic coverage profiles, visualize splicing variations across genes, or calculate significance for identified clusters.
homepage: https://bioconductor.org/packages/release/bioc/html/SigFuge.html
---


# bioconductor-sigfuge

name: bioconductor-sigfuge
description: Analysis of RNA-seq read depth coverage using functional data analysis to identify differential splicing and expression patterns. Use this skill when you need to cluster samples based on genomic coverage profiles, visualize splicing variations across genes, or calculate significance for identified clusters.

# bioconductor-sigfuge

## Overview
SigFuge is a Bioconductor package designed to analyze RNA-seq data by treating read depth coverage as functional data. Unlike standard differential expression tools that aggregate counts over exons or genes, SigFuge identifies clusters of samples that show similar coverage profiles across a genomic region. This allows for the detection of both differential expression (changes in overall magnitude) and differential splicing (changes in the shape of the coverage curve).

## Workflow

1. **Data Preparation**: Input data should be a matrix of read counts where rows represent genomic positions (e.g., bases within a gene) and columns represent samples.
2. **Clustering**: Use the `sigfuge` function to perform functional clustering.
3. **Visualization**: Use `SFfigure` to plot the coverage curves colored by cluster membership to inspect splicing or expression differences.
4. **Significance Testing**: Use `SFpval` to compute p-values for the significance of the clusters found.

## Key Functions

### sigfuge
The primary function for clustering.
```r
# data: matrix of coverage (rows=positions, cols=samples)
# n.cluster: number of clusters to find
res <- sigfuge(data, n.cluster = 2)
```

### SFfigure
Generates plots of the read depth profiles. It produces three plots: the original data, the normalized data (to highlight splicing), and the cluster medians.
```r
# sigfuge.obj: output from sigfuge()
# data: the original data matrix
SFfigure(res, data)
```

### SFpval
Calculates a p-value to determine if the observed clustering is statistically significant compared to a null distribution.
```r
# sigfuge.obj: output from sigfuge()
# data: the original data matrix
# n.perm: number of permutations for p-value calculation
pval_res <- SFpval(res, data, n.perm = 1000)
```

## Usage Tips
- **Normalization**: SigFuge internally handles normalization to distinguish between "expression" (vertical shift) and "splicing" (shape change).
- **Filtering**: It is recommended to filter out genes with very low coverage before running SigFuge to avoid noise.
- **Genomic Coordinates**: While the input is a matrix, you should keep track of the genomic coordinates (e.g., using a `GRanges` object) to map the results back to specific exons or introns.

## Reference documentation
None