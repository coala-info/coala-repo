---
name: bioconductor-motiftestr
description: This tool analyzes transcription factor binding motifs in genomic sequences to identify positional bias and statistical enrichment. Use when user asks to find motif occurrences, test for motif centrality relative to peak centers, perform motif enrichment analysis against background sequences, or cluster redundant motifs.
homepage: https://bioconductor.org/packages/release/bioc/html/motifTestR.html
---


# bioconductor-motiftestr

name: bioconductor-motiftestr
description: Analysis of transcription factor binding motifs (TFBMs) using Position Weight Matrices (PWMs) in R. Use this skill to identify motifs with positional bias (centrality or specific distance from peak centers) and to test for motif enrichment against background sequences. Supports clustering of similar motifs to reduce redundancy.

# bioconductor-motiftestr

## Overview

The `motifTestR` package provides tools for analyzing transcription factor binding motifs within genomic sequences (typically from ChIP-Seq or ATAC-Seq). It offers two primary statistical approaches:
1.  **Positional Bias Testing**: Identifying if a motif is non-randomly distributed relative to the center of a set of sequences (e.g., centered at peaks).
2.  **Enrichment Testing**: Determining if a motif occurs more frequently in a test set than in a matched background set.

The package integrates with the Bioconductor ecosystem, utilizing `GRanges`, `XStringSet`, and `universalmotif` objects.

## Core Workflow

### 1. Data Preparation
Prepare your test sequences and motifs. Motifs are typically provided as a list of Position Frequency Matrices (PFMs).

```r
library(motifTestR)
library(BSgenome.Hsapiens.UCSC.hg19)

# 1. Define peaks as GRanges
# 2. Extract sequences
test_seq <- getSeq(BSgenome.Hsapiens.UCSC.hg19, ar_er_peaks)
names(test_seq) <- as.character(ar_er_peaks)

# 3. Load motifs (PFMs)
data("ex_pfm") 
```

### 2. Searching for Matches
Use `getPwmMatches` to find occurrences of motifs.

```r
# Find best matches per sequence
bm_all <- getPwmMatches(
  ex_pfm, 
  test_seq, 
  min_score = "70%", 
  best_only = TRUE, 
  break_ties = "all"
)

# Count matches across all sequences
counts <- countPwmMatches(ex_pfm, test_seq, min_score = "70%")
```

### 3. Testing Positional Bias
`testMotifPos` bins distances from the sequence center and uses a binomial test to detect deviations from a uniform distribution.

```r
# Test for bias (symmetrical around center)
res_pos <- testMotifPos(bm_all)

# Test for absolute distance from center (0 to edge)
res_abs <- testMotifPos(bm_all, abs = TRUE)

# Visualize results
plotMatchPos(bm_all[top_motifs], binwidth = 10)
```

### 4. Testing Motif Enrichment
Requires a set of background (control) sequences. `motifTestR` provides `makeRMRanges` to create Randomly-selected, size-Matched ranges.

```r
# Create background ranges matched by genomic feature (e.g., enhancers)
rm_ranges <- makeRMRanges(
  test_ranges_split_by_feature,
  bg_ranges_list, 
  exclude = hg19_mask,
  n_iter = 100
)
rm_seq <- getSeq(BSgenome.Hsapiens.UCSC.hg19, rm_ranges)
mcols(rm_seq) <- mcols(rm_ranges)

# Test enrichment using different models: "quasi" (recommended), "poisson", or "iteration"
enrich_res <- testMotifEnrich(
  ex_pfm, 
  test_seq, 
  rm_seq, 
  model = "quasi"
)
```

### 5. Handling Redundant Motifs (Clustering)
Group similar motifs into clusters to simplify results and reduce multiple testing burdens.

```r
# Cluster motifs based on similarity
cl <- clusterMotifs(ex_pfm, plot = TRUE)
ex_cl <- split(ex_pfm, cl)

# Test clusters for bias or enrichment
cl_matches <- getClusterMatches(ex_cl, test_seq, min_score = "70%")
res_cl_pos <- testClusterPos(cl_matches, test_seq)
```

## Tips and Best Practices
- **Sequence Width**: Ensure all test sequences have the same width (e.g., using `resize(peaks, width = 400, fix = 'center')`) for accurate positional analysis.
- **Parallelization**: Most functions support `mc.cores` for multi-threaded execution.
- **Model Selection**: 
    - Use `quasi` for a balance of speed and reliability (handles over-dispersion).
    - Use `iteration` for the most robust results if you have >1000 iterations.
    - Use `poisson` for quick exploratory checks.
- **Tie Breaking**: When `best_only = TRUE`, use `break_ties = "central"` if you specifically expect motifs to be near the peak center.

## Reference documentation
- [Motif Analysis Using motifTestR](./references/motifAnalysis.md)