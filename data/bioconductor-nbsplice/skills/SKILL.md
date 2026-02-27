---
name: bioconductor-nbsplice
description: NBSplice detects differential splicing by modeling isoform expression counts using Negative Binomial generalized linear models. Use when user asks to identify differentially spliced genes, analyze isoform-level expression changes, or visualize relative isoform proportions between experimental conditions.
homepage: https://bioconductor.org/packages/3.8/bioc/html/NBSplice.html
---


# bioconductor-nbsplice

## Overview

NBSplice is a Bioconductor package designed to detect differential splicing (DS) by modeling isoform expression counts. It uses Negative Binomial generalized linear models to infer changes in the relative proportion of isoforms for each gene. Unlike tools that focus on exon usage, NBSplice operates at the transcript/isoform level, providing both gene-level significance (via Simes test) and isoform-specific changes.

## Typical Workflow

### 1. Data Preparation
NBSplice requires three primary inputs:
- **isoCounts**: A matrix of un-normalized isoform counts (e.g., from Kallisto or RSEM).
- **geneIso**: A data frame with two columns: `isoform_id` and `gene_id`.
- **designMatrix**: A data frame describing experimental samples.
- **colName**: The name of the column in `designMatrix` containing the condition factor (e.g., "condition").

```r
library(NBSplice)

# Load example data or provide your own
data(isoCounts, package="NBSplice")
data(geneIso, package="NBSplice")
data(designMatrix, package="NBSplice")

colName <- "condition"
```

### 2. Creating the IsoDataSet
The `IsoDataSet` object centralizes counts, metadata, and the model formula.

```r
myIsoDataSet <- IsoDataSet(isoCounts, designMatrix, colName, geneIso)

# Inspect the object
show(myIsoDataSet)
```

### 3. Filtering Low-Expressed Isoforms
Filtering is critical to reduce noise and improve model convergence. NBSplice filters based on both absolute counts (CPM) and relative expression (ratio).

```r
# ratioThres: minimum relative expression in all samples
# countThres: minimum mean CPM across conditions
myIsoDataSet <- buildLowExpIdx(myIsoDataSet, colName, ratioThres = 0.01, countThres = 1)
```

### 4. Differential Splicing Test
The `NBTest` function performs the GLM fitting and hypothesis testing.

```r
# test="F" uses the Wald test based on F-statistic
myDSResults <- NBTest(myIsoDataSet, colName, test="F")
```

## Results Exploration

### Extracting Significant Results
Use `GetDSResults` for a table of significant isoforms/genes and `GetDSGenes` for a list of gene IDs.

```r
# Get results for genes with adjusted p-value < 0.05
sigResults <- GetDSResults(myDSResults, adjusted = TRUE, p.value = 0.05)

# Get names of differentially spliced genes
dsGenes <- GetDSGenes(myDSResults)
```

### Visualizing Results
NBSplice provides several plotting functions that return `ggplot2` objects:

- **Global Ratios**: `plotRatiosDisp(myDSResults)` shows isoform relative expression between conditions.
- **Volcano Plot**: `plotVolcano(myDSResults)` relates significance to the magnitude of change.
- **Gene-Specific Barplot**: `plotGeneResults(myDSResults, geneID)` visualizes isoform proportions for a specific gene.

```r
# Plot specific gene results
plotGeneResults(myDSResults, dsGenes[1])
```

## Key Functions Reference

| Function | Description |
| :--- | :--- |
| `IsoDataSet()` | Constructor for the main data container. |
| `isoCounts(obj, CPM=TRUE)` | Accessor for counts, optionally converted to CPM. |
| `buildLowExpIdx()` | Identifies and flags low-expressed isoforms. |
| `NBTest()` | Main function for differential splicing statistical testing. |
| `results(obj, filter=TRUE)` | Extracts the full results table; `filter=TRUE` hides non-converged/low-exp rows. |
| `GetGeneResults()` | Extracts results for a specific gene ID. |

## Reference documentation

- [NBSplice-vignette](./references/NBSplice-vignette.md)