---
name: bioconductor-betahmm
description: This tool models DNA methylation beta values using Hidden Markov Models to identify differentially methylated CpG sites and regions. Use when user asks to identify differentially methylated CpG sites, identify differentially methylated regions, or model spatial dependencies in methylation array data.
homepage: https://bioconductor.org/packages/release/bioc/html/betaHMM.html
---


# bioconductor-betahmm

name: bioconductor-betahmm
description: Analysis of DNA methylation data using Hidden Markov Models (HMM) to identify differentially methylated CpG sites (DMCs) and regions (DMRs). Use this skill when analyzing beta values from methylation arrays (like EPIC) to account for spatial correlation and identify biological differences between treatment conditions.

# bioconductor-betahmm

## Overview

The `betaHMM` package provides a framework for modeling DNA methylation beta values using a homogeneous Hidden Markov Model. Unlike methods that logit-transform data into M-values, `betaHMM` directly models the beta distribution while accounting for spatial dependencies between CpG sites. It is specifically designed to identify Differentially Methylated CpG sites (DMCs) and Differentially Methylated Regions (DMRs) across multiple treatment conditions and patients.

## Installation

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("betaHMM")
```

## Core Workflow

### 1. Data Preparation
The package requires a methylation dataframe (beta values) and an annotation dataframe (mapping probes to genomic locations).

```R
library(betaHMM)
data(pca_methylation_data) # Example methylation data
data(annotation_data)      # Example annotation data
```

### 2. Model Parameter Estimation
Use the `betaHMM` function to estimate model parameters via the Baum-Welch algorithm and hidden states via the Viterbi algorithm. This is typically done per chromosome.

```R
# M: Number of methylation states (usually 3: hypo, hemi, hyper)
# N: Number of patients
# R: Number of treatment conditions
betaHMM_out <- betaHMM(pca_methylation_data,
                       annotation_data,
                       M = 3, N = 4, R = 2,
                       parallel_process = FALSE,
                       treatment_group = c("Benign", "Tumour"))

# Inspect results
summary(betaHMM_out)
A(betaHMM_out)    # Transition matrix
phi(betaHMM_out)  # Shape parameters
```

### 3. Identifying DMCs
Identify specific sites that differ significantly between conditions based on Area Under the Curve (AUC) metrics and uncertainty thresholds.

```R
dmc_out <- dmc_identification(betaHMM_out)
dmc_df <- assay(dmc_out) # Contains 'DMC' flag (0 or 1)
```

### 4. Identifying DMRs
Group adjacent DMCs into regions. The `DMC_count` parameter (default = 2) defines the minimum number of adjacent DMCs required to form a DMR.

```R
dmr_out <- dmr_identification(dmc_out)
dmr_df <- assay(dmr_out) # Contains start/end info and DMR size
```

## Visualization

### Density and Uncertainty Plots
Visualize how well the model fits the data and the confidence in state assignments.

```R
# Plot fitted density with AUC metrics
AUC_chr <- AUC(dmc_out)
plot(betaHMM_out, chromosome = "7", what = "fitted density", AUC = AUC_chr)

# Plot uncertainty boxplots
plot(betaHMM_out, chromosome = "7", what = "uncertainty", uncertainty_threshold = 0.2)
```

### Genomic Context Plots
Visualize methylation values and DMCs/DMRs across a specific genomic range.

```R
# Plot 15 sites starting from a specific probe
plot(dmc_out, start_CpG = "cg17750844", end_CpG = 15)
```

## Threshold Identification
To find objective methylation thresholds (e.g., the beta values separating hypo/hemi/hyper states) for a single condition:

```R
threshold_out <- threshold_identification(pca_methylation_data[,1:5], 
                                          M = 3, N = 4,
                                          annotation_file = annotation_data)
threshold(threshold_out)
```

## Reference documentation

- [betaHMM](./references/betaHMM.md)