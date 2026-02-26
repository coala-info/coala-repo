---
name: bioconductor-gqtlstats
description: This package provides infrastructure for the scalable analysis and FDR estimation of large-scale association studies like eQTL or mQTL. Use when user asks to compute permutation-based FDR, model association-FDR relationships, enumerate significant SNP-probe pairs, or generate annotated Manhattan plots from distributed association statistics.
homepage: https://bioconductor.org/packages/3.8/bioc/html/gQTLstats.html
---


# bioconductor-gqtlstats

## Overview

The `gQTLstats` package provides infrastructure for the scalable analysis of large-scale association studies (like eQTL or mQTL). It operates on `ciseStore` objects (from `geuvStore2`) which manage distributed association statistics. Key capabilities include memory-efficient quantile estimation, permutation-based FDR calculation, and smooth modeling of the association-FDR relationship to support variant selection and functional annotation.

## Core Workflow

### 1. Data Initialization
Load the necessary libraries and register parallel backends for efficient processing of large stores.

```r
library(gQTLstats)
library(geuvStore2)
library(doParallel)

# Register parallel backend
registerDoParallel(cores = parallel::detectCores())

# Load a store (example using geuvStore2)
prst = makeGeuvStore2()
```

### 2. FDR Estimation and Filtering
FDR is computed post-hoc. You can apply filtering functions (e.g., based on MAF or distance) during the FDR estimation process.

```r
# Define a filter: MAF >= 5% and distance <= 500kb
dmfilt = function(x) x[which(x$MAF >= 0.05 & x$mindist <= 500000)]

# Compute FDR with filtering
filtFDR = storeToFDR(prst, 
                     xprobs = c(seq(.05, .95, .05), .99, .999), 
                     filter = dmfilt)

# View FDR table
getTab(filtFDR)
```

### 3. Modeling the Association-FDR Relationship
To avoid "wiggliness" in empirical FDR traces, fit a smooth model (GAM) to the association scores.

```r
# Bind an interpolating model to the FDR estimates
filtFDR = setFDRfunc(filtFDR)

# Visualize the relationship
txsPlot(filtFDR)     # Transformed score plot
directPlot(filtFDR)  # Direct association vs FDR plot
```

### 4. Enumerating Significant eQTLs
Extract specific SNP-probe pairs that meet a defined FDR threshold.

```r
# List pairs with FDR < 0.05
significant_pairs = enumerateByFDR(prst, filtFDR, threshold = 0.05, filter = dmfilt)

# Result is a GRanges object with metadata (chisq, MAF, probeid, etc.)
head(significant_pairs)
```

### 5. Visualization and Annotation
Create Manhattan plots for specific genes, incorporating functional annotations (like ChromHMM states).

```r
# Load annotation data (e.g., hmm878 provided in package)
data(hmm878)

# Generate annotated Manhattan plot for a specific probe
manhWngr(store = prst, 
         probeid = "ENSG00000183814.10", 
         sym = "LIN9",
         fdrsupp = filtFDR, 
         namedGR = hmm878)
```

## Trans-eQTL Identification
For trans-associations, use `AllAssoc` with a `variantRange` argument to test specific genomic regions against the transcriptome.

```r
# Define a genomic range for variants
mysr = GRanges("20", IRanges(33.099e6, 33.52e6))

# Run association test
results = AllAssoc(summex = geuFPKM_subset, vcf.tf = tabix_file, variantRange = mysr)

# Use gQTLstats:::collapseToBuf to manage and reduce trans-results
```

## Tips for Efficiency
- **Quantile Estimation**: Use `storeToQuantiles` for memory-efficient summaries of association distributions; it uses `ff` representations to handle large vectors.
- **Parallelization**: Most `storeTo*` functions respect the registered `foreach` backend.
- **Sensitivity Analysis**: Use `senstab()` to evaluate how different MAF and distance filters impact the yield of significant eQTLs.

## Reference documentation
- [gQTLstats: computationally efficient analysis and interpretation of large eQTL, mQTL, etc. archives](./references/gQTLstats.md)