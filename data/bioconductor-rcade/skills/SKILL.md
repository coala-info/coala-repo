---
name: bioconductor-rcade
description: This tool integrates ChIP-seq data with differential expression analysis using a Bayesian framework to identify direct transcription factor targets. Use when user asks to integrate TF binding evidence with gene expression changes, quantify ChIP-seq signal in genomic bins, or identify genes that exhibit both binding activity and differential expression.
homepage: https://bioconductor.org/packages/3.8/bioc/html/Rcade.html
---


# bioconductor-rcade

name: bioconductor-rcade
description: Analysis of ChIP-seq data coupled with Differential Expression (DE) analysis to infer direct transcription factor targets. Use when integrating TF binding evidence (ChIP-seq) with gene expression changes (DE) using a Bayesian framework to identify genes that exhibit both binding activity and differential expression.

# bioconductor-rcade

## Overview

Rcade (R-based analysis of ChIP-seq And Differential Expression data) integrates ChIP-seq results with an existing Differential Expression (DE) analysis. It uses a fully Bayesian modelling approach, focusing on log-odds values (B-values) to quantify the probability that a gene is a direct target of a transcription factor (TF). Unlike peak-calling methods, Rcade quantifies binding activity within user-defined genomic bins (e.g., around transcription start sites).

## Simple Workflow

### 1. Prepare Differential Expression (DE) Data
Rcade requires a DE matrix with Bayesian information. Compatible sources include `limma` (via `topTable`) and `baySeq`.

```r
# DE matrix must contain: geneID, logFC, and B (log-odds)
DE <- read.csv("DE_results.csv")

# Define a lookup list to map Rcade fields to your DE columns
DElookup <- list(GeneID="ENSG", logFC="logFC", B="B")
```

### 2. Prepare ChIP-seq Targets
Create a targets matrix describing your `.bam` files.

```r
# Required fields: fileID, sampleID, factor, filepath
# Note: Control files must have factor = "Input"
targets <- data.frame(
  fileID = c("Input1", "ChIP1", "ChIP2"),
  sampleID = c("Input1", "ChIP1", "ChIP2"),
  factor = c("Input", "Stat1", "Stat1"),
  filepath = c("input.bam", "chip1.bam", "chip2.bam"),
  shift = 0
)
```

### 3. Define Genomic Bins
Define the regions where ChIP-seq signal will be quantified, typically around Transcription Start Sites (TSS).

```r
library(Rcade)
# anno should contain: ENSG, chr, start, end, str
# zone defines the range relative to the feature (e.g., -1500bp to +1500bp)
ChIPannoZones <- defineBins(anno, zone=c(-1500, 1500), geneID="ENSG")
```

### 4. Run Rcade Analysis
Specify priors to reflect the dependency between ChIP-seq signal and DE status.

```r
# Example priors: genes with ChIP signal (D|C) are more likely to be DE
prior <- c("D|C" = 0.05, "D|notC" = 0.005)

Rcade <- RcadeAnalysis(DE, ChIPannoZones, 
                       annoZoneGeneidName="ENSG",
                       ChIPtargets=targets, 
                       ChIPfileDir = ".",
                       DE.prior=0.01, 
                       prior=prior,
                       DElookup=DElookup)
```

### 5. Access and Export Results
Results are stored in an Rcade object and can be extracted or exported to CSV.

```r
# Extract the combined table
results <- getRcade(Rcade)

# Export top targets to disk
exportRcade(Rcade, directory="RcadeOutput", cutoffArg=1000)
```

## Visualization and QC

Rcade provides specific plotting functions to validate the integration:

*   `plotPCA(Rcade)`: PCA on ChIP-seq counts to check sample clustering.
*   `plotMM(Rcade)`: Log-ratios of DE vs. ChIP-seq; points are colored by the probability of being a target.
*   `plotBBB(Rcade)`: A 3D plot (requires `rgl`) comparing log-odds of ChIP-seq, DE, and the combined analysis.

## Key Considerations
*   **B-values**: Rcade uses log-odds ($B = \log(\frac{PP}{1-PP})$). These are not p-values.
*   **Independence Assumption**: Rcade assumes that, conditional on a gene being a target, the ChIP-seq and DE data are independent.
*   **Parallelization**: Use the `cl` argument in `RcadeAnalysis` with a cluster object from the `parallel` package to speed up count processing.

## Reference documentation
- [Rcade](./references/Rcade.md)