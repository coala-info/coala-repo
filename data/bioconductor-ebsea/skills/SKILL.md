---
name: bioconductor-ebsea
description: EBSEA identifies differentially expressed genes by performing statistical testing at the exon level and aggregating results using an empirical Brown’s method. Use when user asks to perform exon-based expression analysis, identify differentially expressed genes from exon counts, or visualize exon-level fold changes and expression patterns.
homepage: https://bioconductor.org/packages/release/bioc/html/EBSEA.html
---


# bioconductor-ebsea

## Overview

EBSEA (Exon Based Strategy for Expression Analysis) is an R package designed to identify differentially expressed genes by first performing statistical testing at the individual exon level. Unlike standard methods that aggregate counts to the gene level before testing, EBSEA uses DESeq2 for exon-level normalization and testing, then aggregates these results using an empirical Brown’s method. This approach accounts for the dependence between exons within a gene, preventing p-value inflation and increasing sensitivity.

## Workflow and Usage

### 1. Data Preparation
Input data must be a data frame of raw exon-level counts. 
- **Row Names**: Must follow the format `GeneName:ExonNumber` (e.g., `ENSG000001:001`).
- **Columns**: Represent individual samples.

```r
library(EBSEA)
data("exonCounts") # Example dataset
head(exonCounts)
```

### 2. Data Filtering
Filter out lowly expressed exons to improve statistical power. The `filterCounts` function removes exons with an average count below a threshold (default = 1) and ensures genes retain a minimum number of exons.

```r
# Filter exons with average count < 1
filtCounts <- filterCounts(exonCounts, min.count = 1, min.exon = 1)
```

### 3. Differential Expression Analysis
Define the experimental design using a data frame for groups and a design formula. EBSEA supports both simple and paired designs.

**Standard Design:**
```r
group <- data.frame(group = as.factor(c('G1', 'G1', 'G1', 'G2', 'G2', 'G2', 'G2')))
row.names(group) <- colnames(filtCounts)
design <- ~group

ebsea.out <- EBSEA(filtCounts, group, design)
```

**Paired Design:**
```r
group <- data.frame(
  group = as.factor(c('G1', 'G1', 'G2', 'G2')), 
  paired = as.factor(c(1, 2, 1, 2))
)
design <- ~paired + group
ebsea.out <- EBSEA(filtCounts, group, design)
```

### 4. Interpreting Results
The output of `EBSEA()` is a list containing:
- `ExonTable`: Statistics for each exon (baseMean, log2FoldChange, pvalue, padj, etc.).
- `GeneTable`: Aggregated gene-level statistics (P_test and padj).
- `NormCounts`: Normalized exon-level counts.

```r
# View top differentially expressed genes
head(ebsea.out$GeneTable)

# View statistics for specific exons
head(ebsea.out$ExonTable)
```

### 5. Visualization
Visualize the expression patterns and fold changes for a specific gene across exons.

```r
# Visualize a specific gene by ID
visualizeGenes('FBgn0000064', ebsea.out)
```
- **Top Panel**: Displays log2 fold-change per exon. Significance is marked with asterisks (* < 0.05, ** < 0.01).
- **Bottom Panel**: Displays average normalized read counts per sample group.

## Tips and Best Practices
- **Input Generation**: Raw exon counts can be generated using `DEXSeq` python scripts or `RSubread` (featureCounts).
- **Normalization**: EBSEA internally uses the RLE (Relative Log Expression) method from DESeq2.
- **P-value Aggregation**: The package uses the Benjamini-Hochberg method for multiple testing correction at both exon and gene levels.

## Reference documentation
- [EBSEA](./references/EBSEA.md)