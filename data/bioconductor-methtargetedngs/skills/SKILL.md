---
name: bioconductor-methtargetedngs
description: This tool performs methylation analysis of targeted Next Generation Sequencing data by transforming raw reads into methylation matrices for statistical evaluation. Use when user asks to align bisulfite-sequenced reads to a reference, calculate methylation averages or entropy, identify significant CpG sites using Fisher's exact test, or generate methylation heatmaps and Profile Hidden Markov Models.
homepage: https://bioconductor.org/packages/release/bioc/html/MethTargetedNGS.html
---


# bioconductor-methtargetedngs

name: bioconductor-methtargetedngs
description: Perform methylation analysis of Next Generation Sequencing (NGS) data. Use this skill to align bisulfite-sequenced reads to a reference, calculate methylation averages and entropy, identify significant CpG sites using Fisher's exact test, and generate methylation heatmaps or Profile Hidden Markov Models (HMM).

## Overview

The `MethTargetedNGS` package is designed for the analysis of targeted DNA methylation from NGS data. It provides a pipeline to transform raw sequence reads (FASTA format) into a methylation matrix where rows represent individual reads and columns represent CpG sites. This matrix serves as the foundation for downstream statistical analyses, including differential methylation testing between samples (e.g., Healthy vs. Tumor) and pattern recognition using entropy or HMMs.

## Core Workflow

### 1. Data Loading and Alignment
The first step is to align your sample sequences (Healthy/Tumor) against a reference sequence. The `methAlign` function uses the Smith-Waterman algorithm by default.

```r
library(MethTargetedNGS)

# Define paths to FASTA files
ref_file <- "path/to/reference.fasta"
sample_file <- "path/to/sample.fasta"

# Perform alignment to create a methylation matrix
# Rows = reads, Columns = CpG sites
align_matrix <- methAlign(sample_file, ref_file)
```

### 2. Visualizing Methylation Patterns
Use `methHeatmap` to visualize the methylation status across all reads.

```r
# plot=TRUE generates the heatmap; returns percentage result
heatmap_res <- methHeatmap(align_matrix, plot = TRUE)
```

### 3. Methylation Metrics
Calculate the average methylation per site or the methylation entropy (sliding window of 4 CpG sites).

```r
# Methylation Average (percentage of methylated cytosines per site)
avg_meth <- methAvg(align_matrix, plot = FALSE)

# Methylation Entropy (dissects DNA methylation patterns)
entropy_vals <- methEntropy(align_matrix)
```

### 4. Comparative Analysis (Healthy vs. Tumor)
To identify statistically significant differences between two groups, use Fisher's exact test or Log Odd Ratios.

```r
# Identify significant CpG sites (returns -log10 FDR corrected p-values)
sig_sites <- fishertest_cpg(hAlign, tAlign, plot = FALSE)

# Calculate Log Odd Ratios (identifies hypo/hypermethylation)
lor_results <- odd_ratio(hAlign, tAlign, plot = FALSE)

# Run the complete comparison pipeline (Average, Entropy, Fisher, and Odd Ratio)
compare_samples(hAlign, tAlign)
```

## Profile Hidden Markov Models (HMM)
If the HMMER software is installed on the system, you can build and score models to find similarities between sequences.

```r
# Build a Profile HMM from a Multiple Sequence Alignment (MSA)
if (file.exists("/usr/bin/hmmbuild")) {
  hmmbuild(file_seq = "msa.fasta", file_out = "hmm_model", pathHMMER = "/usr/bin/")
}

# Calculate likelihood scores for a sample against the model
if (file.exists("/usr/bin/nhmmer")) {
  res <- nhmmer("hmm_model", "sample.fasta", pathHMMER = "/usr/bin/")
  print(res$Total.Likelihood.Score)
}
```

## Tips and Best Practices
- **Matrix Structure**: The output of `methAlign` is a binary-like matrix where columns correspond to the CpG sites identified in the reference sequence.
- **Time Complexity**: `methAlign` processing time scales with the number of sequences in the FASTA file.
- **Entropy Window**: `methEntropy` uses a fixed sliding window of 4 CpG sites to calculate pattern variability.
- **External Dependencies**: Functions like `hmmbuild` and `nhmmer` require the HMMER suite to be installed on the underlying OS and the path provided to the function.

## Reference documentation
- [Methylation Analysis of Next Generation Sequencing](./references/MethTargetedNGS.md)