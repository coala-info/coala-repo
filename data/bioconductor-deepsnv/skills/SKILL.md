---
name: bioconductor-deepsnv
description: This tool detects subclonal single nucleotide variants in deep sequencing data by comparing test samples against controls or cohorts. Use when user asks to detect subclonal mutations, compare test versus control experiments, or call variants in large cohorts using the Shearwater algorithm.
homepage: https://bioconductor.org/packages/release/bioc/html/deepSNV.html
---

# bioconductor-deepsnv

name: bioconductor-deepsnv
description: Expert guidance for the deepSNV R package to detect subclonal single nucleotide variants (SNVs) in deep sequencing data. Use this skill when analyzing polyclonal samples, comparing test vs. control experiments, or calling variants in large cohorts using the Shearwater algorithm.

# bioconductor-deepsnv

## Overview
The `deepSNV` package provides a quantitative framework for calling subclonal mutations by comparing a test sample against a clonal control or a cohort of samples. It utilizes binomial or beta-binomial models to account for sequencing errors and overdispersion. The package includes two primary workflows:
1. **deepSNV**: Best for test-control pairs (e.g., tumor vs. matched normal or clonal control).
2. **Shearwater**: Best for large cohorts of unmatched samples, using a base-specific error profile.

## Core Workflows

### 1. deepSNV (Test-Control Comparison)
This workflow uses a likelihood ratio test to compare nucleotide counts between a test and a control.

```R
library(deepSNV)

# Define regions of interest
regions <- data.frame(chr="chr1", start=1000, stop=2000)

# Load data and run deepSNV (requires BAM files)
# HIVmix <- deepSNV(test="test.bam", control="control.bam", regions=regions, q=10)

# For demonstration, use provided dataset
data(HIVmix)

# Summary of significant SNVs
snvs <- summary(HIVmix, sig.level=0.05, adjust.method="BH")

# Visualization
plot(HIVmix)
```

### 2. Shearwater (Cohort-based Calling)
Shearwater estimates error rates from a cohort of samples. It can output Bayes Factors (`bbb`) or p-values via a Likelihood-Ratio Test (`betabinLRT`).

```R
# 1. Load data from multiple BAM files
files <- c("sample1.bam", "sample2.bam", "sample3.bam")
regions <- GRanges("chr1", IRanges(start=3120, end=3140))
counts <- loadAllData(files, regions, q=30)

# 2. Call variants using Shearwater ML (p-values)
results <- betabinLRT(counts, rho=1e-4)
pvals <- results$pvals
qvals <- p.adjust(pvals, method="BH")

# 3. Convert to VCF
vcf <- qvals2Vcf(qvals, counts, regions, samples=files)
```

## Key Functions and Parameters

### Data Loading
- `deepSNV()`: Main function for test-control analysis. Parameters include `q` (min PHRED score) and `combine.method` ("fisher", "max", or "average" for strand combining).
- `loadAllData()`: Loads multiple BAM files into a count array for Shearwater.

### Statistical Models
- `estimateDispersion()`: Estimates the overdispersion parameter $\alpha$ for the beta-binomial model.
- `normalize()`: Adjusts for systematic biases between different sequencing runs.
- `bbb()`: Computes Bayes Factors for the original Shearwater model. Supports "OR" and "AND" models for strand coordination.
- `betabinLRT()`: Maximum-likelihood adaptation of Shearwater for p-value generation.

### Results and Export
- `summary()`: Tabulates significant variants from a deepSNV object.
- `bf2Vcf()`: Converts Shearwater Bayes Factors to VCF format.
- `qvals2Vcf()`: Converts Shearwater ML q-values to VCF format.

## Tips for Success
- **Strand Bias**: `deepSNV` performs tests on both strands. Use the `combine.method` to control how strand-specific p-values are merged.
- **Overdispersion**: If your data has long repeats or heavy PCR amplification, use `estimateDispersion()` to switch from a Binomial to a Beta-Binomial model to reduce false positives.
- **Normalization**: Always use `normalize()` when comparing samples from different sequencing runs to account for batch effects.
- **Priors**: For Shearwater, you can use `makePrior()` with COSMIC VCF data to increase power at known mutational hotspots.

## Reference documentation
- [Calling subclonal mutations with deepSNV](./references/deepSNV.md)
- [Subclonal variant calling with multiple samples and prior knowledge using shearwater](./references/shearwater.md)
- [Shearwater ML](./references/shearwaterML.md)