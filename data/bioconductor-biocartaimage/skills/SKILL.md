---
name: bioconductor-biocartaimage
description: the package is to provide coordinates of genes on the BioCarta pathway images and to provide methods to add self-defined graphics to the genes of interest.
homepage: https://bioconductor.org/packages/release/bioc/html/BioCartaImage.html
---

# bioconductor-biocartaimage

name: bioconductor-biocartaimage
description: Use for visualizing and annotating BioCarta pathway images in R. This skill helps identify available pathways, map Entrez gene IDs to image coordinates, and create customized pathway diagrams with highlighted genes or complex graphical overlays. Use when you need to programmatically highlight genes of interest on BioCarta maps or add custom grid-based annotations to biological pathways.

## Overview
The `BioCartaImage` package provides a programmatic interface to the classic BioCarta pathway images. Since the original BioCarta website is no longer active, this package serves as a repository for pathway coordinates and images, allowing researchers to highlight genes of interest (using Entrez IDs) and add custom annotations using the `grid` graphics system. It maps genes to specific pixel coordinates (polygons) within the pathway diagrams.

## Core Workflows

### 1. Pathway Discovery and Metadata
List available pathways and identify which genes are mapped to them.
```r
library(BioCartaImage)

# List all available pathway IDs
ap <- all_pathways()
head(ap)

# Get metadata for a specific pathway (supports BioCarta or MSigDB IDs)
p <- get_pathway("h_RELAPathway")
p_msig <- get_pathway("BIOCARTA_RELA_PATHWAY")

# Retrieve Entrez IDs associated with a pathway
genes <- genes_in_pathway("h_RELAPathway")
```

### 2. Basic Visualization and Highlighting
Draw a pathway image and highlight specific genes with dashed colored borders.
```r
library(grid)

grid.newpage()
# Highlight gene 1387 (CBP) in yellow
grid.biocarta("h_RELAPathway", color = c("1387" = "yellow"))

# Adjusting position and size
grid.newpage()
grid.biocarta("h_RELAPathway", 
              x = unit(0.5, "npc"), 
              width = unit(10, "cm"),
              color = c("1387" = "red"))
```

### 3. Advanced Custom Annotations
For complex visualizations, create a `grob` (graphical object) and use `mark_gene` to overlay custom graphics.
```r
# 1. Create the base pathway grob
grob <- biocartaGrob("h_RELAPathway")

# 2. Add custom graphics to a specific gene
# The function receives x and y coordinates of the gene's polygon
grob_final <- mark_gene(grob, "1387", function(x, y) {
    # Find an anchor point (e.g., "left", "right", "top", "bottom", "center")
    pos <- pos_by_polygon(x, y, where = "left")
    
    # Return a grob to be added to the image
    pointsGrob(pos[1], pos[2], default.units = "native",
               pch = 16, gp = gpar(col = "blue"))
})

# 3. Render the annotated pathway
grid.newpage()
grid.draw(grob_final)
```

### 4. Capturing Grid Commands
If you prefer using standard `grid.*` functions instead of returning grobs, use `capture = TRUE`.
```r
grob_captured <- mark_gene(grob, "1387", function(x, y) {
    pos <- pos_by_polygon(x, y, where = "top")
    grid.text("Target Gene", pos[1], pos[2] + 5, 
              default.units = "native", gp = gpar(fontsize = 8))
}, capture = TRUE)
```

## Key Functions and Tips
- **ID Types**: Pathways use BioCarta IDs (e.g., `h_RELAPathway`) or MSigDB IDs (e.g., `BIOCARTA_RELA_PATHWAY`). Genes must be referenced by **Entrez IDs**.
- **Coordinate System**: The images use a "native" coordinate system based on pixels. When adding custom graphics inside `mark_gene`, always specify `default.units = "native"`.
- **Positioning**: `pos_by_polygon(x, y, where)` is the standard way to find anchor points on the gene's shape for clean annotation placement.
- **Aspect Ratio**: The aspect ratio of pathway images is fixed. If you provide both `width` and `height` to `grid.biocarta()`, the image will be scaled to fit the smaller dimension.

## Reference documentation
- [Customize BioCarta Pathway Images](./references/BioCartaImage.Rmd)
- [Customize BioCarta Pathway Images](./references/BioCartaImage.md)