---
name: bioconductor-rtn
description: The RTN package provides a computational framework for reconstructing transcriptional regulatory networks and analyzing the activity of transcription factor regulons. Use when user asks to reconstruct transcriptional regulatory networks, perform master regulator analysis, calculate regulon activity profiles, or conduct gene set enrichment analysis on regulatory networks.
homepage: https://bioconductor.org/packages/release/bioc/html/RTN.html
---

# bioconductor-rtn

## Overview

The **RTN** package provides a computational framework for reconstructing Transcriptional Regulatory Networks (TRN) and analyzing regulons. A regulon is defined as a transcription factor (TF) and its set of predicted transcriptional targets. The package uses Mutual Information (MI) to test associations between TFs and targets, applies bootstrapping to remove unstable interactions, and utilizes the ARACNe algorithm (Data Processing Inequality) to eliminate redundant indirect edges. It also provides tools for enrichment analysis (MRA and GSEA) to link regulons to specific phenotypes or disease states.

## Core Workflows

### 1. Transcriptional Network Inference (TNI)

The TNI pipeline transforms gene expression data into a filtered regulatory network.

```R
library(RTN)

# 1. Initialization
# expData: matrix (genes x samples) or SummarizedExperiment
# regulatoryElements: vector of TF gene symbols/IDs
rtni <- tni.constructor(expData = expData, 
                        regulatoryElements = tfs, 
                        rowAnnotation = rowAnnot, 
                        colAnnotation = colAnnot)

# 2. Permutation analysis (MI calculation)
# Recommended: nPermutations >= 1000
rtni <- tni.permutation(rtni, nPermutations = 1000, pValueCutoff = 1e-7)

# 3. Bootstrap analysis (Stability check)
rtni <- tni.bootstrap(rtni)

# 4. DPI Filter (ARACNe algorithm)
# eps = 0 is strict; eps = NA estimates threshold from null distribution
rtni <- tni.dpi.filter(rtni, eps = 0)

# 5. Summarize and Extract
tni.regulon.summary(rtni)
regulons <- tni.get(rtni, what = "regulons.and.mode")
```

### 2. Transcriptional Network Analysis (TNA)

The TNA pipeline performs enrichment analysis on the inferred regulons using a specific phenotype (e.g., differential expression).

```R
# 1. Preprocessing
# phenotype: named numeric vector (e.g., log2FC)
# hits: character vector of significant genes
rtna <- tni2tna.preprocess(object = rtni, 
                           phenotype = phenotype, 
                           hits = hits)

# 2. Master Regulator Analysis (Hypergeometric test)
rtna <- tna.mra(rtna)
mra_results <- tna.get(rtna, what = "mra")

# 3. One-tailed GSEA (Association strength)
rtna <- tna.gsea1(rtna, nPermutations = 1000)

# 4. Two-tailed GSEA (Direction of activity: Activated vs Repressed)
rtna <- tna.gsea2(rtna, nPermutations = 1000)
gsea2_results <- tna.get(rtna, what = "gsea2")
```

### 3. Regulon Activity Profiles (RAPs)

Calculate the activity of regulons across individual samples in a cohort.

```R
# Calculate activity scores (dES) for each sample
rtni <- tni.gsea2(rtni, regulatoryElements = tfs)
raps <- tni.get(rtni, what = "regulonActivity")

# raps$dif contains the activity matrix (Regulons x Samples)
```

## Key Functions and Parameters

*   **tni.get() / tna.get()**: Primary accessors for retrieving results (e.g., "regulons", "mra", "gsea2", "regulonActivity").
*   **tni.alpha.adjust()**: Use this when comparing cohorts of different sizes to adjust the `pValueCutoff` and maintain similar Type I/II error tradeoffs.
*   **tni.replace.samples()**: Allows applying a previously reconstructed TRN (from Cohort A) to new expression data (Cohort B) to calculate activity profiles.
*   **Parallel Processing**: Use the `snow` package. Set `options(cluster = snow::makeCluster(spec = 4, "SOCK"))` before running permutation or bootstrap steps.

## Tips for Success

*   **Sample Size**: TRN inference (ARACNe) typically requires at least 100 samples for robust results.
*   **Regulon Size**: Regulons with < 15 targets are generally considered too small for stable enrichment analysis.
*   **Balanced Regulons**: Check `tni.regulon.summary()` to ensure regulons have a mix of positive and negative targets; highly unbalanced regulons may produce biased activity readouts.
*   **MI Estimator**: For RNA-seq data, the default non-parametric estimator in `tni.permutation` is recommended.

## Reference documentation

- [RTN: Reconstruction of Transcriptional regulatory Networks and analysis of regulons.](./references/RTN.md)