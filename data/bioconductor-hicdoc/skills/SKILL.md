---
name: bioconductor-hicdoc
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/HiCDOC.html
---

# bioconductor-hicdoc

name: bioconductor-hicdoc
description: Detect significant A/B compartment changes in Hi-C data with replicates. Use this skill when analyzing Hi-C interaction matrices to normalize technical/biological biases, predict genomic compartments, and identify differential compartmentalization between experimental conditions.

# bioconductor-hicdoc

## Overview

HiCDOC is an R/Bioconductor package designed for the comparative analysis of Hi-C data. It specializes in detecting A/B compartment changes across multiple conditions while accounting for biological and technical replicates. The package provides a complete pipeline from data import and multi-step normalization to unsupervised learning for compartment prediction and statistical testing for significant differences.

## Workflow and Core Functions

### 1. Data Import
HiCDOC supports multiple Hi-C formats. All import functions return a `HiCDOCDataSet`.

*   **Tabular (.tsv):** `HiCDOCDataSetFromTabular('data.tsv')`
*   **Cooler (.cool/.mcool):** 
    ```r
    HiCDOCDataSetFromCool(paths, replicates, conditions, binSize = 500000)
    ```
*   **Juicer (.hic):**
    ```r
    HiCDOCDataSetFromHiC(paths, replicates, conditions, binSize = 500000)
    ```
*   **HiC-Pro (.matrix/.bed):**
    ```r
    HiCDOCDataSetFromHiCPro(matrixPaths, bedPaths, replicates, conditions)
    ```

### 2. The HiCDOC Pipeline
You can run the entire analysis with a single wrapper or execute steps individually for more control.

**One-liner:**
```r
result <- HiCDOC(hic.experiment)
```

**Step-by-step execution:**
1.  **Filtering:**
    *   `filterSmallChromosomes(obj, threshold = 100)`: Remove short chromosomes.
    *   `filterSparseReplicates(obj, threshold = 0.3)`: Remove replicates with low interaction density.
    *   `filterWeakPositions(obj, threshold = 1)`: Remove bins with low average interactions.
2.  **Normalization:**
    *   `normalizeTechnicalBiases(obj)`: Inter-matrix normalization (cyclic loess). *Tip: Use `cycleLoessSpan` for large datasets to save memory.*
    *   `normalizeBiologicalBiases(obj)`: Intra-matrix normalization (Knight-Ruiz balancing).
    *   `normalizeDistanceEffect(obj)`: MD loess normalization for genomic distance.
3.  **Prediction:**
    *   `detectCompartments(obj)`: Uses constrained K-means to assign A/B status and detect significant changes.

### 3. Extracting Results
Use these accessors to retrieve processed data:
*   `compartments(obj)`: Get A/B assignments for each bin.
*   `concordances(obj)`: Get confidence measures for assignments.
*   `differences(obj)`: Get significant compartment changes between conditions (p-values and directions like A->B).

### 4. Visualization
*   `plotInteractions(obj, chromosome)`: Heatmap of interaction matrices.
*   `plotCompartmentChanges(obj, chromosome)`: Visualize A/B status and significant shifts.
*   `plotCentroids(obj, chromosome)`: PCA plot of compartment clusters.
*   `plotDistanceEffect(obj)`: Decay of interactions over distance.
*   `plotSelfInteractionRatios(obj, chromosome)`: Boxplots used for A/B classification validation.

## Sanity Checks
HiCDOC performs internal validation:
*   **PCA Check:** Ensures centroids of the same compartment cluster together (expects >75% inertia on PC1).
*   **Assignment Check:** Uses self-interaction ratios to distinguish A from B via Wilcoxon test.
*   **Note:** Chromosomes failing these checks are automatically filtered from results unless specified otherwise.

## Reference documentation
- [HiCDOC Vignette (Rmd)](./references/HiCDOC.Rmd)
- [HiCDOC Vignette (Markdown)](./references/HiCDOC.md)