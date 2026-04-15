---
name: bioconductor-phosr
description: bioconductor-phosr provides a comprehensive framework for the preprocessing, normalization, and downstream analysis of mass spectrometry-based phosphoproteomic data. Use when user asks to filter and impute phosphoproteomic datasets, perform batch correction using stably phosphorylated sites, identify kinase-substrate relationships, or conduct directional pathway enrichment analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/PhosR.html
---

# bioconductor-phosr

name: bioconductor-phosr
description: Comprehensive analysis of phosphoproteomic data including preprocessing (filtering, imputation, batch correction), downstream analysis (pathway enrichment, site-centric analysis), and signalome construction. Use when analyzing mass spectrometry-based phosphoproteomic datasets to identify kinase activities and signaling network dynamics.

# bioconductor-phosr

## Overview
PhosR is a specialized R package for the processing and downstream analysis of phosphoproteomic data. It addresses unique challenges in phosphoproteomics such as high missingness, batch effects, and the need to integrate site-level data into gene-level signaling pathways. The package provides a `PhosphoExperiment` object (extending `SummarizedExperiment`) to manage quantification and site-specific metadata (residues, positions, and flanking sequences).

## Core Workflow

### 1. Data Initialization
Create a `PhosphoExperiment` (ppe) object from a quantification matrix.
```r
library(PhosR)
# ppe <- PhosphoExperiment(assays = list(Quantification = quant_matrix))
# Add required metadata
GeneSymbol(ppe) <- symbols
Residue(ppe) <- residues # e.g., S, T, Y
Site(ppe) <- positions   # e.g., 198
Sequence(ppe) <- sequences # flanking sequences
```

### 2. Preprocessing
*   **Filtering**: Retain sites based on quantification frequency across groups.
    ```r
    # Keep sites with 50% values in at least one group
    ppe_filtered <- selectGrps(ppe, grps, 0.5, n=1)
    ```
*   **Imputation**:
    *   `scImpute`: Site- and condition-specific imputation using empirical normal distributions.
    *   `ptImpute`: Paired tail-based imputation for sites missing entirely in one condition but present in another.
*   **Normalization**: Use `medianScaling` for basic normalization.

### 3. Batch Correction (RUVphospho)
PhosR uses Stably Phosphorylated Sites (SPSs) as negative controls to remove unwanted variation.
```r
# Use provided SPSs or generate new ones with getSPS()
data("SPSs")
ctl <- which(paste0(GeneSymbol(ppe), ";", Residue(ppe), Site(ppe), ";") %in% SPSs)
ppe <- RUVphospho(ppe, M = design_matrix, k = 3, ctl = ctl)
```

### 4. Downstream Analysis
*   **1D Enrichment**: Use `phosCollapse` to summarize site data to gene level, then run `pathwayOverrepresent` or `pathwayRankBasedEnrichment`.
*   **2D/3D Directional Analysis**: Use `directPA` to identify kinases regulated by combinations of treatments (e.g., Insulin vs. AICAR).
*   **Time-course Analysis**: Integrate with `ClueR` via `runClue` to identify temporal phosphorylation patterns.

### 5. Signalome Construction
Identify kinase-substrate relationships by combining sequence motifs and experimental dynamics.
```r
# 1. Score relationships
L6.matrices <- kinaseSubstrateScore(substrate.list = PhosphoSite.mouse, 
                                    mat = std_mat, seqs = sequences)
# 2. Predict kinase-substrate pairs
L6.predMat <- kinaseSubstratePred(L6.matrices)
# 3. Construct signalome
sig_results <- Signalomes(KSR=L6.matrices, predMatrix=L6.predMat, 
                          exprsMat=std_mat, KOI=c("AKT1", "PRKAA1"))
```

## Visualization Tools
*   `plotQC`: Generate barplots ("quantify"), dendrograms ("dendrogram"), or PCA plots ("pca") to evaluate data quality and batch effects.
*   `perturbPlot2d`: Visualize kinase activity across all possible directions in 2D space.
*   `plotSignalomeMap`: Balloon plots showing kinase regulation of protein modules.
*   `plotKinaseNetwork`: Network visualization of kinase connectivity.

## Reference documentation
- [An introduction to PhosR package](./references/PhosR.md)