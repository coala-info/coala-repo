---
name: bioconductor-fletcher2013a
description: This package provides gene expression datasets and analysis pipelines for studying FGFR2 signaling in breast cancer cells. Use when user asks to access MCF-7 time-course data, reproduce differential expression analyses, perform PCA on experimental systems, or retrieve specific gene signatures from the Fletcher et al. (2013) study.
homepage: https://bioconductor.org/packages/release/data/experiment/html/Fletcher2013a.html
---

# bioconductor-fletcher2013a

name: bioconductor-fletcher2013a
description: Access and analyze time-course gene expression data from MCF-7 breast cancer cells treated to perturb FGFR2 signaling. Use this skill to reproduce differential expression (DE) analyses, perform Principal Component Analysis (PCA) on experimental systems, and retrieve specific gene signatures (E2 and FGFR2) from the Fletcher et al. (2013) study.

## Overview

The `Fletcher2013a` package provides datasets and a standardized analysis pipeline for studying FGFR2 signaling in breast cancer cells. It contains three primary experimental datasets (`Exp1`, `Exp2`, `Exp3`) stored as `ExpressionSet` objects. These experiments cover endogenous FGFRs perturbation, iF2 construct perturbation, and FGFR2b perturbation. The package includes automated pipelines for limma-based differential expression and PCA.

## Loading Data

The package contains three main datasets representing different experimental systems:

```r
library(Fletcher2013a)
data(Exp1) # Endogenous FGFRs perturbation
data(Exp2) # iF2 construct perturbation
data(Exp3) # FGFR2b perturbation
```

## Automated Analysis Pipelines

The package provides high-level wrapper functions to reproduce the study's analysis.

### Differential Expression (limma)
Run the 4-step limma pipeline (extraction, modeling, contrasts, and eBayes correction). This saves `.rda` files (e.g., `Exp1limma.rda`) and generates summary figures of DE probes.

```r
Fletcher2013pipeline.limma(Exp1)
Fletcher2013pipeline.limma(Exp2)
Fletcher2013pipeline.limma(Exp3)
```

### Principal Component Analysis
Perform PCA on the gene expression matrices using the DE genes identified in the limma analysis to assess experimental variation.

```r
Fletcher2013pipeline.pca(Exp1)
Fletcher2013pipeline.pca(Exp2)
Fletcher2013pipeline.pca(Exp3)
```

## Retrieving Gene Signatures

Use `Fletcher2013pipeline.deg` to extract consolidated gene lists organized by experimental contrasts.

```r
# Retrieve DE genes for a specific experiment
deExp1 <- Fletcher2013pipeline.deg(what="Exp1")

# Common contrast names within the returned list:
# "E2"          : DE genes in E2 vs. vehicle
# "E2FGF10"     : DE genes in E2+FGF10 vs. E2
# "E2AP20187"   : DE genes in E2+AP20187 vs. E2
# "TetE2FGF10"  : DE genes in Tet+E2+FGF10 vs. Tet+E2
# "random"      : Random gene lists for control
```

## Visualization and Follow-up

To reproduce the overlap analysis (Venn diagrams) and specific gene follow-ups (like IL8 expression) described in the paper:

```r
# Generate supplementary figures and overlap plots
library(VennDiagram)
Fletcher2013pipeline.supp()

# Weighted Venn diagram (requires Vennerable package)
# library(Vennerable)
# vv <- list(Exp1=deExp1$E2FGF10, Exp2=deExp2$E2AP20187, Exp3=deExp3$TetE2FGF10)
# plotVenn(Venn(vv), doWeights=TRUE)
```

## Workflow Tips
- **Data Context**: `Exp1` focuses on endogenous receptors, `Exp2` on a chemically inducible FGFR2 (iF2), and `Exp3` on regulated expression of FGFR2b.
- **Output Files**: Pipeline functions write results directly to the working directory. Ensure you have write permissions in your current R session.
- **Downstream Analysis**: For network analysis based on this data, refer to the companion package `Fletcher2013b`.

## Reference documentation

- [Fletcher2013a](./references/Fletcher2013a.md)