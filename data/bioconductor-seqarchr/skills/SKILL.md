---
name: bioconductor-seqarchr
description: seqArchR performs unsupervised discovery of de novo sequence architectures and motifs in DNA sequences using Non-negative Matrix Factorization. Use when user asks to cluster DNA sequences, identify motifs and their positional specificities simultaneously, or visualize sequence architectures from FASTA or DNAStringSet objects.
homepage: https://bioconductor.org/packages/release/bioc/html/seqArchR.html
---


# bioconductor-seqarchr

name: bioconductor-seqarchr
description: Expert assistant for the seqArchR R package, used for unsupervised discovery of de novo sequence architectures (motifs and their positional specificities) in DNA sequences using Non-negative Matrix Factorization (NMF). Use this skill when users need to cluster DNA sequences (e.g., promoters), identify motifs and their positions simultaneously, or visualize sequence architectures from FASTA or DNAStringSet objects.

# bioconductor-seqarchr

## Overview
`seqArchR` is an R/Bioconductor package that employs a chunking-based iterative Non-negative Matrix Factorization (NMF) approach to identify core promoter sequence architectures. Unlike traditional motif discovery, it simultaneously infers motif length, positional specificity, and complex inter-relationships between multiple motifs. It is designed to scale to large datasets that typically challenge standard NMF implementations.

## Installation and Dependencies
The package requires the Python module `scikit-learn`.
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("seqArchR")
```

## Core Workflow

### 1. Data Preparation
`seqArchR` works with one-hot encoded DNA sequences. You can prepare data from a FASTA file or a `DNAStringSet`.

```r
library(seqArchR)
library(Biostrings)

# From FASTA (returns sparse matrix)
inputFname <- "path/to/sequences.fa"
inputSeqsMat <- prepare_data_from_FASTA(fasta_fname = inputFname, sinuc_or_dinuc = "dinuc")

# Get raw sequences for visualization later
inputSeqsRaw <- prepare_data_from_FASTA(fasta_fname = inputFname, raw_seq = TRUE)

# From DNAStringSet
# inputSeqsMat <- get_one_hot_encoded_seqs(seqs = myDNAStringSet, sinuc_or_dinuc = "dinuc")
```

### 2. Configuration
Set the hyperparameters for the NMF iterations. Key parameters include `k_min`/`k_max` (range of clusters) and `mod_sel_type`.

```r
seqArchRconfig <- set_config(
    parallelize = TRUE,
    n_cores = 2,
    n_runs = 100,
    k_min = 1,
    k_max = 20,
    mod_sel_type = "stability", # Use stability-based model selection
    chunk_size = 100,
    result_aggl = "ward.D", 
    result_dist = "euclid"
)
```

### 3. Running seqArchR
Execute the iterative clustering. `total_itr` defines how many iterations of refinement to perform.

```r
seqArchRresult <- seqArchR(
    config = seqArchRconfig,
    seqs_ohe_mat = inputSeqsMat,
    seqs_raw = inputSeqsRaw,
    seqs_pos = seq(1, width(inputSeqsRaw[1])),
    total_itr = 2,
    set_ocollation = c(TRUE, FALSE)
)
```

## Interpreting and Visualizing Results

### Extracting Basis Vectors (Motifs)
Basis vectors represent the learned sequence features (motifs).
```r
# Get basis vectors for a specific iteration
b_vectors <- get_clBasVec_m(seqArchRresult, iter = 2)

# Visualize as heatmap and sequence logo
viz_bas_vec(feat_mat = b_vectors, 
            ptype = c("heatmap", "seqlogo"), 
            method = "bits", 
            sinuc_or_dinuc = "dinuc")
```

### Visualizing Clustered Sequences
To see how sequences are grouped by their architectures:
```r
# Visualize raw sequences as an ACGT color matrix
# Use seqs_str to fetch sequences ordered by clusters
viz_seqs_acgt_mat(seqs_str(seqArchRresult, iter = 2, ord = TRUE))
```

## Tips for Success
- **Dinucleotide vs Mononucleotide**: Use `sinuc_or_dinuc = "dinuc"` for better capture of structural features, though it increases the feature space.
- **Reproducibility**: Always `set.seed()` before running as NMF is a stochastic process.
- **Iterations**: Usually 2-3 iterations are sufficient to stabilize clusters.
- **Memory**: For very large datasets, adjust `chunk_size` in `set_config` to manage memory usage during the NMF phase.

## Reference documentation
- [Example usage of seqArchR on simulated DNA sequences](./references/seqArchR.Rmd)