---
name: bioconductor-cetf
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CeTF.html
---

# bioconductor-cetf

name: bioconductor-cetf
description: Co-expression network analysis using Regulatory Impact Factors (RIF) and Partial Correlation and Information Theory (PCIT). Use this skill to identify critical transcription factors (TFs) and reconstruct gene co-expression networks from transcriptomic data (RNA-seq, Microarray, or scRNA-seq) across two biological conditions.

## Overview
The `CeTF` package implements two primary algorithms for systems biology:
1.  **RIF (Regulatory Impact Factors):** Identifies key transcription factors that regulate differentially expressed (DE) genes between two conditions.
2.  **PCIT (Partial Correlation and Information Theory):** Determines meaningful co-expression edges by comparing partial correlations against a local information theory threshold.

The package is designed to integrate these methods to find TFs that may not be differentially expressed themselves but show significant changes in co-expression wiring with target genes.

## Core Workflow

### 1. Data Preparation
Input data should be a count matrix or normalized expression matrix. Samples must be grouped into two conditions (e.g., Control vs. Treatment).

```r
library(CeTF)
library(SummarizedExperiment)

# Load your data (e.g., counts matrix)
# Ensure columns are ordered by condition
# Load TF list (CeTF provides a human TF list)
data("TFs") 
```

### 2. Integrated Analysis
The `runAnalysis` function is the primary wrapper that performs differential expression, RIF, and PCIT in a single execution.

```r
out <- runAnalysis(mat = counts,
                   conditions = c("untrt", "trt"),
                   lfc = 2,
                   padj = 0.05,
                   TFs = TFs,
                   nSamples1 = 4,
                   nSamples2 = 4,
                   tolType = "mean",
                   diffMethod = "Reverter",
                   data.type = "counts")
```

### 3. Step-by-Step Execution
If more control is needed, functions can be called individually:
*   `expDiff()`: Identify differentially expressed genes.
*   `normExp()`: Normalize data (TPM/Log2).
*   `RIF()`: Calculate RIF1 and RIF2 scores for transcription factors.
*   `PCIT()`: Generate significant co-expression networks.

### 4. Accessing Results
The `CeTF` object stores results in specific slots accessible via helper functions:
*   `getData(out)`: Retrieve expression matrices.
*   `getDE(out)`: Retrieve DE genes and TFs.
*   `NetworkData(out, "network1")`: Get the adjacency list for condition 1.
*   `NetworkData(out, "keytfs")`: Get the top-ranked TFs based on RIF scores.

## Visualization and Enrichment

### Network and Smear Plots
*   `SmearPlot(out, type = "DE")`: Visualize DE genes and TFs.
*   `netConditionsPlot(out)`: Compare network topology between conditions.
*   `RIFPlot(out, type = "RIF")`: Plot RIF1 vs RIF2 scores.

### Functional Enrichment
`CeTF` integrates with `clusterProfiler` and `org.Db` packages for enrichment:

```r
# Group GO (count-based)
cond1_go <- getGroupGO(genes = my_genes, ont = "BP", keyType = "ENSEMBL", annoPkg = org.Hs.eg.db)

# Statistical Enrichment
enrich <- getEnrich(genes = my_genes, organismDB = org.Hs.eg.db, keyType = 'ENSEMBL', ont = 'BP')

# Visualization
enrichPlot(res = enrich$results, type = "dot")
heatPlot(res = enrich$results, diff = getDE(out, "all"))
```

### Integrated Network Plots
Use `netGOTFPlot` to create a unified view of TFs, their target genes, and the biological pathways they enrich.
*   `groupBy = 'pathways'`: Clusters the network by GO terms.
*   `groupBy = 'TFs'`: Clusters the network by specific regulators.

## Tips for Success
*   **TF Lists:** While `data("TFs")` provides human TFs, you must provide your own character vector of gene IDs for other organisms.
*   **Memory Management:** PCIT is computationally intensive for large gene sets. It is highly recommended to filter for informative (DE) genes before running PCIT.
*   **Nomenclature:** Ensure your gene IDs (ENSEMBL, SYMBOL, etc.) match between your expression matrix, the TF list, and the `org.Db` annotation package used for enrichment.

## Reference documentation
- [Analyzing Regulatory Impact Factors and Partial Correlation and Information Theory](./references/CeTF.md)