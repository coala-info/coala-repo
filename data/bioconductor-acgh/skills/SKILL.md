---
name: bioconductor-acgh
description: This tool analyzes and visualizes array Comparative Genomic Hybridization (aCGH) data to identify copy number alterations. Use when user asks to process log2 ratios, perform HMM-based segmentation, identify genomic events like amplifications or transitions, and test associations between copy number changes and clinical outcomes.
homepage: https://bioconductor.org/packages/release/bioc/html/aCGH.html
---

# bioconductor-acgh

name: bioconductor-acgh
description: Analysis and visualization of array Comparative Genomic Hybridization (aCGH) data. Use this skill to process log2 ratios, perform HMM-based segmentation, identify genomic events (amplifications, transitions), and test associations between copy number alterations and clinical outcomes.

# bioconductor-acgh

## Overview

The `aCGH` package is designed for the analysis of array Comparative Genomic Hybridization data. It provides a specialized `aCGH` class to store log2 ratios alongside genomic mapping information (chromosome, position) and phenotype data. The package is particularly known for its implementation of Unsupervised Hidden Markov Models (HMM) to segment genomic profiles and identify focal aberrations.

## Core Workflow

### 1. Data Import and Object Creation

You can create an `aCGH` object from data frames or read Sproc files directly.

```R
library(aCGH)

# From data frames: log2.ratios, clones.info (name, chrom, kb), and optional pheno.type
ex.acgh <- create.aCGH(log2.ratios, clones.info, pheno.type)

# From Sproc files (UCSF format)
datadir <- system.file("examples", package = "aCGH")
latest.mapping.file <- file.path(datadir, "human.clones.info.Jul03.txt")
ex.acgh <- aCGH.read.Sprocs(dir(path = datadir, pattern = "sproc", full.names = TRUE), 
                            latest.mapping.file, 
                            chrom.remove.threshold = 23)
```

### 2. Preprocessing and Imputation

Clean the data by filtering poor quality clones/samples and imputing missing values using lowess.

```R
# Filtering: remove unmapped, Y chromosome, and clones missing > 25%
ex.acgh <- aCGH.process(ex.acgh, chrom.remove.threshold = 23, prop.missing = .25, 
                        sample.quality.threshold = .4, unmapScreen = TRUE)

# Imputation
log2.ratios.imputed(ex.acgh) <- impute.lowess(ex.acgh, maxChrom = 23)
```

### 3. HMM Segmentation and Event Calling

The HMM fits 2 to 5 states per chromosome and selects the best model via AIC/BIC.

```R
# Find HMM states
hmm(ex.acgh) <- find.hmm.states(ex.acgh)

# Merge states that are too close (e.g., < 0.25 log2 difference)
hmm.merged(ex.acgh) <- mergeHmmStates(ex.acgh, model.use = 1, minDiff = 0.25)

# Compute sample SDs and identify genomic events
sd.samples(ex.acgh) <- computeSD.Samples(ex.acgh)
genomic.events(ex.acgh) <- find.genomic.events(ex.acgh)
```

### 4. Statistical Analysis

Test associations between clones and categorical, continuous, or survival outcomes.

```R
# Categorical (e.g., Sex) using multtest
resT.sex <- mt.maxT(log2.ratios.imputed(ex.acgh), phenotype(ex.acgh)$sex)

# Survival or Linear Regression
stat.coxph <- aCGH.test(ex.acgh, surv.obj, test = "coxph")
stat.age <- aCGH.test(ex.acgh, age, test = "linear.regression")

# Summarize frequencies of gains/losses
summary.table <- summarize.clones(ex.acgh, resT.sex, phenotype(ex.acgh)$sex)
```

### 5. Visualization

The package provides several plotting functions for different levels of granularity.

- `plot(ex.acgh)`: Overall frequency plot of gains and losses across all samples.
- `plotGenome(ex.acgh, samples = 1)`: Log2 ratios for a single sample along the whole genome.
- `plotHmmStates(ex.acgh, sample.ind = 1, chr = 1)`: Detailed view of HMM fits and called events for a specific chromosome.
- `plotFreqStat(ex.acgh, resT.sex, phenotype(ex.acgh)$sex)`: Comparison of gain/loss frequencies between two groups with significance statistics.
- `clusterGenome(ex.acgh)`: Heatmap of clones and samples with dendrograms.

## Tips and Best Practices

- **Chromosome Indices**: Use `23` for X and `24` for Y. Many functions use `maxChrom` or `chrom.remove.threshold` to exclude sex chromosomes from analysis.
- **Subsetting**: When subsetting an `aCGH` object (e.g., `obj[clones, samples]`), use `keep=TRUE` to ensure associated HMM and event slots are preserved where possible.
- **Thresholding**: Use `threshold.func()` to create a discrete matrix of gains (1), losses (-1), and neutrals (0) based on a multiplier of the sample's MAD (Median Absolute Deviation).
- **FGA**: Use `fga.func()` to calculate the Fraction of Genome Altered, a common metric for genomic instability.

## Reference documentation

- [Bioconductor’s aCGH package](./references/aCGH.md)