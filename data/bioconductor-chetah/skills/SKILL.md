---
name: bioconductor-chetah
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CHETAH.html
---

# bioconductor-chetah

## Overview
CHETAH (CHaracterization of cEll Types Aided by Hierarchical classification) is a Bioconductor package designed for cell type identification of scRNA-seq data. It uses a hierarchical classification tree built from a reference dataset to assign input cells to either final cell types or intermediate nodes. This approach is particularly useful when data does not allow for unambiguous classification to a specific leaf node, providing "intermediate" assignments (e.g., "Node1", "Unassigned") instead of forced incorrect labels.

## Core Workflow

### 1. Data Preparation
CHETAH requires both input and reference data to be formatted as `SingleCellExperiment` (SCE) objects.

```r
library(CHETAH)
library(SingleCellExperiment)

# 1. Prepare Reference (Must be normalized)
# colData must contain a column with cell type labels (default: "celltypes")
reference <- SingleCellExperiment(assays = list(counts = ref_counts),
                                  colData = DataFrame(celltypes = ref_ct))

# 2. Prepare Input
# Should contain an assay and reduced dimensions (e.g., TSNE or PCA)
input <- SingleCellExperiment(assays = list(counts = input_counts),
                              reducedDims = SimpleList(TSNE = input_tsne))
```

### 2. Running the Classifier
The primary function is `CHETAHclassifier`. It correlates input cells to the reference hierarchy.

```r
input <- CHETAHclassifier(input = input, ref_cells = reference)

# Extract results
final_types <- input$celltype_CHETAH
```

### 3. Visualization and Interaction
CHETAH provides built-in plotting functions and a Shiny interface for exploration.

```r
# Plot classification tree and t-SNE map
PlotCHETAH(input)

# Color by intermediate types instead of final types
PlotCHETAH(input, interm = TRUE)

# Launch interactive browser
CHETAHshiny(input)
```

## Advanced Operations

### Adjusting Confidence Thresholds
The default confidence threshold is 0.1. Increasing this value makes classification stricter (more intermediate types), while setting it to 0 forces all cells into final types.

```r
# Re-classify with a higher threshold (e.g., 0.8)
input <- Classify(input, confidence = 0.8)

# Force classification of all cells
input <- Classify(input, confidence = 0)
```

### Renaming Nodes
If specific subtypes are not of interest, you can collapse branches of the tree.

```r
# Rename all types under Node 6 to "T cell"
input <- RenameBelowNode(input, whichnode = 6, replacement = "T cell")
```

### Reference Quality Control
Before using a new reference, evaluate how well CHETAH can distinguish its types.

```r
# Check correlation between reference types
CorrelateReference(ref_cells = reference)

# Perform "leave-one-out" style classification on the reference itself
ClassifyReference(ref_cells = reference)
```

## Best Practices
- **Normalization**: Input data does not need to be normalized, but the **reference data must be normalized** before running CHETAH.
- **Gene Filtering**: Removing house-keeping genes (like ribosomal protein genes) from the reference can often improve classification accuracy.
- **Reference Selection**: Use a reference from a similar biological context (e.g., same tissue or cell state).
- **Subsampling**: For very large references, subsampling each cell type to 100-200 cells significantly reduces computation time with minimal impact on performance.

## Reference documentation
- [Introduction to the CHETAH package](./references/CHETAH_introduction.md)
- [Introduction to the CHETAH package (RMarkdown)](./references/CHETAH_introduction.Rmd)