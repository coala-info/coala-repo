---
name: bioconductor-genextender
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/geneXtendeR.html
---

# bioconductor-genextender

name: bioconductor-genextender
description: Functional annotation of ChIP-seq peak data using optimized gene extensions. Use this skill when you need to map genomic coordinates (peaks) to genes, explore gene-centric functional annotations, or optimize upstream/downstream extensions to capture regulatory elements and Gene Ontology (GO) terms.

# bioconductor-genextender

## Overview
`geneXtendeR` is a Bioconductor package designed for robust and precise functional annotation of ChIP-seq peaks (or any genomic coverage islands). Unlike standard "closest-feature" tools, it allows users to "extend" gene boundaries—specifically upstream of the TSS—to capture cis-regulatory elements like promoters and enhancers. This is particularly useful for epigenetic marks with broad enrichment patterns (e.g., H3K9me1, H3K27me3).

## Core Workflow

### 1. Installation and Setup
```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("geneXtendeR")
library(geneXtendeR)
library(rtracklayer) # Required for readGFF
```

### 2. Loading Data
You need a GTF file for the organism and a peak file.
*   **GTF:** Load using `readGFF()`.
*   **Peaks:** Must be a tab-delimited file with three columns: `chr`, `start`, `end`.

```R
# Load GTF
organism_gtf <- readGFF("path/to/species.gtf.gz")

# Load and format peaks
# This creates a "peaks.txt" file in the working directory for downstream functions
peaksInput("my_peaks.txt") 
```

### 3. Exploratory Visualization (Optimization)
Use these functions to determine the optimal upstream extension by observing how many peaks are captured at different distances.

*   `barChart(gtf, start, end, step)`: Raw counts of peaks-on-genes.
*   `linePlot(gtf, start, end, step)`: Rate of change in peak capture.
*   `hotspotPlot(allpeaks, sigpeaks, gtf, start, end, step)`: Ratio of significant peaks to total peaks across intervals.
*   `meanPeakLengthPlot(gtf, start, end, step)`: Visualizes average peak broadness across genomic intervals.

Example:
```R
# Check extensions from 0 to 10000bp in 500bp increments
linePlot(organism_gtf, 0, 10000, 500)
```

### 4. Functional Annotation
Once an extension (e.g., 2000bp) is chosen, use these functions to map peaks to genes.

*   **Standard Annotation:**
    ```R
    # Returns a data table of peaks mapped to genes
    annotated_data <- annotate(organism_gtf, 2000)
    ```

*   **Gene-Centric Summary:**
    ```R
    # Summarizes peaks per gene (Peaks-on-Gene-Body, Mean Distance, SD)
    gene_summary <- gene_annotate(organism_gtf, 2000)
    ```

*   **N-Dimensional Annotation:**
    ```R
    # Maps each peak to the 1st, 2nd, ..., nth closest genes
    # Useful for identifying potential distal regulatory targets
    expanded_map <- annotate_n(organism_gtf, 2000, n = 3)
    ```

*   **Gene Lookup:**
    ```R
    # Find all peaks associated with a specific gene
    gene_lookup(organism_gtf, "mTOR", n = 20, extension = 2000)
    ```

### 5. Gene Ontology (GO) Analysis
`geneXtendeR` provides tools to see which GO terms are gained or lost when changing extension levels.

```R
library(org.Hs.eg.db) # Use the appropriate org.db for your species
library(GO.db)

# Find GO terms associated with peaks captured between 2300bp and 2400bp
go_diff <- diffGO(organism_gtf, 2300, 2400, BP, org.Hs.eg.db)

# Visualizations
makeNetwork(organism_gtf, 2300, 2400, BP, org.Hs.eg.db)
makeWordCloud(organism_gtf, 2300, 2400, BP, org.Hs.eg.db)
```

## Key Tips
*   **Chromosome Naming:** The package internally converts X to 100, Y to 200, and MT to 300 for sorting.
*   **Distance Calculation:** Distance is calculated between the 5' end of a gene and the 3' end of a peak (or vice versa), whichever is smallest.
*   **Mean = 0:** In `gene_annotate()`, a mean distance of 0 indicates that all peaks associated with that gene are overlapping the gene body (including the extension).
*   **Robustness:** `gene_annotate()` is designed to be robust across different peak callers (e.g., SICER vs. MACS2) by focusing on gene-centric capture rather than exact coordinate overlaps.

## Reference documentation
- [geneXtendeR](./references/geneXtendeR.md)