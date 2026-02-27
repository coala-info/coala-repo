---
name: bioconductor-tin
description: This tool quantifies transcriptome instability by calculating aberrant exon usage scores from exon-level microarray expression data. Use when user asks to calculate TIN scores, identify aberrant splicing patterns, or correlate transcriptome instability with splicing factor expression and gene sets.
homepage: https://bioconductor.org/packages/release/bioc/html/TIN.html
---


# bioconductor-tin

name: bioconductor-tin
description: Transcriptome instability analysis using exon-level microarray expression profiles. Use this skill to calculate aberrant exon usage (TIN score), analyze correlations between splicing factor expression and transcriptome instability, and perform gene set enrichment analysis for splicing discrepancies.

## Overview

The `TIN` (Transcriptome Instability) package provides tools to quantify transcriptome instability from exon-level expression data (typically Affymetrix Human Exon Arrays). It identifies aberrant exon usage—splicing patterns that deviate from the norm—and correlates these events with the expression levels of splicing factors or specific gene sets. This is particularly useful in cancer research to identify samples with high splicing dysregulation.

## Core Workflow

### 1. Data Preparation and Loading
The package requires raw CEL files for FIRMA analysis and preprocessed gene-level expression values.

```r
library(TIN)

# Load built-in annotation and gene sets
data(splicingFactors)  # List of ~280 splicing factor genes
data(geneSets)         # GO gene sets
data(geneAnnotation)   # Mapping between symbols and transcript IDs
```

### 2. Calculating FIRMA Scores and Gene Summaries
FIRMA (Fine-mappIng of Research MicroArray) scores represent alternative splicing activity.

```r
# Perform FIRMA analysis (requires aroma.affymetrix setup)
# Returns a data.frame of log2 FIRMA scores
fs <- firmaAnalysis(useToyData = TRUE) 

# Read gene-level expression (tab-separated file)
# Rows: Transcript cluster IDs; Columns: Sample names
gs <- readGeneSummaries(useToyData = TRUE)
```

### 3. Quantifying Transcriptome Instability (TIN)
The `aberrantExonUsage` function calculates the TIN score for each sample.

```r
# Calculate aberrant exon usage
# threshold: top percentile of global FIRMA scores (default 1.0)
tra <- aberrantExonUsage(1.0, fs)

# 'tra' contains the sample-wise TIN scores
# 'aberrantExons' (created in global env) contains lists of high/low aberrant probe sets
```

### 4. Correlation Analysis
Analyze how transcriptome instability relates to the expression of splicing factors or other gene sets.

```r
# Permute FIRMA scores to establish background
aberrantExonsPerms <- probesetPermutations(fs, quantiles)

# Correlation with splicing factor expression
corr <- correlation(splicingFactors, gs, tra)

# Correlation with general gene sets (e.g., GO terms)
gsc <- geneSetCorrelation(geneSets, geneAnnotation, gs, tra, 100)
```

## Visualization

The package includes four primary plotting functions to interpret results:

*   **Cluster Plot**: Hierarchical clustering of samples based on splicing factor expression.
    ```r
    clusterPlot(gs, tra, "euclidean", "complete", "TIN-cluster.pdf")
    ```
*   **Scatter Plot**: Visualizes relative amounts of aberrant exon usage per sample compared to permutations.
    ```r
    scatterPlot("TIN-scatter.pdf", TRUE, aberrantExons, aberrantExonsPerms)
    ```
*   **Correlation Plot**: Shows the number of splicing factors significantly correlated with TIN scores.
    ```r
    correlationPlot("TIN-correlation.pdf", tra, gs, splicingFactors, 1000, 1000)
    ```
*   **Positive/Negative Correlation Plot**: Compares counts of positively vs. negatively correlated splicing factors.
    ```r
    posNegCorrPlot("TIN-posNegCorrPlot.pdf", tra, gs, splicingFactors, 1000, 1000)
    ```

## Tips for Success
*   **Input IDs**: Ensure gene-level expression data uses Affymetrix transcript cluster identifiers as row names to match the internal `geneAnnotation`.
*   **FIRMA Requirements**: The `firmaAnalysis` function is a wrapper for `aroma.affymetrix`. Ensure the directory structure follows the `aroma` project conventions (e.g., `rawData/`, `annotationData/`).
*   **Thresholding**: The percentile threshold in `aberrantExonUsage` significantly impacts the TIN score sensitivity; 1.0 (top 1%) is the standard starting point.

## Reference documentation
- [TIN](./references/TIN.md)