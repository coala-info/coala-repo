---
name: bioconductor-gcrisprtools
description: This tool analyzes pooled CRISPR screening data to perform quality control, normalization, and gene-level target prioritization. Use when user asks to perform quality control on CRISPR screens, normalize guide counts, prioritize gene targets using RRA, or visualize screen results and contrasts.
homepage: https://bioconductor.org/packages/release/bioc/html/gCrisprTools.html
---

# bioconductor-gcrisprtools

name: bioconductor-gcrisprtools
description: Analysis of pooled CRISPR screening data using gCrisprTools. Use this skill to perform quality control, normalization, target prioritization (RRA alpha), and visualization of CRISPR screens. It supports complex experimental designs via limma/voom and enables comparison across multiple screen contrasts.

# bioconductor-gcrisprtools

## Overview

The `gCrisprTools` package is a Bioconductor suite designed for the analysis of pooled CRISPR screens. It leverages the `limma` linear modeling framework to handle complex experimental designs and uses the Robust Rank Aggregation (RRA) algorithm to prioritize gene targets from guide-level data. Key capabilities include comprehensive QC reporting, guide-to-gene signal aggregation, and cross-contrast comparisons.

## Core Workflow

### 1. Data Preparation
The package requires an `ExpressionSet` for counts, a `data.frame` for annotation, and a named factor for the sample key.

```R
library(gCrisprTools)
library(Biobase)
library(limma)

# Load data (counts in assayData, samples in phenoData)
data("es", package = "gCrisprTools")
data("ann", package = "gCrisprTools")

# Create a sample key (relevel to set the reference/control group)
sk <- relevel(as.factor(pData(es)$TREATMENT_NAME), "ControlReference")
names(sk) <- row.names(pData(es))
```

### 2. Preprocessing and Normalization
Filter low-count guides and normalize to account for library size and composition biases.

```R
# Filter trace reads
es <- ct.filterReads(es, trim = 1000, sampleKey = sk)

# Normalize (options: 'scale', 'FQ', 'slope', 'controlScale', 'controlSpline')
es <- ct.normalizeGuides(es, method = "scale", plot.it = TRUE)

# Update annotation to match filtered guides
ann <- ct.prepareAnnotation(ann, es, controls = "NoTarget")
```

### 3. Differential Expression (Guide Level)
Use `limma/voom` to model the screen dynamics.

```R
design <- model.matrix(~ 0 + REPLICATE_POOL + TREATMENT_NAME, pData(es))
colnames(design) <- gsub('TREATMENT_NAME', '', colnames(design))
contrasts <- makeContrasts(DeathExpansion - ControlExpansion, levels = design)

vm <- voom(exprs(es), design)
fit <- lmFit(vm, design)
fit <- contrasts.fit(fit, contrasts)
fit <- eBayes(fit)
```

### 4. Target Prioritization (Gene Level)
Aggregate guide-level signals into gene-level results using RRA.

```R
resultsDF <- ct.generateResults(
  fit,
  annotation = ann,
  RRAalphaCutoff = 0.1,
  permutations = 1000,
  scoring = "combined"
)
```

## Visualization and QC

### Quality Control Plots
- `ct.alignmentChart(aln, sk)`: Visualize read alignment success.
- `ct.rawCountDensities(es, sk)`: Check for sequencing depth or PCR artifacts.
- `ct.gRNARankByReplicate(es, sk)`: Waterfall plots of guide abundance.
- `ct.viewControls(es, ann, sk)`: Monitor Non-Targeting Control (NTC) behavior.

### Results Visualization
- `ct.topTargets(fit, resultsDF, ann, targets = 10, enrich = TRUE)`: View log2FC of guides for top hits.
- `ct.viewGuides("GeneName", fit, ann)`: Detailed view of all guides for a specific gene.
- `ct.contrastBarchart(resultsDF)`: Summary of enriched vs. depleted targets.

## Advanced Analysis

### Comparing Multiple Contrasts
To compare results across different experiments or conditions, use "Simple Result" objects.

```R
# Create simplified target-level objects
res1 <- ct.simpleResult(resultsDF)

# Regularize multiple results to be in register
regularized <- ct.regularizeContrasts(dflist = list('Exp1' = res1, 'Exp2' = res2))

# Identify replicated signals
comparison <- ct.compareContrasts(dflist = regularized, statistics = 'best.p', cutoffs = 0.05)

# Multi-contrast visualization
ct.upSet(regularized)
```

### Gene Set Enrichment
Perform ontological testing using the `sparrow` integration.

```R
genesetdb <- sparrow::getMSigGeneSetDb(collection = 'h', species = 'human', id.type = 'entrez')
seas_res <- ct.seas(resultsDF, gdb = genesetdb)
```

## Automated Reporting
Generate comprehensive HTML reports for QC or specific contrasts.

```R
# Full experiment report
ct.makeReport(fit = fit, eset = es, sampleKey = sk, annotation = ann, results = resultsDF, outdir = ".")

# QC-only report
ct.makeQCReport(es, sampleKey = sk, annotation = ann, identifier = 'QC_Report')
```

## Reference documentation
- [Advanced Screen Analysis: Contrast Comparisons](./references/Contrast_Comparisons.md)
- [Example Workflow For Processing a Single Pooled Screen](./references/Crispr_example_workflow.md)
- [gCrisprTools and the Analysis of Pooled Screening Data](./references/gCrisprTools_Vignette.md)