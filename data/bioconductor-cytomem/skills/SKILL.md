---
name: bioconductor-cytomem
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/cytoMEM.html
---

# bioconductor-cytomem

## Overview
The `cytoMEM` package implements Marker Enrichment Modeling (MEM), a method to quantify and label cell populations based on feature enrichment relative to a reference. It transforms complex single-cell data into human-readable labels (e.g., `CD4+4 CD8-7`) and heatmaps, facilitating the identification and characterization of clusters from flow or mass cytometry.

## Core Workflow

### 1. Data Preparation
MEM accepts matrices, data frames, or file paths (.fcs, .csv, .txt). Data should have cells in rows and markers in columns. The last column must be the `cluster` ID unless `file.is.clust = TRUE`.

```r
library(cytoMEM)
data(PBMC) # Example dataset

# If using multiple files where each file is one cluster:
# infiles <- dir(pattern = "*.fcs")
# MEM_values <- MEM(infiles, file.is.clust = TRUE)
```

### 2. Running MEM
The `MEM()` function calculates the enrichment scores.

```r
MEM_values <- MEM(
  PBMC,
  transform = TRUE,      # Apply arcsinh transformation
  cofactor = 15,         # Standard for CyTOF; use 5 for fluorescence
  choose.markers = FALSE, 
  markers = "all",       # Or specific indices like 1:25
  choose.ref = FALSE,    # Default: reference is all other cells
  zero.ref = FALSE,      # Set TRUE to see absolute positive enrichment
  rename.markers = FALSE
)
```

**Key Parameters:**
- `zero.ref`: If `TRUE`, compares populations to a synthetic negative (zero) reference. Useful for showing markers expressed across all clusters.
- `choose.ref`: If `TRUE`, allows selecting specific cluster IDs to serve as the universal reference.
- `IQR.thresh`: Defaults to 0.5 to prevent artificial inflation of scores in low-variance background channels.

### 3. Visualization and Labeling
Use `build_heatmaps()` to generate the MEM labels and visual summaries.

```r
build_heatmaps(
  MEM_values,
  cluster.MEM = "both",    # Cluster rows and columns
  display.thresh = 1,      # Only include markers with score >= 1 in labels
  output.files = FALSE,    # Set TRUE to save PDFs and text files
  labels = TRUE            # Display MEM labels on the heatmap rows
)
```

**Output Interpretation:**
- **MEM Labels:** A string like `CD4+4 CD3+4 ... CD16-9`. The number (1-10) indicates the magnitude of enrichment (+) or lack thereof (-).
- **Files:** If `output.files = TRUE`, the package creates an `output files` folder containing the MEM matrix, median matrix, and labels.

### 4. Similarity Analysis (RMSD)
To compare how similar two populations are based on their MEM profiles, use `MEM_RMSD()`.

```r
# MEM_values[[5]][[1]] contains the MEM score matrix
rmsd_results <- MEM_RMSD(
  MEM_values[[5]][[1]],
  output.matrix = TRUE
)
```
The output is a reciprocal similarity matrix and a heatmap where higher values (closer to 100) indicate higher similarity.

## Tips for Success
- **Transformation:** If your data is already transformed, set `transform = FALSE`.
- **Marker Names:** Ensure marker names do not contain spaces if using the `rename.markers` workflow.
- **Reference Selection:** Use `zero.ref = TRUE` when you want to identify markers that define a population regardless of the other clusters present (e.g., identifying all clusters as CD45+).
- **Large Datasets:** For very large datasets, consider sub-sampling clusters before running MEM to improve performance, as MEM calculates statistics per cluster.

## Reference documentation
- [Intro to Marker Enrichment Modeling Analysis](./references/Intro_to_Marker_Enrichment_Modeling_Analysis.md)
- [Intro to Marker Enrichment Modeling Analysis (Rmd)](./references/Intro_to_Marker_Enrichment_Modeling_Analysis.Rmd)