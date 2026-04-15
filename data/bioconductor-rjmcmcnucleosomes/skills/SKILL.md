---
name: bioconductor-rjmcmcnucleosomes
description: This tool performs Bayesian profiling of nucleosome positions from MNase-Seq data using a Reversible Jump Markov Chain Monte Carlo approach. Use when user asks to predict nucleosome locations, segment genomic regions for analysis, or perform automated whole-chromosome nucleosome profiling.
homepage: https://bioconductor.org/packages/release/bioc/html/RJMCMCNucleosomes.html
---

# bioconductor-rjmcmcnucleosomes

name: bioconductor-rjmcmcnucleosomes
description: Bayesian profiling of nucleosome positions from MNase-Seq data using Reversible Jump Markov Chain Monte Carlo (RJMCMC). Use this skill to segment genomic regions, predict nucleosome locations with a t-mixture model, and post-process results to merge closely positioned nucleosomes.

# bioconductor-rjmcmcnucleosomes

## Overview

The `RJMCMCNucleosomes` package implements a fully Bayesian hierarchical model for nucleosome positioning. It uses a t-mixture model where the number of nucleosomes is a random variable estimated via Reversible Jump Markov Chain Monte Carlo (RJMCMC). This approach is particularly effective for identifying both well-positioned and fuzzy nucleosomes from high-throughput short-read data (typically MNase-Seq).

## Core Workflow

### 1. Data Preparation
Input reads must be provided as a `GRanges` object. If you have a data frame of reads, convert it first:

```r
library(RJMCMCNucleosomes)
library(GenomicRanges)

# Example: converting a data frame with chr, start, end, strand
reads_gr <- GRanges(seqnames = df$chr, 
                    ranges = IRanges(start = df$start, end = df$end), 
                    strand = df$strand)
```

### 2. Region Segmentation
To improve performance and ensure convergence, large genomic regions should be split into smaller segments. Note: `rjmcmc` functions process one chromosome at a time.

```r
# zeta: nucleosome size (default 147)
# delta: minimum distance between nucleosomes
# maxLength: maximum size of a segment
segments <- segmentation(reads = reads_gr, zeta = 147, delta = 40, maxLength = 1000)
```

### 3. Nucleosome Prediction (Manual/Segmented)
Run the RJMCMC algorithm on individual segments. For real data, high iteration counts (e.g., 1,000,000) are recommended.

```r
result <- rjmcmc(reads = segments[[1]], 
                 nbrIterations = 100000, 
                 lambda = 3, 
                 kMax = 30,
                 minInterval = 100, 
                 maxInterval = 200, 
                 minReads = 5)

# Access predicted positions
print(result$mu)
```

### 4. Automated Whole-Chromosome Analysis
The `rjmcmcCHR` function automates segmentation, prediction, merging, and post-processing for an entire chromosome.

```r
result_chr <- rjmcmcCHR(reads = reads_gr, 
                        seqName = "chr1", 
                        nbrIterations = 100000,
                        nbCores = 2, # Use parallel processing
                        dirOut = "results_dir")
```

### 5. Post-Processing and Merging
If segments were processed individually, merge the results and apply `postTreatment` to correct over-splitting by merging nucleosomes that are too close.

```r
# Merging RDS files from a directory
merged_results <- mergeAllRDSFilesFromDirectory("results_dir")

# Post-treatment (run on the entire region, not segments)
final_positions <- postTreatment(reads = reads_gr,
                                 resultRJMCMC = merged_results,
                                 extendingSize = 15,
                                 chrLength = max(end(reads_gr)))
```

### 6. Visualization
Compare different prediction sets (e.g., before and after post-treatment) against the read coverage.

```r
# Combine results into a GRangesList
plot_list <- GRangesList(Raw = merged_results$mu, 
                         Processed = final_positions)

plotNucleosomes(nucleosomePositions = plot_list, 
                reads = reads_gr,
                names = c("Before Post-Treatment", "After Post-Treatment"))
```

## Key Parameters
- `nbrIterations`: Number of MCMC iterations. Higher values increase accuracy but take longer.
- `lambda`: Prior for the number of nucleosomes.
- `kMax`: Maximum number of nucleosomes allowed in a segment.
- `extendingSize`: Used in `postTreatment`; keep low (under 20) to avoid merging distinct true nucleosomes.

## Reference documentation
- [Nucleosome Positioning](./references/RJMCMCNucleosomes.md)
- [Nucleosome Positioning (Rmd Source)](./references/RJMCMCNucleosomes.Rmd)