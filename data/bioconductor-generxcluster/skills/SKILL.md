---
name: bioconductor-generxcluster
description: This tool performs statistical analysis of genomic insertion sites to detect localized clusters and compare integration patterns between two sources. Use when user asks to identify spatial differences in clustering, calculate False Discovery Rates for genomic clumps, or perform scan statistics on integration site data.
homepage: https://bioconductor.org/packages/release/bioc/html/geneRxCluster.html
---


# bioconductor-generxcluster

name: bioconductor-generxcluster
description: Statistical analysis of genomic insertion sites to detect localized clusters and compare integration patterns between two different sources (e.g., gene therapy vectors). Use this skill when you need to identify spatial differences in clustering, calculate False Discovery Rates (FDR) for genomic clumps, or perform scan statistics on integration site data.

## Overview

The `geneRxCluster` package implements scan statistics to compare genomic insertion sites from two different sources. It is primarily used in gene therapy research to determine if one vector targets "sensitive" genomic regions more frequently than another. The package identifies "clumps" (localized clusters) of insertions and provides statistical methods to estimate the False Discovery Rate (FDR) using permutations.

## Core Workflow

### 1. Data Preparation
The package requires three main pieces of information, typically organized in a data frame:
- **Chromosome**: The genomic sequence name (e.g., "chr1").
- **Position**: The integer coordinate of the insertion site (must be sorted within chromosomes).
- **Group**: A logical or factor vector indicating the source/vector for each site.

```r
# Example data structure
# df <- data.frame(chromo = c("chr1", "chr1"), pos = c(100, 200), grp = c(TRUE, FALSE))
# Ensure data is sorted
df <- df[order(df$chromo, df$pos), ]
```

### 2. Running the Cluster Analysis
The `gRxCluster` function is the primary tool. It scans the genome using multiple window widths (k-values).

```r
library(geneRxCluster)

# kvals: a range of window sizes (number of sites) to test
# nperm: number of permutations for FDR calculation
results <- gRxCluster(df$chromo, df$pos, df$grp, kvals = 15L:30L, nperm = 100L)
```

### 3. Summarizing and Interpreting Results
The output is a `GRanges` object containing the discovered clumps. Use `gRxSummary` to get a high-level statistical overview.

```r
# Get FDR and cluster counts
summary_stats <- gRxSummary(results)
print(summary_stats$FDR)
print(summary_stats$Clusters_Discovered)

# View the clumps as a data frame
clumps_df <- as.data.frame(results)
```

### 4. Visualization
You can visualize the critical regions and the distribution of clusters.

```r
# Plot critical regions used for the scan statistic
gRxPlot(results, method = "criticalRegions")
```

## Customizing Filters and Critical Values

The scan statistic can be fine-tuned by adjusting how "clumps" are defined:

- **Target False Discoveries**: By default, the package targets 5 false discoveries. You can change this by passing a custom expression to `cutpt.tail.expr`.
- **Filtering**: The package filters windows based on base-pair width (default is the median width). You can disable or tighten this filter using `cutpt.filter.expr`.

```r
# Example: Increasing the target number of false discoveries to 20
generous_target <- quote(critVal.target(k, n, target = 20, posdiff = x))
results_high_sens <- gRxCluster(df$chromo, df$pos, df$grp, 15L:30L, 
                                 cutpt.tail.expr = generous_target)

# Example: Disabling the width filter
no_filter <- quote(rep(Inf, ncol(x)))
results_no_filt <- gRxCluster(df$chromo, df$pos, df$grp, 15L:30L, 
                               cutpt.filter.expr = no_filter)
```

## Integration with GenomicRanges
Since the output is a `GRanges` object, you can use standard Bioconductor tools to annotate or compare results:
- `findOverlaps()`: Compare discovered clumps with known genomic features (e.g., TSS, oncogenes).
- `subsetByOverlaps()`: Filter clumps based on genomic context.

## Reference documentation
- [Using geneRxCluster](./references/tutorial.md)