---
name: bioconductor-genomicsupersignature
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GenomicSuperSignature.html
---

# bioconductor-genomicsupersignature

## Overview

The `GenomicSuperSignature` package provides a framework to interpret new transcriptomic datasets by projecting them onto a pre-computed index of "Replicable Axes of Variation" (RAVs). These RAVs are derived from thousands of public experiments and are annotated with GSEA results and MeSH terms. Instead of performing de novo analysis, users can "validate" their data against this index to identify which established biological signals are present in their samples.

## Core Workflow

### 1. Setup and Model Loading
The package relies on pre-built `RAVmodel` objects. There are two primary versions: `C2` (MSigDB C2 pathways) and `PLIERpriors` (blood-associated gene sets).

```r
library(GenomicSuperSignature)

# Download and load a model (cached for future use)
RAVmodel <- getModel("C2", load = TRUE)
# Or for blood/B-cell data:
# RAVmodel <- getModel("PLIERpriors", load = TRUE)
```

### 2. Validating New Datasets
The `validate` function calculates a score representing how well the principal components (PCs) of your dataset match the RAVs in the model.

```r
# Input can be a matrix (genes as symbols in rows), ExpressionSet, or SummarizedExperiment
val_results <- validate(my_dataset, RAVmodel)

# View top validated RAVs
head(val_results)
```

### 3. Interpreting Results
Once you identify high-scoring RAVs, use the following functions to extract biological meaning:

*   **Visualization**: Use `heatmapTable` to see validation scores and silhouette widths (a quality measure).
    ```r
    heatmapTable(val_results, RAVmodel, num.out = 5, swCutoff = 0)
    ```
*   **Interactive Exploration**: `plotValidate(val_results)` creates a scatter plot of validation scores vs. silhouette widths.
*   **Extracting Indices**: Get the RAV numbers for the top hits.
    ```r
    validated_ind <- validatedSignatures(val_results, RAVmodel, num.out = 3, swCutoff = 0, indexOnly = TRUE)
    ```

### 4. Functional Annotation
Access the metadata associated with specific RAVs:

*   **GSEA**: See enriched pathways for a specific RAV.
    ```r
    annotateRAV(RAVmodel, ind = 1139)
    # Or for multiple RAVs:
    subsetEnrichedPathways(RAVmodel, ind = validated_ind, n = 5)
    ```
*   **Wordclouds**: Visualize MeSH terms associated with the studies that formed the RAV.
    ```r
    drawWordcloud(RAVmodel, ind = 1139)
    ```
*   **Keyword Search**: Find RAVs associated with a specific biological term.
    ```r
    findSignature(RAVmodel, "Bcell")
    ```

### 5. Identifying Related Studies
Find which public studies contributed to a specific RAV to find comparable literature.

```r
findStudiesInCluster(RAVmodel, ind = 1139, studyTitle = TRUE)
```

## Tips for Success
*   **Gene Symbols**: Ensure your input dataset uses Gene Symbols as row names. The models are built using 13,934 common genes.
*   **Silhouette Width (sw)**: While the validation score indicates relevance, a positive silhouette width suggests the RAV is a cohesive, well-defined cluster of PCs from the training data. Focus on RAVs where `sw > 0`.
*   **PC Selection**: By default, `validate` checks the top 8 PCs of your dataset. You can adjust this if you suspect biological signal is in lower PCs.

## Reference documentation
- [Structure and content of RAVmodel](./references/Contents.md)
- [GenomicSuperSignature - Quickstart](./references/Quickstart.md)