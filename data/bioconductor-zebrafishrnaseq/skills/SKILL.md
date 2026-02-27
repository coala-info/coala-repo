---
name: bioconductor-zebrafishrnaseq
description: This package provides gene-level RNA-Seq counts from a zebrafish experiment including ERCC spike-ins for differential expression and normalization analysis. Use when user asks to load zebrafish gene expression data, access ERCC spike-in counts, or benchmark RNA-Seq normalization methods.
homepage: https://bioconductor.org/packages/release/data/experiment/html/zebrafishRNASeq.html
---


# bioconductor-zebrafishrnaseq

name: bioconductor-zebrafishrnaseq
description: Provides access to gene-level RNA-Seq counts from a zebrafish experiment, including ERCC spike-ins. Use this skill when a user needs to load, explore, or analyze the zebrafish dataset for differential expression analysis, normalization benchmarking (e.g., with RUVSeq), or spike-in evaluation.

# bioconductor-zebrafishrnaseq

## Overview
The `zebrafishRNASeq` package is a Bioconductor experiment data package. It contains gene-level read counts from an RNA-Seq experiment on zebrafish olfactory sensory neurons. The dataset consists of six samples: three control (Ctl) and three gallein-treated (Trt) pools. This dataset is particularly useful for demonstrating differential expression workflows and normalization techniques, as it includes both endogenous gene counts and ERCC (External RNA Controls Consortium) spike-in counts.

## Loading the Dataset
To access the data, load the package and use the `data()` function to load the `zfGenes` object.

```r
library(zebrafishRNASeq)
data(zfGenes)

# View the first few rows of the count matrix
head(zfGenes)
```

## Data Structure
The `zfGenes` object is a matrix where:
- **Rows**: Represent Ensembl gene IDs (e.g., `ENSDARG...`) and ERCC spike-in IDs (e.g., `ERCC-...`).
- **Columns**: Represent the six experimental samples: `Ctl1`, `Ctl3`, `Ctl5` (Controls) and `Trt9`, `Trt11`, `Trt13` (Treated).

## Working with Spike-ins
The ERCC spike-ins are included in the same matrix as the endogenous genes. You can subset them using a regular expression:

```r
# Extract spike-in counts
spikes <- zfGenes[grep("^ERCC", rownames(zfGenes)), ]

# Extract endogenous gene counts (excluding spike-ins)
genes <- zfGenes[grep("^ENSDARG", rownames(zfGenes)), ]
```

## Typical Workflow
1. **Data Acquisition**: Load `zfGenes`.
2. **Experimental Design**: Define the groups for differential expression.
   ```r
   groups <- factor(c("Ctl", "Ctl", "Ctl", "Trt", "Trt", "Trt"))
   ```
3. **Normalization/DE Analysis**: This dataset is frequently used as input for packages like `DESeq2`, `edgeR`, or `RUVSeq`.
   - Use the endogenous genes for standard normalization.
   - Use the `spikes` subset to evaluate technical variation or for spike-in-based normalization.

## Reference documentation
- [Pre-Processing for the Zebrafish RNA-Seq Gene-Level Counts](./references/preprocessing.md)