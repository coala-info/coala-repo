---
name: bioconductor-miaviz
description: "This tool provides visualization functions for microbiome data stored in TreeSummarizedExperiment objects. Use when user asks to create abundance plots, visualize prevalence, plot phylogenetic trees, or generate time-series trajectories for microbial communities."
homepage: https://bioconductor.org/packages/release/bioc/html/miaViz.html
---


# bioconductor-miaviz

name: bioconductor-miaviz
description: Visualization of microbiome data using the miaViz R package. Use this skill to create abundance plots, prevalence plots, phylogenetic tree visualizations, and time-series trajectories for TreeSummarizedExperiment objects.

## Overview

The `miaViz` package provides specialized plotting functions for microbiome research, designed to work seamlessly with the `mia` framework and `TreeSummarizedExperiment` objects. It extends the `scater` and `ggplot2` ecosystems to handle taxonomic hierarchies, phylogenetic trees, and longitudinal microbiome data.

## Core Workflows

### 1. Abundance Plotting
Use `plotAbundance` to visualize taxonomic composition. It is most effective when data is first transformed (e.g., to relative abundance) and agglomerated to a specific rank.

```r
library(miaViz)
library(mia)

# Transform and agglomerate
tse <- transformAssay(tse, method = "relabundance")
tse_phylum <- agglomerateByRank(tse, rank = "Phylum")

# Plot relative abundance by Phylum
plotAbundance(tse_phylum, assay.type = "relabundance")

# Plot specific features alongside metadata
plotAbundance(tse, rank = "Phylum", features = "SampleType", assay.type = "relabundance")
```

### 2. Prevalence and Landscape Plots
Visualize how common taxa are across samples and abundance thresholds.

*   **`plotRowPrevalence`**: Shows prevalence across different detection thresholds.
*   **`plotPrevalentAbundance`**: Relationship between mean abundance and prevalence.
*   **`plotPrevalence`**: Number of samples/prevalence across thresholds.

```r
plotRowPrevalence(tse, rank = "Phylum", detections = c(0, 0.001, 0.01, 0.1))
plotPrevalentAbundance(tse, rank = "Family", colour.by = "Phylum") + scale_x_log10()
```

### 3. Phylogenetic Tree Visualization
`plotRowTree` allows for decorating trees with data from `rowData` or `assay` data.

*   **Tip decoration**: Use `tip.colour.by` and `tip.size.by`.
*   **Edge decoration**: Use `edge.colour.by`.
*   **Labels**: Use `show.label = TRUE` or a vector of specific labels.

```r
# Plot top 100 taxa on a tree
top_taxa <- getTop(tse, top = 100)
plotRowTree(tse[top_taxa,], 
            tip.colour.by = "RelativeAbundance", 
            edge.colour.by = "Phylum",
            show.label = TRUE)
```

### 4. Longitudinal and Series Data
Use `plotSeries` to visualize changes over time.

```r
plotSeries(tse, 
           time.col = "DAYS", 
           features = c("Taxon1", "Taxon2"), 
           colour.by = "Group",
           assay.type = "relabundance")
```

### 5. Ordination Trajectories
To visualize how microbial communities shift over time in reduced dimension space (e.g., PCoA), combine `plotReducedDim` with `geom_path`.

```r
# Assuming PCoA is already calculated in reducedDim(tse)
p <- plotReducedDim(tse, dimred = "PCoA_BC")
p + geom_path(aes(x = X1, y = X2, group = subject), 
              data = as.data.frame(cbind(reducedDim(tse), colData(tse))),
              arrow = arrow(length = unit(0.1, "inches")))
```

## Tips and Best Practices
*   **Agglomeration**: Always consider `agglomerateByRank` before plotting abundance to avoid overcrowded legends.
*   **Assay Selection**: Ensure the `assay.type` argument matches the data you intend to plot (e.g., "counts" vs "relabundance").
*   **Integration**: `miaViz` returns `ggplot` objects. You can further customize them using standard `ggplot2` functions (`+ theme()`, `+ labs()`, etc.) or combine them using the `patchwork` package.
*   **Large Trees**: Plotting trees with thousands of nodes is computationally expensive and visually uninformative. Subset to "top taxa" or specific clades before using `plotRowTree`.

## Reference documentation
- [miaViz](./references/miaViz.md)