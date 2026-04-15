---
name: bioconductor-signer
description: This tool performs mutational signature discovery and exposure analysis in cancer genomics using Bayesian Non-negative Matrix Factorization. Use when user asks to discover de novo mutational signatures, estimate signature exposures, process VCF or MAF files into mutation count matrices, or correlate signatures with clinical data.
homepage: https://bioconductor.org/packages/release/bioc/html/signeR.html
---

# bioconductor-signer

name: bioconductor-signer
description: Expert guidance for the Bioconductor package signeR. Use this skill to perform mutational signature discovery and exposure analysis in cancer genomics. It supports processing VCF/MAF files into mutation count matrices, estimating the optimal number of signatures using Bayesian NMF, fitting known signatures (e.g., COSMIC), and conducting downstream clinical correlation analysis including survival analysis, differential exposure, and clustering.

# bioconductor-signer

## Overview

The `signeR` package provides a full Bayesian treatment for Non-negative Matrix Factorization (NMF) to discover mutational signatures and estimate their activities (exposures) in genomic samples. It accounts for mutational opportunities (genomic context) and provides robust statistical tools to correlate signatures with clinical data.

## Installation

Install the package via BiocManager:

```r
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("signeR")
library(signeR)
```

## Data Preparation

`signeR` requires a mutation count matrix (samples x 96 features). It is highly recommended to provide an opportunity matrix to normalize for genomic context.

### From VCF or MAF
Use a `BSgenome` object matching your variant calls.

```r
library(VariantAnnotation)
library(BSgenome.Hsapiens.UCSC.hg19)

# From VCF
vcfobj <- readVcf("path/to/file.vcf", "hg19")
mut <- genCountMatrixFromVcf(BSgenome.Hsapiens.UCSC.hg19, vcfobj)

# From MAF
mut <- genCountMatrixFromMAF(BSgenome.Hsapiens.UCSC.hg19, "file.maf")

# Generate Opportunity Matrix from BED
library(rtracklayer)
target_regions <- import("target.bed", format="bed")
opp <- genOpportunityFromGenome(BSgenome.Hsapiens.UCSC.hg19, target_regions, nsamples=nrow(mut))
```

## Signature Estimation

### De Novo Discovery
The `signeR()` function can automatically estimate the optimal number of signatures by maximizing the median Bayesian Information Criterion (BIC).

```r
# Automatic rank detection (1 to min(G,K)-1)
signatures <- signeR(M=mut, Opport=opp)

# Specific range
signatures <- signeR(M=mut, Opport=opp, nlim=c(3,10))

# Fixed number of signatures
signatures <- signeR(M=mut, Opport=opp, nsig=5)

# Check BIC to validate rank selection
BICboxplot(signatures)
```

### Fitting Known Signatures
To estimate exposures for a fixed set of signatures (e.g., COSMIC):

```r
# Pmatrix should have signatures in columns, 96 features in rows
exposures <- signeR(M=mut, Opport=opp, P=Pmatrix, fixedP=TRUE)

# Extract median exposures
med_exp <- Median_exp(exposures$SignExposures)
```

## Visualization

Visualize the results using built-in plotting functions:

*   **Signatures:** `SignPlot(signatures$SignExposures)` (barplot) or `SignHeat(signatures$SignExposures)` (heatmap).
*   **Exposures:** `ExposureBarplot(signatures$SignExposures)` or `ExposureBoxplot(signatures$SignExposures)`.
*   **Convergence:** `Paths(signatures$SignExposures)` to check MCMC sampler convergence.

## Downstream Analysis

### Supervised Analysis
Correlate signature exposures with clinical or categorical data.

```r
# Differential Exposure (Categorical labels)
diff_exp <- DiffExp(signatures$SignExposures, labels=group_labels)

# Correlation (Continuous feature)
corr_res <- ExposureCorrelation(signatures$SignExposures, feature=continuous_var)

# Survival Analysis
# surv is a matrix with 'time' and 'status' columns
surv_res <- ExposureSurvival(Exposures=signatures$SignExposures, surv=surv_matrix, method="logrank")

# Sample Classification (Predict labels for NA samples)
class_res <- ExposureClassify(signatures$SignExposures, labels=labels_with_nas, method="knn")
```

### Unsupervised Analysis
Cluster samples based on their exposure profiles.

```r
# Hierarchical Clustering
hclust_res <- HClustExp(signatures$SignExposures, method.dist="euclidean", method.hclust="average")

# Fuzzy Clustering
fuzzy_res <- FuzzyClustExp(signatures$SignExposures, Clim=c(2,5))
```

## Interactive Analysis (signeRFlow)

Launch the Shiny application for a GUI-based workflow:

```r
signeRFlow()
```

## Reference documentation

- [signeR Vignette](./references/signeR-vignette.md)
- [signeRFlow RMarkdown](./references/signeRFlow.Rmd)
- [signeRFlow Documentation](./references/signeRFlow.md)