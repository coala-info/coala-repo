---
name: r-tcr
description: This tool analyzes and visualizes T-cell receptor repertoire data using the tcR R package. Use when user asks to parse immune receptor sequencing files, calculate repertoire diversity, analyze V(D)J gene usage, or compare clonotype overlap and sharedness.
homepage: https://cran.r-project.org/web/packages/tcr/index.html
---


# r-tcr

name: r-tcr
description: Analysis and visualization of T-cell receptor (TCR) repertoire data using the tcR R package. Use this skill when processing high-throughput sequencing data of immune receptors, calculating repertoire diversity, comparing clonotype sharedness, or performing gene usage analysis in R. Note: This package is deprecated in favor of 'immunarch'.

# r-tcr

## Overview
The `tcR` package is a comprehensive platform for the advanced analysis of T-cell receptor repertoire data. It provides tools for data data filtering, transformation, and visualization, specifically focusing on clonotype distributions, V(D)J gene usage, and repertoire overlap.

## Installation
To install the package from CRAN:
```r
install.packages("tcR")
```

## Core Workflows

### Data Loading
Load repertoire data from various formats (MiTCR, MiXCR, Migec, etc.):
```r
# Load a single file
tcr_data <- parse.file("path/to/data.txt", .type = "mitcr")

# Load a directory of files
tcr_list <- parse.folder("path/to/folder/", .type = "mitcr")
```

### Repertoire Statistics and Diversity
Calculate basic statistics and diversity indices (Chao1, Shannon, Inverse Simpson):
```r
# Basic clonal statistics
stats <- repseq.stats(tcr_list)

# Diversity estimation
div <- repDiversity(tcr_list, .method = "chao1")
vis.report.proportions(tcr_list[[1]])
```

### Gene Usage Analysis
Analyze and visualize V- and J-gene usage:
```r
# Calculate V-gene usage
v_usage <- geneUsage(tcr_list[[1]], .genes = HUMAN_TRBV)

# Plot gene usage
vis.gene.usage(tcr_list, HUMAN_TRBV)
```

### Repertoire Overlap and Sharedness
Compare clonotypes across different samples:
```r
# Calculate overlap (Jaccard index, Morisita's overlap, etc.)
imm_ov <- repOverlap(tcr_list, .method = "public")

# Visualize overlap heatmap
vis.heatmap(imm_ov)

# Find public clonotypes
public_clones <- get.public.resources(tcr_list)
```

### Spectratyping
Visualize the distribution of CDR3 lengths:
```r
spectratype(tcr_data, .genes = HUMAN_TRBV)
```

## Tips and Best Practices
- **Data Types**: Ensure the `.type` parameter in parsing functions matches your sequencer output (e.g., "mitcr", "mixcr", "migec", "tcrdb").
- **Gene Databases**: Use built-in constants like `HUMAN_TRBV`, `HUMAN_TRAV`, `MOUSE_TRBV` for gene usage functions.
- **Downsampling**: Use `resampling` to normalize samples with different sequencing depths before comparing diversity or overlap.
- **Deprecation Warning**: The `tcR` package is no longer actively supported. For new projects, it is highly recommended to transition to the `immunarch` package, which is the successor to `tcR`.

## Reference documentation
- [tcR Home Page](./references/home_page.md)