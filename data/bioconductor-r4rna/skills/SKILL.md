---
name: bioconductor-r4rna
description: This tool provides a framework for analyzing and visualizing RNA secondary structures and comparative sequence data. Use when user asks to read RNA structure formats, create arc diagrams, compare multiple structures, or visualize structures alongside multiple sequence alignments with covariation and conservation annotations.
homepage: https://bioconductor.org/packages/release/bioc/html/R4RNA.html
---


# bioconductor-r4rna

name: bioconductor-r4rna
description: Analysis and visualization of RNA secondary structure and comparative sequence analysis. Use this skill to read RNA structure formats (dot-bracket, connect, bpseq, helix), create arc diagrams, compare multiple structures, and visualize structures alongside multiple sequence alignments (MSA) with covariation and conservation annotations.

# bioconductor-r4rna

## Overview
The `R4RNA` package provides a framework for RNA secondary structure analysis in R. It excels at creating publication-quality arc diagrams and visualizing the relationship between sequence conservation, covariation, and structural base-pairing. It uses a "helix" data frame format as its core data structure, where each row represents a base-pair or a helical stack.

## Core Workflows

### 1. Reading RNA Structure Data
The package supports several common formats. Use `expandHelix()` to break down multi-base helices into individual base-pairs for finer control.

```R
library(R4RNA)

# Read TRANSAT helix format
transat <- readHelix(system.file("extdata", "helix.txt", package = "R4RNA"))

# Read Vienna/Dot-bracket format
known <- readVienna(system.file("extdata", "vienna.txt", package = "R4RNA"))

# Expand to base-pair level (optional but recommended for filtering/coloring)
known <- expandHelix(known)
```

### 2. Basic and Comparative Visualization
Use `plotHelix` for single structures and `plotDoubleHelix` to compare two structures (one above the line, one below).

```R
# Single structure arc diagram
plotHelix(known, line = TRUE, arrow = TRUE)

# Compare two structures (e.g., Predicted vs Known)
plotDoubleHelix(transat, known, line = TRUE, arrow = TRUE)
```

### 3. Filtering and Coloring
Helices are data frames; you can filter them using standard R indexing. Use `colourByValue` to map numerical scores (like p-values) to colors.

```R
# Filter by p-value
transat <- transat[which(transat$value <= 1e-3), ]

# Color by value (log scale)
transat$col <- colourByValue(transat, log = TRUE)

# Plot with legend
plotDoubleHelix(transat, known)
legend("topright", legend = attr(transat$col, "legend"), fill = attr(transat$col, "fill"), title = "P-values")
```

### 4. Overlap Analysis
To specifically highlight concordance, `plotOverlapHelix` shows shared base-pairs above the line and discrepancies below.

```R
# Shared pairs above, predicted-only below, known-only in black above
plotOverlapHelix(transat, known, line = TRUE, arrow = TRUE)
```

### 5. Multiple Sequence Alignment (MSA) Integration
Visualize structures on top of alignments to see evolutionary conservation.

```R
library(Biostrings)
fasta <- as.character(readBStringSet(system.file("extdata", "fasta.txt", package = "R4RNA")))

# Plot structure on top of MSA
plotCovariance(fasta, known, cex = 0.5)

# Color arcs by covariation metrics
col_covar <- colourByCovariation(known, fasta, get = TRUE)
plotCovariance(fasta, col_covar, grid = TRUE)
```

## Advanced Coloring Methods
- `colourByConservation`: Colors based on how well the base-pair is conserved across the alignment.
- `colourByCanonical`: Colors based on the percentage of sequences that can form a canonical (AU, GC, GU) pair at that position.
- `colourByUnknottedGroups`: Identifies and colors pseudoknots by separating them into non-conflicting groups.

## Tips
- **Conflicting Arcs**: When plotting on an MSA, arcs that share a base (conflicts) can be messy. Use `conflict.col = "grey"` in `plotCovariance` to de-emphasize them.
- **Custom Palettes**: Most coloring functions accept a `palette` argument (e.g., `c("green", "blue", "red")`).
- **Legend Data**: Coloring functions return the colors, but also store legend information in attributes (`attr(col, "legend")` and `attr(col, "fill")`).

## Reference documentation
- [R4RNA: A R package for RNA visualization and analysis](./references/R4RNA.md)