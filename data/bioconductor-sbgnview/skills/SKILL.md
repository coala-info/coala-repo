---
name: bioconductor-sbgnview
description: SBGNview visualizes and integrates omics data by mapping gene and compound abundances onto SBGN-standard pathway maps. Use when user asks to search for pathway IDs, map gene expression or metabolite data to pathway diagrams, highlight specific nodes or paths, and generate publication-quality pathway visualizations.
homepage: https://bioconductor.org/packages/release/bioc/html/SBGNview.html
---


# bioconductor-sbgnview

name: bioconductor-sbgnview
description: Visualization, integration, and analysis of omics data (gene and compound) on SBGN (Systems Biology Graphical Notation) pathway maps. Use this skill when you need to map gene expression or metabolite abundance data onto high-quality pathway diagrams from databases like Reactome, PANTHER, MetaCyc, and SMPDB. It is particularly useful for creating publication-quality SVG/PNG pathway visualizations with data-driven pseudo-coloring and highlighting specific nodes or paths.

# bioconductor-sbgnview

## Overview
SBGNview is an R package designed for pathway-based data visualization and analysis using the SBGN standard. It serves as a powerful alternative and complement to Pathview, supporting a much broader range of pathway databases (Reactome, MetaCyc, SMPDB, PANTHER, MetaCrop) and providing extensive control over graph aesthetics. It maps omics data to "macromolecule" (genes/proteins) and "simple chemical" (compounds) glyphs.

## Core Workflow

### 1. Setup and Data Preparation
Load the package and the required pathway collection data.
```r
library(SBGNview)
data("sbgn.xmls", "pathways.info") # Load core pathway collection
```

### 2. Finding Pathways
Search for pathways by name or ID.
```r
# Search by keyword
pathways <- findPathways("Adrenaline and noradrenaline biosynthesis")
pathway_id <- pathways$pathway.id[1] # e.g., "P00001"
```

### 3. Basic Visualization
Map gene or compound data (matrices or vectors) to a pathway.
```r
# gene.data: rownames are IDs (e.g., Entrez), columns are samples
# cpd.data: rownames are compound IDs (e.g., KEGG)
sbgn.obj <- SBGNview(
  gene.data = my_gene_matrix,
  cpd.data = my_cpd_matrix,
  input.sbgn = pathway_id,
  gene.id.type = "entrez",
  cpd.id.type = "kegg",
  output.file = "my_pathway_plot",
  output.formats = c("png", "pdf")
)
# Printing the object renders the files
print(sbgn.obj)
```

### 4. Modifying and Highlighting
SBGNview uses a `ggplot2`-like syntax using the `+` operator to modify the visualization object.

```r
# Highlight specific nodes or paths
sbgn.obj <- sbgn.obj + 
  highlightNodes(node.set = c("tyrosine"), stroke.color = "green", stroke.width = 4) +
  highlightPath(from.node = "tyrosine", to.node = "dopamine", shortest.paths.cols = "purple")

# Change output filename
outputFile(sbgn.obj) <- "highlighted_pathway"
print(sbgn.obj)
```

## Key Functions

- `SBGNview()`: Main function for mapping data and rendering graphs.
- `findPathways()`: Search for pathway IDs using keywords or molecule IDs.
- `changeDataId()`: Manually convert data IDs to match SBGN-ML glyph IDs.
- `sbgn.gsets()`: Extract gene sets from SBGN pathways for enrichment analysis (e.g., with `gage`).
- `highlightNodes()` / `highlightArcs()` / `highlightPath()`: Add visual emphasis to specific elements.
- `outputFile()`: Get or set the output file name for an SBGNview object.

## Tips for Success
- **ID Mapping**: SBGNview handles common ID types (ENTREZ, UniProt, KEGG) automatically for its core collection. If using custom SBGN-ML files, ensure IDs match or provide a mapping table.
- **Object Persistence**: Assigning `obj <- obj + highlight...` does not print. You must call `print(obj)` or just `obj` in the console to generate the image files.
- **Layouts**: If a diagram looks cluttered, check if alternative layouts are available by searching for `.new.layout.sbgn` files in the package `extdata`.
- **SVG Editing**: The default output is SVG. For fine-tuned manual adjustments for publication, the SVG can be edited in tools like Inkscape.

## Reference documentation
- [SBGNview Main Vignette](./references/SBGNview.Vignette.md)
- [SBGNview Quick Start](./references/SBGNview.quick.start.md)
- [Pathway Analysis Workflow](./references/pathway.enrichment.analysis.md)