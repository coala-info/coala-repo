---
name: bioconductor-idiogram
description: This tool plots genomic data integrated with cytogenetic banding patterns for human, mouse, and rat genomes. Use when user asks to visualize gene expression or SNP data alongside chromosomal regions, generate idiograms, or interactively identify genes within specific cytogenetic bands.
homepage: https://bioconductor.org/packages/release/bioc/html/idiogram.html
---


# bioconductor-idiogram

name: bioconductor-idiogram
description: Plotting genomic data integrated with cytogenetic banding patterns (idiograms) for human, mouse, and rat genomes. Use this skill to visualize gene expression, SNP data, or other genomic features alongside chromosomal regions, and to interactively identify genes within specific cytogenetic bands.

## Overview

The `idiogram` package maps feature identifiers (like Affymetrix IDs) to genomic locations to display data alongside cytogenetic bands. It relies on `chromLoc` annotation objects created by the `annotate` package. It supports vector data via `plot` calls and matrix data via `maplot` or `image` calls within the idiogram framework.

## Core Workflow

### 1. Prepare Annotation Data
Before plotting, you must create a `chromLocation` object for your specific platform.

```r
library(idiogram)
library(annotate)
# Example for human hu6800 chips
hu.chr <- buildChromLocation("hu6800")
```

### 2. Prepare Genomic Data
Data must be a named vector or a matrix with row names. These names **must** match the gene identifiers in the `chromLocation` object.

```r
# Example: Vector of expression values
ex <- golubTrain@exprs[,1]
# Ensure names are set
names(ex) <- rownames(golubTrain@exprs)
```

### 3. Generate Idiogram Plots
Use the `idiogram()` function to create the visualization.

- **Basic Plot:** `idiogram(data, chromLoc, chr="1")`
- **Customization:** Pass standard plotting arguments like `col`, `pch`, and `cex`.
- **Axis Control:** Arguments `cex.axis`, `col.axis`, and `font.axis` are intercepted and applied specifically to the cytogenetic margin. Other axis parameters should be set via `par()`.

```r
# Plotting chromosome 1 with conditional coloring
colors <- ifelse(ex > 10000, "red", "black")
idiogram(ex, hu.chr, chr="1", col=colors, pch=19)
```

### 4. Interactive Selection
Use `idiograb()` to identify genes within a specific region of an existing idiogram plot.

```r
# After calling idiogram(), call idiograb
# Click two points on the plot to define a rectangular region
selected_genes <- idiograb(idiogram_call, brush="red")
```

## Advanced Usage

### Integration with limma
When working with differential expression results from `limma`, use `midiogram` to visualize log-fold changes (M-values).

```r
# Assuming 'fit' is a limma object and 'top' is from topTable
data <- top$logFC
names(data) <- rownames(top)

# Highlight significant changes
colors <- rep("gray", length(data))
colors[data > 1] <- "red"
colors[data < -1] <- "blue"

midiogram(data, hu.chr, xlim=c(-5, 5), col=colors, pch=20)
```

## Tips and Constraints
- **Supported Species:** Currently includes cytogenetic data for human, mouse, and rat.
- **Data Alignment:** If the `names` attribute is missing or does not match the annotation package, the function will fail to map data to the chromosome.
- **Margin Handling:** The package manages the layout to fit the idiogram in the margin; avoid complex `layout()` or `mfrow` settings unless using `midiogram`.

## Reference documentation
- [idiogram package](./references/idiogram.md)