---
name: bioconductor-toxicogx
description: ToxicoGx provides a standardized framework for the integrated analysis of large-scale toxicogenomic datasets to study drug-induced gene expression changes. Use when user asks to load toxicogenomic data, plot drug-gene response curves, compute drug perturbation signatures, or perform connectivity map analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/ToxicoGx.html
---


# bioconductor-toxicogx

## Overview

ToxicoGx is a Bioconductor package designed for the integrated analysis of toxicogenomic data. It provides a standardized framework (the `ToxicoSet` or `TSet` object) to store and manipulate large-scale toxicogenomics datasets like TG-GATEs. The package facilitates the analysis of how drugs affect gene expression over time and at different dosages, enabling researchers to identify molecular signatures of drug toxicity and perform connectivity mapping between drug-induced profiles and disease states.

## Core Workflows

### 1. Data Loading and Exploration
ToxicoGx uses `ToxicoSet` objects. You can load toy datasets provided with the package or download full datasets using `downloadTSet`.

```r
library(ToxicoGx)

# Load a toy dataset
data(TGGATESsmall)

# Check available drugs and cell lines
drugNames(TGGATESsmall)
cellNames(TGGATESsmall)
```

### 2. Plotting Gene Expression Changes
Use `drugGeneResponseCurve` to visualize how a specific gene's expression changes across different doses and time points for a given drug.

```r
ToxicoGx::drugGeneResponseCurve(
  TGGATESsmall,
  duration = c("2", "8", "24"),
  cell_lines = "Hepatocyte", 
  mDataTypes = "rna",
  features = "ENSG00000140465_at", # Example gene ID
  dose = c("Control", "Low", "Middle", "High"),
  drug = "Carbon tetrachloride",
  ggplot_args = list(ggplot2::labs(title="Effect on CYP1A1")),
  summarize_replicates = FALSE
)
```

### 3. Computing Drug Perturbation Signatures
To estimate the statistical effect of a drug on molecular profiles (e.g., RNA expression), use `drugPerturbationSig`. This function fits a linear model to calculate the significance of gene expression changes.

```r
drug.perturbation <- ToxicoGx::drugPerturbationSig(
  tSet = TGGATESsmall,
  mDataType = "rna",
  cell_lines = "Hepatocyte",
  duration = "24",
  features = fNames(TGGATESsmall, "rna"),
  dose = c("Control", "Low"),
  drugs = c("Omeprazole", "Isoniazid"),
  returnValues = c("estimate", "tstat", "pvalue", "fdr"),
  verbose = FALSE
)
```

### 4. Connectivity Map Analysis
Compare drug signatures against disease signatures (like Hepatocellular Carcinoma - HCC) using GSEA-based connectivity scoring.

```r
# Load a reference signature
data(HCC_sig)

# Calculate connectivity scores using the t-statistics from perturbation analysis
res <- apply(drug.perturbation[,,c("tstat", "fdr")], 2, function(x, HCC){
  return(CoreGx::connectivityScore(
    x = x,
    y = HCC[, 2, drop = FALSE],
    method = "fgsea", 
    nperm = 100
  ))
}, HCC = HCC_sig[1:195,])
```

## Usage Tips
- **Feature IDs**: Ensure you use the correct feature identifiers (e.g., Ensembl IDs with suffixes) as stored in the `TSet`. Use `fNames(tSet, "rna")` to list them.
- **Memory Management**: Full toxicogenomics datasets are large. When working with full TSets, ensure your R environment has sufficient memory or subset the data early.
- **CoreGx Dependency**: ToxicoGx builds upon `CoreGx`. Functions like `connectivityScore` are often inherited or utilized from the `CoreGx` package.

## Reference documentation
- [ToxicoGx Case Studies](./references/toxicoGxCaseStudies.md)