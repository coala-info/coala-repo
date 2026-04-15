---
name: bioconductor-genarise
description: The genArise package provides a structured workflow for analyzing dual-channel microarray data to identify differentially expressed genes. Use when user asks to perform background correction, normalize intensity ratios, filter low-intensity spots, handle replicates, or calculate Z-scores for microarray data.
homepage: https://bioconductor.org/packages/release/bioc/html/genArise.html
---

# bioconductor-genarise

## Overview
The `genArise` package provides a structured workflow for analyzing dual-channel microarray data. It transforms raw intensity measurements into normalized ratios to identify genes that are significantly differentially expressed. The package supports background correction, various normalization methods (global and grid-based), intensity filtering, and replicate handling.

## Core Workflow

### 1. Data Loading
Data is imported into a `Spot` object. You must specify the column indices for intensities and identifiers.

```r
library(genArise)
# Example: Cy3=1, Cy5=2, BgCy3=3, BgCy5=4, Ids=5
my.spot <- read.spot(file.name = "data.txt", cy3 = 1, cy5 = 2, 
                     bg.cy3 = 3, bg.cy5 = 4, ids = 5, 
                     header = FALSE, sep = "\t")

# To use the built-in example dataset
data(Simon)
```

### 2. Diagnostic Visualization
Before processing, visualize the raw data using image plots or scatter plots.

```r
# Image plot of log2 ratios (M values)
datos <- attr(Simon, "spotData")
M <- log(datos$Cy3, 2) - log(datos$Cy5, 2)
imageLimma(z = M, row = 23, column = 24, meta.row = 2, meta.column = 2)

# Standard plots
ri.plot(Simon)   # R (log ratio) vs I (mean intensity)
ma.plot(Simon)   # M (log ratio) vs A (average intensity)
cys.plot(Simon)  # log2(Cy3) vs log2(Cy5)
```

### 3. Preprocessing Transformations
Follow this typical sequence to clean the data:

*   **Background Correction**: Subtracts background from foreground intensities.
    ```r
    c.spot <- bg.correct(Simon)
    ```
*   **Normalization**: Choose between global or grid-specific loess normalization.
    ```r
    # Global
    n.spot <- global.norm(c.spot)
    # Grid-based (requires subgrid dimensions)
    n.spot <- grid.norm(c.spot, nr = 23, nc = 24)
    ```
*   **Filtering**: Remove spots with intensities not significantly above background.
    ```r
    f.spot <- filter.spot(n.spot)
    ```
*   **Replicate Handling**: Consolidate duplicate spots.
    ```r
    u.spot <- spotUnique(f.spot)   # Geometric mean
    u.spot <- alter.unique(f.spot) # Keeps extreme values
    u.spot <- meanUnique(f.spot)  # Mean, filters if diff > 20%
    ```

### 4. Identifying Differential Expression
Use the `Zscore` function to identify outliers in the distribution of log-ratios.

```r
# Calculate Z-scores (returns a DataSet object)
s.dataset <- Zscore(u.spot, type = "ri") # or type = "ma"

# Visualize results (color-coded by standard deviations)
Zscore.plot(s.dataset)
```

### 5. Functional Analysis (genMerge)
Perform over-representation analysis on identified gene sets. This requires external association and description files.

```r
# Extract IDs for study
study.ids <- unique(c(s.dataset$Id.up, s.dataset$Id.down))
write.table(study.ids, "study.genes", row.names = FALSE, col.names = FALSE)

# Run genMerge
genMerge(gene.association = "assoc.txt", 
         description = "desc.txt", 
         population.genes = "all_ids.txt", 
         study.genes = "study.genes", 
         output.file = "Results.txt")
```

## Tips and Best Practices
*   **Object Classes**: Most functions require a `Spot` class object. `Zscore` converts a `Spot` object into a `DataSet` object.
*   **Normalization Order**: If you eliminate spots (via filtering or unique handling) *before* normalization, you must use `global.norm` instead of `grid.norm`.
*   **GUI**: For interactive analysis, call `genArise()`. Note that `post.analysis` (combinatorial analysis) is primarily designed for projects managed via the GUI.
*   **Dye Swaps**: For dye-swapped experiments, use the GUI "Swap Analysis" or manually calculate cross-log-ratios $R = \log_2(\frac{Cy5_1 \cdot Cy3_2}{Cy3_1 \cdot Cy5_2})$.

## Reference documentation
- [The genArise Package](./references/genArise.md)