---
name: bioconductor-sigspack
description: SigsPack is an R package for analyzing mutational signatures by transforming VCF files into mutational catalogues and estimating signature exposures. Use when user asks to convert VCF files to mutational profiles, normalize catalogues for different sequencing targets, estimate signature exposures using quadratic programming, or perform bootstrapping to assess estimate reliability.
homepage: https://bioconductor.org/packages/release/bioc/html/SigsPack.html
---


# bioconductor-sigspack

## Overview

SigsPack is an R package designed for the analysis of mutational signatures. It allows users to transform VCF files into mutational catalogues, estimate signature exposures using quadratic programming, and assess the reliability of these estimates through bootstrapping. A key feature is its ability to normalize mutational catalogues to account for differences in tri-nucleotide frequencies between different sequencing targets (like exome vs. whole genome) and reference signature sets.

## Core Workflows

### 1. Data Preparation
Convert VCF files into a 96-trinucleotide mutational profile.

```r
library(SigsPack)
library(BSgenome.Hsapiens.UCSC.hg19)

# Load VCF and convert to mutational catalogue (96x1 matrix)
sample_cat <- vcf2mut_cat(
  vcf_path = "path/to/sample.vcf.gz",
  genome = BSgenome.Hsapiens.UCSC.hg19
)
```

### 2. Normalization
If your data comes from exome sequencing but you are using whole-genome reference signatures (like COSMIC), you must normalize the frequencies.

```r
# Get context frequencies for genome and exome (using a BED file)
genome_freq <- get_context_freq(BSgenome.Hsapiens.UCSC.hg19)
exome_freq <- get_context_freq(BSgenome.Hsapiens.UCSC.hg19, "exome_regions.bed")

# Normalize the sample
# Note: SigsPack::normalize returns frequencies, not counts
norm_cat <- SigsPack::normalize(sample_cat, exome_freq, genome_freq)
```

### 3. Signature Exposure Estimation
Estimate the weights of signatures in a sample. The package includes `cosmicSigs` as a default reference.

```r
data("cosmicSigs")

# Estimate using a specific subset of signatures (recommended for better fit)
# If using normalized frequencies, multiply by total mutations to get counts
total_muts <- sum(sample_cat)
exposures <- signature_exposure(total_muts * norm_cat, sig_set = c(1, 5, 10, 13))

# View results
print(exposures$exposures)
```

### 4. Bootstrapping and Summarization
Assess the stability of signature estimates by resampling the mutational catalogue.

```r
# Generate 1000 bootstrapped replicates
# 'm' is the number of mutations to sample (usually the original total)
reps <- bootstrap_mut_catalogues(n = 1000, original = norm_cat, m = total_muts)

# Summarize and plot the distribution of exposures
report <- summarize_exposures(reps)
# This returns a table with original exposure, min, max, and quartiles
```

### 5. Synthetic Data Generation
Create synthetic catalogues for testing or benchmarking.

```r
# Create 5 catalogues with 1000 mutations each using signatures 1 and 5
synthetic <- create_mut_catalogues(
  n = 5, 
  m = 1000, 
  P = cosmicSigs, 
  sig_set = c(1, 5)
)
```

## Tips and Best Practices

- **Normalization is Critical**: Always ensure the tri-nucleotide "space" of your sample matches the signature matrix. COSMIC signatures are typically genome-relative.
- **Signature Selection**: Using the entire COSMIC matrix (30+ signatures) can lead to overfitting. If prior biological knowledge exists, use the `sig_set` parameter to restrict the analysis to relevant signatures.
- **Input Format**: Most functions expect a 96-row matrix where rows represent the standard 96 tri-nucleotide contexts (A[C>A]A, etc.).
- **Scaling**: Since `normalize()` returns frequencies, remember to scale by the original mutation count (`sum(sample)`) before passing to `signature_exposure()` or `bootstrap_mut_catalogues()` if count-based statistics are required.

## Reference documentation

- [Introduction to SigsPack](./references/SigsPack.md)
- [SigsPack Vignette Source](./references/SigsPack.Rmd)