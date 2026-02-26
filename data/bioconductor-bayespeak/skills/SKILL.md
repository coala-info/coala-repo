---
name: bioconductor-bayespeak
description: BayesPeak performs Bayesian analysis of ChIP-seq data to identify genomic sites of protein-DNA interactions using a Hidden Markov Model and Markov Chain Monte Carlo sampling. Use when user asks to call peaks, identify transcription factor binding sites, detect histone modifications, or estimate the posterior probability of enrichment in sequencing data.
homepage: https://bioconductor.org/packages/3.11/bioc/html/BayesPeak.html
---


# bioconductor-bayespeak

name: bioconductor-bayespeak
description: Bayesian analysis of ChIP-seq data to identify genomic sites of protein-DNA interactions, such as transcription factor binding sites or histone modifications (e.g., H3K4me3). Use this skill to perform peak-calling using a Hidden Markov Model (HMM) and negative binomial distribution, handle overdispersion in read counts, and utilize posterior probabilities for peak certainty.

# bioconductor-bayespeak

## Overview
BayesPeak is a Bayesian methodology for identifying enriched regions in ChIP-seq data. It divides the genome into "jobs," fits a Hidden Markov Model to bins within those jobs, and uses Markov Chain Monte Carlo (MCMC) to estimate the posterior probability (PP) of enrichment. It is particularly effective for transcription factor data and specific histone marks.

## Simple Workflow
The standard workflow involves running the MCMC algorithm and then summarizing the resulting bins into contiguous peaks.

```r
library(BayesPeak)

# 1. Run the BayesPeak algorithm
# Inputs can be .bed files, data.frames, or RangedData objects
raw.output <- bayespeak("treatment.bed", "control.bed")

# 2. Summarize bins into peaks
# "lowerbound" is the recommended method for calculating peak-level PP
output <- summarize.peaks(raw.output, method = "lowerbound")

# 3. Export results
write.csv(as.data.frame(output), file = "peaks.csv")
```

## Core Functions

### bayespeak()
The primary function for peak calling.
- **Input**: Supports `.bed` files (columns: chr, start, end, strand), `data.frame`, or `RangedData`.
- **Jobs**: The genome is processed in partitions (default `job.size = 6E6`) to account for local variation.
- **Offset**: Runs twice by default (offset and non-offset) to ensure peaks straddling bin boundaries are captured.
- **Iterations**: Control MCMC length with `iterations` (default 10,000).

### summarize.peaks()
Consolidates the raw bin calls into peaks.
- **threshold**: The PP threshold for calling a bin enriched (default 0.5).
- **method**: Use `"lowerbound"` (dynamic programming approach) or `"max"` (maximum bin PP).
- **exclude.jobs**: A logical vector used to filter out jobs identified as "overfit" or unenriched.

## Parallelization
BayesPeak is computationally intensive and benefits from parallel processing.

- **Multicore (Linux/Mac)**:
  ```r
  raw.output <- bayespeak(treatment, control, use.multicore = TRUE, mc.cores = 4)
  ```
- **SNOW (Windows/Clusters)**:
  ```r
  library(parallel)
  cl <- makeCluster(4, type = "PSOCK")
  clusterEvalQ(cl, library(BayesPeak))
  raw.output <- bayespeak(treatment, control, snow.cluster = cl)
  ```

## Quality Control and Overfitting
In regions with low read density (e.g., centromeres), the model may "overfit" by trying to find enriched states in background noise.

### Diagnostic Plots
- **plot.PP(raw.output, job = i)**: Visualizes the distribution of PP values. Enriched jobs typically show a "U-shape" (values clustered at 0 and 1). Unenriched/overfit jobs show a uniform distribution.
- **plot.overfitdiag(raw.output)**: Plots job characteristics (e.g., `lambda1` vs `calls`) to identify clusters of overfit jobs.

### Filtering Overfit Jobs
Identify and exclude jobs that exhibit low mean counts in enriched bins (`lambda1`) or an unusually high number of calls.

```r
# Identify jobs where log(lambda1) < 1.5
unreliable <- log(raw.output$QC$lambda1) < 1.5

# Summarize while excluding those jobs
output <- summarize.peaks(raw.output, exclude.jobs = unreliable)
```

## Reference documentation
- [BayesPeak](./references/BayesPeak.md)