---
name: bioconductor-seqarchrplus
description: This R package discovers de novo sequence architectures and motif clusters in genomic sequences using non-negative matrix factorization. Use when user asks to discover de novo sequence architectures, perform promoter analysis, identify transcription factor binding site patterns, or cluster sequences based on shared motif compositions using NMF.
homepage: https://bioconductor.org/packages/release/bioc/html/seqArchRplus.html
---


# bioconductor-seqarchrplus

name: bioconductor-seqarchrplus
description: Expert guidance for using the seqArchRplus R package to discover de novo sequence architectures (clusters of motifs) in genomic sequences. Use this skill when performing promoter analysis, identifying transcription factor binding site patterns, or clustering sequences based on shared motif compositions using non-negative matrix factorization (NMF).

# bioconductor-seqarchrplus

## Overview
`seqArchRplus` is an R package designed for the unsupervised discovery of sequence architectures in genomic regions, such as promoters or enhancers. It extends the `seqArchR` framework by providing a streamlined workflow to identify clusters of sequences that share similar arrangements and combinations of motifs. It uses Non-negative Matrix Factorization (NMF) to decompose sequence data into basis vectors (architectures) and coefficients (sequence assignments), allowing for the identification of both known and novel regulatory patterns.

## Installation
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("seqArchRplus")
library(seqArchRplus)
```

## Core Workflow

### 1. Data Preparation
The package typically operates on DNA sequences (DNAStringSet).
```r
library(Biostrings)
# Load sequences from a FASTA file
seqs <- readDNAStringSet("promoters.fa")

# Or use genomic coordinates with a BSgenome object
library(BSgenome.Hsapiens.UCSC.hg38)
# seqs <- getSeq(Hsapiens, granges_object)
```

### 2. Running the Main Analysis
The primary entry point is the `seqArchRplus()` function (or the core `seqArchR()` function it wraps). It performs iterative NMF to find the optimal number of clusters.

```r
# Basic execution
result <- seqArchRplus(
    seqs = seqs,
    k_range = 2:10,        # Range of clusters to test
    n_runs = 5,            # Number of NMF runs per k
    top_n = 50             # Number of top sequences to consider for visualization
)
```

### 3. Architecture Discovery and Visualization
After running the analysis, you can extract and visualize the discovered architectures.

```r
# Get cluster assignments for each sequence
clusters <- get_clusters(result)

# Visualize the sequence architectures (motifs)
plot_architectures(result)

# Plot the distribution of sequences across clusters
plot_cluster_stats(result)
```

## Key Functions
- `seqArchRplus()`: Wrapper function for the complete discovery pipeline.
- `prepare_data()`: Handles k-mer counting and matrix preparation from sequences.
- `run_nmf()`: Performs the core matrix factorization.
- `get_cl_sequences()`: Retrieves sequences belonging to a specific cluster.
- `viz_pwm()`: Visualizes Position Weight Matrices associated with discovered architectures.

## Best Practices and Tips
- **K-mer Size**: The default k-mer size (usually 1 to 4) significantly impacts sensitivity. Smaller k-mers capture general composition; larger k-mers capture specific motifs but increase the feature space exponentially.
- **Sequence Length**: Ensure sequences are centered (e.g., around a Transcription Start Site) and of equal length for the most interpretable architecture alignments.
- **Parallelization**: NMF is computationally intensive. Use `BiocParallel` if the package configuration allows to speed up multiple runs.
- **Interpretation**: Look for "stable" clusters that appear across different values of `k`. If a cluster only appears at a specific `k` and disappears, it may be an artifact.

## Reference documentation
- [seqArchRplus Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/seqArchRplus.html)
- [seqArchRplus GitHub Repository](https://github.com/snikumbh/seqArchRplus)