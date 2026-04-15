---
name: bioconductor-madseq
description: The bioconductor-madseq package detects and quantifies mosaic aneuploidy by fitting Bayesian models to alternative allele frequencies and normalized sequencing coverage. Use when user asks to detect mosaic chromosomal abnormalities, estimate the fraction of aneuploid cells, or perform model selection for whole-chromosome aneuploidy.
homepage: https://bioconductor.org/packages/release/bioc/html/MADSEQ.html
---

# bioconductor-madseq

## Overview

The `MADSEQ` package provides a robust framework for detecting and quantifying mosaic aneuploidy at the whole-chromosome level. It utilizes two primary data sources: the distribution of Alternative Allele Frequencies (AAF) at heterozygous sites and normalized sequencing coverage. The package fits five competing models (Normal, Monosomy, Mitotic Trisomy, Meiotic Trisomy, and Loss of Heterozygosity) and uses Bayesian Information Criteria (BIC) to determine the best fit and estimate the fraction of aneuploid cells.

## Workflow

### 1. Data Preparation
You require a sorted/indexed BAM file, a bgzipped VCF (containing DP and AD fields), and a BED file of targeted regions (or genomic bins for WGS).

```r
library(MADSEQ)

# Prepare coverage and GC content
# genome can be "hg19" or "hg38"
sample_cov <- prepareCoverageGC(target_bed = "target.bed", 
                                 bam = "sample.bam", 
                                 genome = "hg19")

# Prepare heterozygous sites from VCF
sample_hetero <- prepareHetero(vcf = "sample.vcf.gz", 
                               target_bed = "target.bed",
                               genome = "hg19", 
                               writeToFile = FALSE)
```

### 2. Coverage Normalization
Normalization corrects for GC bias and calculates expected coverage. Providing a normal control sample is recommended for better accuracy.

```r
# Option A: Single sample (GC correction only)
normed_data <- normalizeCoverage(sample_cov, writeToFile = FALSE)

# Option B: With a normal control
normed_data <- normalizeCoverage(sample_cov, control = control_cov, writeToFile = FALSE)

# Extract the specific normalized GRanges
target_normed_cov <- normed_data[[1]]
```

### 3. Model Fitting and Aneuploidy Detection
The `runMadSeq` function performs MCMC sampling. Because this is computationally intensive, it is recommended to run chromosomes in parallel.

```r
# Run models for a specific chromosome (e.g., chr18)
# Default MCMC settings are recommended for production
res <- runMadSeq(hetero = sample_hetero, 
                 coverage = target_normed_cov, 
                 target_chr = "chr18",
                 nChain = 2, nStep = 2000)

# View summary and model selection
print(res)
```

### 4. Interpreting Results
*   **Model Selection**: The model with the lowest BIC is selected.
*   **Delta BIC**: A `deltaBIC > 20` indicates high confidence in the selected model against the next best alternative.
*   **Aneuploidy Fraction**: The parameter `f` in the posterior distribution represents the estimated fraction of mosaic cells.

### 5. Visualization
```r
# Plot posterior distributions of parameters
plotMadSeq(res)

# Plot the estimated fraction of aneuploidy with confidence intervals
plotFraction(res, prob = 0.95)

# Plot the AAF distribution as fitted by the model
plotMixture(res)
```

## Tips for Success
*   **Sex Chromosomes**: When normalizing multiple samples, process males and females separately to avoid bias in sex chromosome coverage.
*   **MCMC Convergence**: For real data, do not reduce `nStep` or `nChain` below defaults unless testing, as mosaicism estimates require stable posterior distributions.
*   **File Output**: Setting `writeToFile = TRUE` in preparation functions is recommended for large datasets to save memory and allow easy re-loading.

## Reference documentation
- [R Package MADSEQ](./references/MADSEQ-vignette.Rmd)