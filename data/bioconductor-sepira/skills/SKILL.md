---
name: bioconductor-sepira
description: SEPIRA estimates transcription factor activity from mRNA expression or DNA methylation profiles by leveraging downstream regulatory targets. Use when user asks to construct tissue-specific regulatory networks, infer transcription factor activity scores, or analyze regulatory activity from gene expression and methylation data.
homepage: https://bioconductor.org/packages/3.8/bioc/html/SEPIRA.html
---


# bioconductor-sepira

name: bioconductor-sepira
description: Systems EPigenomics Inference of Regulatory Activity (SEPIRA) for estimating transcription factor (TF) activity from mRNA expression or DNA methylation profiles. Use this skill to construct tissue-specific TF regulatory networks and infer TF activity scores in biological samples.

# bioconductor-sepira

## Overview

SEPIRA is a computational tool designed to estimate the activity of transcription factors (TFs) by leveraging their downstream regulatory targets. It operates on the principle that TF activity can be inferred from the expression or methylation levels of the genes they regulate. The workflow typically involves two stages:
1.  **Network Construction**: Building a tissue-specific regulatory network using a reference dataset (like GTEx).
2.  **Activity Estimation**: Applying that network to a target dataset (mRNA or DNA methylation) to calculate TF activity scores.

## Core Workflow

### 1. Constructing a Tissue-Specific Network
Use `sepiraInfNet` to identify TFs and their high-confidence targets for a specific tissue of interest (TOI).

```r
# data.m: Normalized gene expression matrix (genes in rows, samples in columns)
# TFeid: Vector of Entrez Gene IDs for TFs
net.o <- sepiraInfNet(
  data = data.m, 
  tissue = colnames(data.m), 
  toi = "Lung",          # Tissue of Interest
  cft = "Blood",         # Contrast tissue (optional)
  TFs = TFeid, 
  sdth = 0.25,           # Standard deviation threshold
  sigth = 0.05,          # Significance threshold
  pcorth = 0.2,          # Partial correlation threshold
  degth = c(0.05, 0.05), # P-value thresholds for differential expression
  lfcth = c(log2(1.5), 0), # Log-fold change thresholds
  minNtgts = 5,          # Minimum number of targets per TF
  ncores = 1
)

# The resulting network for the TOI is stored in:
# net.o$netTOI
```

### 2. Estimating TF Activity
Once the network is defined, use `sepiraRegAct` to calculate activity scores in your study dataset.

#### From Gene Expression (mRNA)
```r
# type = "exp" for expression data
act_exp <- sepiraRegAct(
  data = study_data.m, 
  type = "exp", 
  regnet = net.o$netTOI, 
  norm = "z", 
  ncores = 1
)
```

#### From DNA Methylation (DNAm)
When using DNA methylation, the algorithm automatically inverts the binding profile (multiplies by -1) because promoter hypermethylation is generally associated with gene silencing.
```r
# type = "DNAm" for promoter methylation data
act_dnam <- sepiraRegAct(
  data = dnam_data.m, 
  type = "DNAm", 
  regnet = net.o$netTOI, 
  norm = "z", 
  ncores = 1
)
```

## Key Parameters and Data Requirements

*   **Input Data**: Data should be genome-wide. For DNA methylation, use promoter-specific values (e.g., TSS200 or 1st Exon averages).
*   **TFs**: You must provide a list of Entrez IDs for the transcription factors to be considered.
*   **Activity Scores**: The output is a matrix of t-statistics from a linear regression of the sample profile against the TF binding profile. Higher t-statistics indicate higher inferred TF activity.
*   **Validation**: It is recommended to validate the inferred network on an independent dataset (e.g., Protein Atlas) to ensure the predicted targets faithfully represent TF activity in the tissue of interest.

## Reference documentation

- [SEPIRA](./references/SEPIRA.md)