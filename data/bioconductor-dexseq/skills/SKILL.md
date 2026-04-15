---
name: bioconductor-dexseq
description: This Bioconductor package identifies differential exon usage in RNA-seq data by testing for changes in the relative expression of exons across experimental conditions. Use when user asks to detect alternative splicing, perform differential exon usage analysis, or visualize exon-level expression patterns using generalized linear models.
homepage: https://bioconductor.org/packages/release/bioc/html/DEXSeq.html
---

# bioconductor-dexseq

## Overview

DEXSeq is a Bioconductor package designed to identify differential exon usage (DEU) between experimental conditions using RNA-seq count data. Unlike standard differential gene expression analysis, DEXSeq tests whether the ratio of an exon's expression to the rest of the gene's expression changes across conditions. It employs a generalized linear model (GLM) based on the negative binomial distribution, accounting for biological variation through dispersion shrinkage (similar to DESeq2).

## Core Workflow

### 1. Data Preparation and Object Construction

DEXSeq requires a `DEXSeqDataSet` object. This can be constructed from `SummarizedExperiment` objects or directly from count files.

```R
library(DEXSeq)

# From a SummarizedExperiment (se)
# The design formula must include sample, exon, and the interaction condition:exon
dxd <- DEXSeqDataSetFromSE(se, design = ~ sample + exon + condition:exon)

# From HTSeq-style count files
dxd <- DEXSeqDataSetFromHTSeq(
   countFiles,
   sampleData = sampleTable,
   design = ~ sample + exon + condition:exon,
   flattenedfile = "annotation.gff"
)
```

### 2. Normalization and Dispersion Estimation

DEXSeq uses size factors for normalization and estimates per-exon dispersions to account for technical and biological noise.

```R
# Estimate size factors for normalization
dxd <- estimateSizeFactors(dxd)

# Estimate dispersions (crucial for statistical power)
dxd <- estimateDispersions(dxd)

# Optional: Plot dispersion estimates to check fit quality
plotDispEsts(dxd)
```

### 3. Testing for Differential Exon Usage

The package compares a full model (including the condition effect on exon usage) against a reduced null model.

```R
# Perform the likelihood ratio test
dxd <- testForDEU(dxd)

# Estimate relative exon usage fold changes
dxd <- estimateExonFoldChanges(dxd, fitExpToVar = "condition")

# Extract results into a readable DataFrame
dxr <- DEXSeqResults(dxd)
```

### 4. Handling Complex Designs

For experiments with blocking factors (e.g., batch effects or library types), specify explicit full and reduced formulae.

```R
formulaFullModel <- ~ sample + exon + batch:exon + condition:exon
formulaReducedModel <- ~ sample + exon + batch:exon

dxd <- estimateDispersions(dxd, formula = formulaFullModel)
dxd <- testForDEU(dxd, fullModel = formulaFullModel, reducedModel = formulaReducedModel)
```

## Visualization and Reporting

DEXSeq provides specialized plotting functions to visualize exon expression patterns and transcript models.

*   **MA Plot**: `plotMA(dxr, cex=0.8)` visualizes the relationship between mean expression and log2 fold change.
*   **Gene-level Plot**: `plotDEXSeq(dxr, "GeneID", legend=TRUE, displayTranscripts=TRUE)` shows fitted expression or normalized counts for all exons in a gene.
*   **Splicing Plot**: Use `splicing=TRUE` in `plotDEXSeq` to remove overall gene expression changes and focus purely on relative exon usage.
*   **HTML Report**: `DEXSeqHTML(dxr, FDR=0.1)` generates an interactive summary of significant results.

## Key Functions and Accessors

*   `DEXSeq()`: A wrapper function that runs the entire standard pipeline (normalization, dispersion, testing) in one command.
*   `perGeneQValue()`: Aggregates exon-level p-values to provide a single FDR-corrected value per gene.
*   `featureCounts()`: Accesses the raw counts for the specific exonic regions.
*   `findOverlaps()` / `subsetByOverlaps()`: Useful for filtering results based on specific genomic coordinates.

## Best Practices

*   **Filtering**: For large datasets, filter out lowly expressed exons or genes before running `testForDEU` to improve computational speed and statistical power.
*   **Parallelization**: Use `BiocParallel` for heavy computations. Most main functions accept a `BPPARAM` argument (e.g., `BPPARAM = MultiCoreParam(4)`).
*   **Annotation**: Ensure your GTF/GFF annotation is "flattened" (collapsed) so that overlapping exon parts from different transcripts are treated as distinct counting bins.

## Reference documentation

- [DEXSeq](./references/DEXSeq.md)