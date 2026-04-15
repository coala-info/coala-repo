---
name: bioconductor-charge
description: This tool identifies chromosomal duplications, additions, and deletions from gene expression data using clustering and bimodality tests. Use when user asks to detect large-scale genomic alterations, identify hyperploidy or hypoploidy in RNA-seq data, or scan for unknown aneuploid regions.
homepage: https://bioconductor.org/packages/3.8/bioc/html/CHARGE.html
---

# bioconductor-charge

name: bioconductor-charge
description: Identify chromosomal duplications, additions, and deletions (hyperploidy/hypoploidy) from gene expression data using clustering and bimodality tests. Use this skill when analyzing RNA-seq or microarray data to detect large-scale genomic alterations like Trisomy 21 or cancer-related deletions.

## Overview

The `CHARGE` package (CHromosome Assessment in R with Gene Expression data) identifies genomic regions or whole chromosomes that exhibit altered copy numbers based on gene expression patterns. It uses Hartigan’s Dip Test and a Bimodality Coefficient to determine if samples cluster into two distinct groups (e.g., normal vs. trisomy). The workflow typically involves filtering low-variation genes, clustering samples, and statistically testing for bimodality.

## Core Workflow

### 1. Data Preparation
`CHARGE` uses `SummarizedExperiment` objects. Ensure your expression data is normalized (e.g., via edgeR or DESeq2) and contains genomic coordinates.

```R
library(CHARGE)
library(SummarizedExperiment)
library(GenomicRanges)

# Load your SummarizedExperiment object
# data(datExprs) 
```

### 2. Filtering Low Variation Genes
Remove genes that do not vary significantly across samples, as they are uninformative for clustering.

```R
# Define the region of interest (e.g., Chromosome 21)
chr21_len <- seqlengths(EnsDb.Hsapiens.v86)["21"]
region <- GRanges("21", IRanges(end = chr21_len, width = chr21_len))

# Calculate Coefficient of Variation (CV)
cv_out <- cvExpr(se = datExprs, region = region)

# Visualize CV to determine a threshold (e.g., 25% quantile)
plotcvExpr(cvExpr = cv_out)
```

### 3. Clustering and Ploidy Assignment
Assign samples to "Hyperploidy" or "Hypoploidy" groups based on the mean expression of high-variation genes in the target region.

```R
# Perform clustering
datExprs <- clusterExpr(se = datExprs, cvExpr = cv_out, threshold = "25%")

# View assignments in colData
colData(datExprs)$Ploidy

# Visualize separation with PCA
pcaExpr(se = datExprs, cvExpr = cv_out, threshold = "25%")
```

### 4. Statistical Testing for Bimodality
Validate if the observed clustering is statistically significant.

```R
bimodal_out <- bimodalTest(se = datExprs, cvExpr = cv_out, threshold = "25%")

# Statistics: Bimodality.Coefficient (> 0.55 suggests bimodality)
# Dip.pvalue (< 0.05 suggests two distinct groups)
print(bimodal_out[[1]])

# Plot density of Z-scores
plot(bimodal_out[[2]])
```

### 5. Scanning for Unknown Regions
If the specific chromosome or region is unknown, use a sliding window approach.

```R
# Define ranges to scan (e.g., all autosomes)
all_chr <- GRanges(seqinfo(EnsDb.Hsapiens.v86)[1:22])

# Scan with a specific window size (binWidth) and step
found_regions <- exprFinder(se = datExprs, 
                            ranges = all_chr, 
                            binWidth = 1e+7, 
                            binStep = 5e+6, 
                            threshold = "25%")
```

## Interpreting Results

- **Ploidy Label**: "Hyperploidy" indicates higher average expression (potential duplication/addition); "Hypoploidy" indicates lower average expression (potential deletion).
- **Bimodality Coefficient**: Values > 0.555 (5/9) indicate the distribution is likely bimodal.
- **Dip P-value**: A significant p-value (< 0.05) rejects the null hypothesis of unimodality, supporting the presence of two distinct groups.

## Reference documentation

- [CHARGE Vignette](./references/CHARGE_Vignette.md)