---
name: bioconductor-monalisa
description: bioconductor-monalisa identifies transcription factor motifs associated with experimental data using binned enrichment analysis or stability selection regression. Use when user asks to perform binned motif enrichment analysis, identify motifs using randomized Lasso stability selection, scan sequences for known motif hits, or analyze k-mer enrichments in genomic regions.
homepage: https://bioconductor.org/packages/release/bioc/html/monaLisa.html
---

# bioconductor-monalisa

name: bioconductor-monalisa
description: Motif analysis with Lisa (monaLisa) for identifying transcription factor (TF) motifs associated with experimental data (e.g., differential methylation, accessibility, or expression). Use this skill when you need to: (1) Perform binned motif enrichment analysis to find TFs driving observed changes, (2) Use Randomized Lasso Stability Selection for regression-based motif discovery, (3) Scan biological sequences for known motif hits, or (4) Analyze k-mer enrichments in genomic regions.

## Overview

The `monaLisa` package is designed to identify drivers of biological changes (like gene expression or chromatin accessibility) by analyzing sequence motifs. It offers two primary workflows:
1.  **Binned Motif Enrichment:** Groups genomic regions into bins based on a numerical value (e.g., log-fold change) and identifies motifs enriched in specific bins relative to others or a genomic background.
2.  **Stability Selection (Randomized Lasso):** A regression-based approach where motifs "compete" to explain a continuous response variable, providing a robust selection of relevant TFs while controlling for sequence biases like GC content.

## Core Workflows

### 1. Binned Motif Enrichment Analysis
This is the most common workflow for analyzing differential data.

```r
library(monaLisa)
library(JASPAR2020)
library(TFBSTools)

# 1. Bin your regions based on a numeric vector (e.g., delta methylation)
# binmode "equalN" ensures same number of regions per bin
bins <- bin(x = my_numeric_values, binmode = "equalN", nElement = 400)

# 2. Get PWMs (e.g., from JASPAR)
pwms <- getMatrixSet(JASPAR2020, opts = list(matrixtype = "PWM", tax_group = "vertebrates"))

# 3. Calculate enrichment (requires DNAStringSet of sequences)
se <- calcBinnedMotifEnrR(seqs = my_dna_seqs, bins = bins, pwmL = pwms)

# 4. Visualize results
plotMotifHeatmaps(x = se, which.plots = c("log2enr", "negLog10Padj"), 
                  cluster = TRUE, maxSig = 10)
```

### 2. Randomized Lasso Stability Selection
Use this when you want a regression model to identify motifs that best explain the variance in your data.

```r
# 1. Create a TFBS hit matrix (rows = regions, cols = motifs)
hits <- findMotifHits(query = pwms, subject = my_dna_seqs, min.score = 10.0)
TFBSmatrix <- unclass(table(factor(seqnames(hits), levels = seqlevels(hits)),
                            factor(hits$pwmname, levels = name(pwms))))

# 2. Run stability selection
# y is your response vector (e.g., log-fold change)
se_stab <- randLassoStabSel(x = TFBSmatrix, y = my_response_vector, cutoff = 0.8)

# 3. Visualize selection probabilities
plotSelectionProb(se_stab, directional = TRUE)
plotStabilityPaths(se_stab)
```

### 3. Finding Motif Hits
To simply annotate sequences with motif occurrences:

```r
res <- findMotifHits(query = pwms, subject = my_dna_seqs, min.score = 7.0)
# Returns a GRanges object with hit locations, scores, and motif names
```

## Key Functions and Tips

-   **`bin()`**: Use `minAbsX` to create a "no-change" bin around zero. Use `plotBinDensity()` to verify the distribution.
-   **`plotBinDiagnostics()`**: Always check for GC-content or dinucleotide frequency biases between bins before running enrichment.
-   **`calcBinnedMotifEnrR()`**: 
    -   By default, `background = "otherBins"`. 
    -   Use `background = "genome"` to compare a single set of sequences against a GC-matched genomic background.
-   **`motifSimilarity()`**: Calculate similarity between PWMs to cluster the heatmap by motif family rather than enrichment patterns.
-   **`calcBinnedKmerEnr()`**: Use this for an "unbiased" analysis if you suspect drivers not represented in known motif databases.

## Data Structures
-   **Input:** Typically `GRanges` (for regions) or `DNAStringSet` (for sequences).
-   **Output:** Most analysis functions return a `SummarizedExperiment`. 
    -   `assay(se, "log2enr")`: Motif enrichment values.
    -   `assay(se, "negLog10Padj")`: Significance values.
    -   `rowData(se)`: Information about the motifs.
    -   `colData(se)`: Information about the bins.

## Reference documentation
- [monaLisa - MOtif aNAlysis with Lisa](./references/monaLisa.md)
- [Regression Based Approach for Motif Selection](./references/selecting_motifs_with_randLassoStabSel.md)