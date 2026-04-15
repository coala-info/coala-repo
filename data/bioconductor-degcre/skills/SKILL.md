---
name: bioconductor-degcre
description: This tool provides a probabilistic framework to associate differentially expressed genes with cis-regulatory elements using a non-parametric approach. Use when user asks to link gene expression changes with regulatory signal data, identify functional gene-enhancer relationships, or optimize significance thresholds for gene-regulatory associations.
homepage: https://bioconductor.org/packages/release/bioc/html/DegCre.html
---

# bioconductor-degcre

name: bioconductor-degcre
description: Probabilistic association of differentially expressed genes (DEGs) with cis-regulatory elements (CREs). Use this skill to link gene expression changes with regulatory signal data (e.g., ChIP-seq, ATAC-seq) using a non-parametric approach. Ideal for analyzing perturbations (drug treatments, ligands) to identify functional gene-enhancer relationships.

## Overview
DegCre (Differentially Expressed Gene - Cis-Regulatory Element) provides a probabilistic framework to associate DEGs with CREs. It uses a distance-dependent binning heuristic and a non-parametric algorithm to calculate association probabilities and FDRs. It is built on the `GenomicRanges` and `InteractionSet` frameworks, allowing for seamless integration with standard Bioconductor workflows.

## Core Workflow

### 1. Data Preparation
Input data must be in `GRanges` format.
- **DegGR**: Gene TSS locations with metadata columns for p-values (`DegP`) and log fold-changes (`DegLfc`).
- **CreGR**: Regulatory regions (e.g., peaks) with metadata columns for p-values (`CreP`) and log fold-changes (`CreLfc`).

### 2. Running the Association
The primary function is `runDegCre`. By default, it requires concordance in the direction of effect (e.g., an upregulated gene associated with an increased regulatory signal).

```r
library(DegCre)

# Basic execution
results <- runDegCre(
    DegGR = myDegGR, DegP = myDegGR$pVal, DegLfc = myDegGR$logFC,
    CreGR = myCreGR, CreP = myCreGR$pVal, CreLfc = myCreGR$logFC,
    reqEffectDirConcord = TRUE
)
```

### 3. Parameter Optimization
The choice of the DEG significance threshold ($\alpha$) significantly impacts results. Use `optimizeAlphaDegCre` to find the $\alpha$ that maximizes the normalized Precision-Recall Area Under the Curve (AUC).

```r
alphaOpt <- optimizeAlphaDegCre(
    DegGR = subDegGR, DegP = subDegGR$pVal, DegLfc = subDegGR$logFC,
    CreGR = subCreGR, CreP = subCreGR$pVal, CreLfc = subCreGR$logFC
)
# Extract best result
bestAlphaId <- which.max(alphaOpt$alphaPRMat[, "normDeltaAUC"])
bestResults <- alphaOpt$degCreResListsByAlpha[[bestAlphaId]]
```

### 4. Interpreting Results
The output is a list containing:
- `degCreHits`: A `Hits` object where `queryHits` index `DegGR` and `subjectHits` index `CreGR`.
- `assocProb`: Probability of the association being true.
- `assocProbFDR`: FDR adjusted for TSS-to-CRE distance.

Filter results by significance:
```r
significant_hits <- results$degCreHits[results$degCreHits$assocProbFDR <= 0.05]
```

## Visualization
DegCre includes several plotting functions to evaluate the model:
- `plotDegCreAssocProbVsDist()`: Shows how association probability decays with distance.
- `plotDegCreBinHeuristic()`: Visualizes the distance binning optimization.
- `degCrePRAUC()`: Generates a Precision-Recall curve against a null model.
- `plotBrowserDegCre()`: Creates a genomic browser view of associations using `plotgardener`.

## Data Conversion
To use results with other tools or export them:
- **GInteractions**: `convertdegCreResListToGInteraction(results, assocAlpha = 0.05)`
- **DataFrame/BEDPE**: `convertDegCreDataFrame(results, assocAlpha = 0.05)`

## Tips
- **Distance Limits**: The default maximum distance for associations is 1Mb; adjust via `maxDist` in `runDegCre`.
- **Expected Associations**: Use `getExpectAssocPerDEG()` to rank genes by the total sum of their association probabilities, which helps identify highly regulated hubs.
- **Concordance**: If analyzing a repressor, you may need to set `reqEffectDirConcord = FALSE` or manually handle inverse relationships.

## Reference documentation
- [DegCre Introduction and Examples](./references/degcre_introduction_and_examples.md)
- [DegCre Introduction and Examples (Source)](./references/degcre_introduction_and_examples.Rmd)