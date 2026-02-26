---
name: bioconductor-biomvrcns
description: This tool performs copy number study and segmentation for multivariate biological data using Hidden Semi-Markov Models and other segmentation algorithms. Use when user asks to segment genomic profiles, detect copy number variations, identify transcripts in RNA-seq data, or find differentially methylated regions.
homepage: https://bioconductor.org/packages/release/bioc/html/biomvRCNS.html
---


# bioconductor-biomvrcns

name: bioconductor-biomvrcns
description: Copy number study and segmentation for multivariate biological data using Hidden Semi-Markov Models (HSMM) and other segmentation algorithms. Use this skill when analyzing genomic profiles (aCGH, RNA-seq, Methylation) to detect segments, transcripts, or differentially methylated regions (DMRs).

## Overview

The `biomvRCNS` package provides tools for the segmentation of genomic data, specifically designed to handle multiple profiles or samples simultaneously. It is particularly useful for detecting copy number variations (CNV), transcripts in RNA-seq data, and differentially methylated regions (DMR). The package implements three main algorithms:
1. **HSMM (Hidden Semi-Markov Model)**: The primary model (`biomvRhsmm`) which incorporates positional information via sojourn distributions.
2. **Homogeneous Segmentation**: A maximum likelihood-based model (`biomvRseg`).
3. **Max-gap-min-run**: A heuristic algorithm (`biomvRmgmr`) for quick peak/segment detection.

## Core Workflow

### 1. Data Preparation
Input data should be a `GRanges` object where the metadata columns contain the numeric profiles (e.g., log2 ratios, read counts, or p-values). Data must be sorted by genomic position.

```r
library(biomvRCNS)
library(GenomicRanges)

# Example: Creating a GRanges object from a data frame
# x_df contains columns: chr, start, sample1, sample2
xgr <- GRanges(seqnames = x_df$chr, 
               ranges = IRanges(start = x_df$start, width = 1))
values(xgr) <- x_df[, c("sample1", "sample2")]
xgr <- sort(xgr)
```

### 2. Genomic Segmentation with HSMM
Use `biomvRhsmm` for complex segmentation tasks. It allows for different emission distributions (Normal, Poisson, etc.) and sojourn types (Gamma, etc.).

```r
# J: number of states (e.g., 3 for deletion, neutral, amplification)
# grp: assign columns to experimental groups
rhsmm_res <- biomvRhsmm(x = xgr, 
                        maxbp = 1e5, 
                        J = 3, 
                        soj.type = 'gamma', 
                        emis.type = 'norm', 
                        prior.m = 'quantile', 
                        grp = c(1, 2))

# Access results
segments <- rhsmm_res@res  # GRanges of segmented regions
```

### 3. Transcript Detection (RNA-seq)
For count data, use `emis.type = 'pois'` or `'nbinom'`. You can provide a `TxDb` object to `xAnno` to estimate state numbers and sojourn parameters automatically.

```r
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

# Detecting transcripts (states: intergenic, intron, exon)
rna_res <- biomvRhsmm(x = count_gr, 
                      xAnno = txdb, 
                      maxbp = 1e3, 
                      soj.type = 'gamma', 
                      emis.type = 'pois', 
                      prior.m = 'quantile', 
                      q.alpha = 0.01)
```

### 4. DMR Detection (Methylation)
For methylation data, you can model the difference in ratios and p-values simultaneously using a multivariate normal distribution.

```r
# Multivariate HSMM for methylation difference and p-values
dmr_res <- biomvRhsmm(x = meth_gr, 
                      J = 6, 
                      maxbp = 100, 
                      emis.type = 'mvnorm', 
                      prior.m = 'cluster', 
                      maxgap = 100, 
                      com.emis = TRUE)
```

### 5. Alternative Segmentation Methods
- **biomvRseg**: Likelihood-based. Good for finding a specific number of segments (`maxseg`).
- **biomvRmgmr**: Fast, heuristic "max-gap-min-run". Requires manual tuning of quantiles (`q`).

## Visualization
The package integrates with `Gviz` for plotting results.

```r
# Plotting a specific chromosome/sample
biomvRGviz(exprgr = xgr[seqnames(xgr) == '1'], 
           seggr = rhsmm_res@res, 
           tofile = FALSE)
```

## Tips and Best Practices
- **Normalization**: `biomvRCNS` does not perform data normalization. Ensure input data is pre-processed (e.g., GC-content corrected, normalized for library size).
- **Grouping**: Use the `grp` argument to treat replicates together. This improves the estimation of emission parameters.
- **State Interpretation**: In the output `GRanges`, the `STATE` column is numeric. Lower numbers generally correspond to lower mean values (e.g., State 1 = Deletion/Low expression).
- **Memory**: For base-pair resolution data, use `Rle` objects within the `GRanges` metadata to save memory.

## Reference documentation
- [biomvRCNS](./references/biomvRCNS.md)