---
name: bioconductor-methylmix
description: MethylMix identifies DNA methylation-driven genes by integrating methylation data with matched gene expression data using beta mixture models. Use when user asks to identify functional methylation drivers, analyze differential methylation states in cancer samples, or correlate DNA methylation with gene expression.
homepage: https://bioconductor.org/packages/release/bioc/html/MethylMix.html
---


# bioconductor-methylmix

name: bioconductor-methylmix
description: Identifying DNA methylation-driven genes using the MethylMix R package. Use this skill when analyzing DNA methylation data (27k, 450k, or Epic arrays) alongside matched gene expression data to identify functional, differentially methylated genes (drivers) using beta mixture models.

# bioconductor-methylmix

## Overview

MethylMix is an analytical framework for identifying genes where DNA methylation significantly impacts gene expression. It uses a beta mixture model to identify subpopulations of samples with distinct methylation states (hyper- or hypo-methylated) compared to normal tissue. A gene is considered a "MethylMix driver" if it is both differentially methylated and shows a significant negative correlation with its own gene expression.

## Core Workflow

### 1. Data Preparation
MethylMix requires three matrix objects with genes as rows (unique symbols) and samples as columns:
- `METcancer`: DNA methylation beta-values for disease samples.
- `METnormal`: DNA methylation beta-values for normal/baseline samples.
- `GEcancer`: Matched gene expression data for the disease samples.

### 2. TCGA Data Acquisition
The package provides automated utilities to download and preprocess TCGA data:

```r
library(MethylMix)
library(doParallel)

# Setup parallel processing (highly recommended)
cl <- makeCluster(5)
registerDoParallel(cl)

cancerSite <- "OV" # Example: Ovarian Cancer
targetDir <- "./data/"
GetData(cancerSite, targetDir)

stopCluster(cl)
```

### 3. Running MethylMix
The main function executes the correlation analysis and beta mixture modeling:

```r
# Basic execution
MethylMixResults <- MethylMix(METcancer, GEcancer, METnormal)

# Parallel execution
cl <- makeCluster(5)
registerDoParallel(cl)
MethylMixResults <- MethylMix(METcancer, GEcancer, METnormal)
stopCluster(cl)
```

### 4. Interpreting Results
The output is a list containing:
- `MethylationDrivers`: Character vector of identified driver genes.
- `MethylationStates`: Matrix of DM-values (Difference in Methylation). DM-value = (Mean of mixture component) - (Mean of normal samples).
- `Classifications`: Matrix assigning each sample to a specific mixture component per gene.
- `NrComponents`: Number of methylation states found for each gene.

## Visualization

Use `MethylMix_PlotModel` to visualize the mixture model and the expression correlation:

```r
# Plot mixture model for a specific gene
plots <- MethylMix_PlotModel("MGMT", MethylMixResults, METcancer, METnormal = METnormal)
plots$MixtureModelPlot

# Plot mixture model and expression correlation
plots <- MethylMix_PlotModel("MGMT", MethylMixResults, METcancer, GEcancer, METnormal)
plots$MixtureModelPlot
plots$CorrelationPlot
```

## Advanced Preprocessing
If not using the automated `GetData` pipeline, you can manually process methylation data:

1. **Download**: `Download_DNAmethylation(cancerSite, targetDirectory)`
2. **Preprocess**: `Preprocess_DNAmethylation(cancerSite, METdirectories)` (includes missing value estimation and Combat batch correction).
3. **Cluster Probes**: `ClusterProbes(METcancer, METnormal)` maps probes to genes and clusters them.

## Tips
- **Parallelization**: Mixture modeling is computationally intensive. Always use `doParallel` for large datasets.
- **Beta Values**: Ensure methylation data is in beta-value format (0 to 1).
- **Functional Methylation**: MethylMix specifically looks for *cis*-regulated promoter methylation; it works best with CpG sites associated with gene transcripts.

## Reference documentation
- [MethylMix Vignette](./references/vignettes.md)