---
name: bioconductor-diffhic
description: This tool detects differential interactions from Hi-C data by counting read pairs into genomic bin pairs and applying edgeR-based statistical frameworks. Use when user asks to process Hi-C data, count read pairs into genomic bins, perform LOESS or CNV-aware normalization, and identify significant changes in interaction intensity between biological conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/diffHic.html
---

# bioconductor-diffhic

name: bioconductor-diffhic
description: Detection of differential interactions from Hi-C data using the diffHic R package. Use this skill when you need to process Hi-C data, count read pairs into genomic bin pairs, perform normalization (LOESS or CNV-aware), and identify significant changes in interaction intensity between biological conditions using edgeR-based statistical frameworks.

# bioconductor-diffhic

## Overview
The `diffHic` package provides a comprehensive pipeline for the differential analysis of Hi-C data. It treats Hi-C data as a collection of read pairs that are counted into pairs of genomic bins (interactions). These counts are then analyzed using the `edgeR` framework to identify significant differences between experimental conditions. The package supports various Hi-C flavors, including in situ Hi-C, DNase Hi-C, and Capture Hi-C.

## Core Workflow

### 1. Data Preparation
Convert BAM files into HDF5 index files. This step matches read pairs to restriction fragments.

```r
library(diffHic)
library(BSgenome.Mmusculus.UCSC.mm10)

# 1. Define restriction fragments
frags <- cutGenome(BSgenome.Mmusculus.UCSC.mm10, "AAGCTT", 4)
param <- pairParam(frags)

# 2. Process BAMs to HDF5
# Note: BAMs should be name-sorted and duplicates marked
preparePairs("sample1.bam", param, file="sample1.h5")

# 3. Prune artifacts (dangling ends, self-circles)
prunePairs("sample1.h5", param, file.out="sample1_pruned.h5", 
           max.frag=600, min.inward=1000, min.outward=25000)
```

### 2. Counting and Filtering
Summarize read pairs into a count matrix of bin pairs.

```r
# Count into 1Mbp bins
input <- c("s1_pruned.h5", "s2_pruned.h5", "s3_pruned.h5", "s4_pruned.h5")
data <- squareCounts(input, param, width=1e6, filter=1)

# Filtering out low-abundance interactions
library(edgeR)
ave.ab <- aveLogCPM(asDGEList(data))
keep <- ave.ab >= aveLogCPM(5, lib.size=mean(data$totals))
data <- data[keep,]

# Optional: Filter by distance or peak-calling
# trended <- filterTrended(data)
# peak.keep <- filterPeaks(data, enrichment)
```

### 3. Normalization
Address technical biases between libraries.

```r
# Non-linear (LOESS) normalization for trended biases
data <- normOffsets(data, type="loess", se.out=TRUE)

# For datasets with Copy Number Variations (CNV)
# marg.data <- marginCounts(input, param, width=1e6)
# cnv.offs <- normalizeCNV(data, marg.data)
```

### 4. Statistical Analysis
Use `edgeR`'s quasi-likelihood (QL) framework to model biological variability.

```r
group <- factor(c("WT", "WT", "KO", "KO"))
design <- model.matrix(~group)
y <- asDGEList(data)

# Estimate dispersion
y <- estimateDisp(y, design)
fit <- glmQLFit(y, design, robust=TRUE)

# Test for differential interactions (DI)
res <- glmQLFTest(fit, coef=2)
```

### 5. Result Summarization
Cluster adjacent significant bin pairs to reduce redundancy.

```r
# Cluster significant interactions within 1 bin (tol=1)
clusters <- diClusters(data, res$table, target=0.05, cluster.args=list(tol=1))
```

## Key Functions
- `pairParam()`: Manages parameters for data extraction (fragments, discard regions, caps).
- `squareCounts()`: Main function for bin-level quantification.
- `connectCounts()`: Quantifies interactions between specific regions of interest (e.g., gene promoters).
- `marginCounts()`: Quantifies one-dimensional coverage for CNV normalization.
- `enrichedPairs()`: Computes neighborhood-based enrichment for peak calling.
- `correctedContact()`: Implements iterative correction (ICE) for genomic biases.

## Tips for Success
- **Bin Size**: Start with large bins (1 Mbp) for broad structural changes and smaller bins (20-50 kbp) for specific loops.
- **DNase Hi-C**: If using DNase Hi-C, pass an empty `GRanges` object to `cutGenome` and use `iter_map.py` for alignment.
- **Diagnostics**: Use `getPairData()` and strand orientation plots to determine appropriate `min.inward` and `min.outward` thresholds for `prunePairs`.
- **Memory**: For high-resolution data, use the `filter` argument in `squareCounts` to avoid loading empty or low-count bin pairs into memory.

## Reference documentation
- [Introducing the diffHic package](./references/diffHic.md)
- [diffHic: Differential analysis of Hi-C data User's Guide](./references/diffHicUsersGuide.md)