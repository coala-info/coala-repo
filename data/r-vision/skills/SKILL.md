---
name: r-vision
description: R package vision (documentation from project home).
homepage: https://cran.r-project.org/web/packages/vision/index.html
---

# r-vision

## Overview
VISION is an R package designed for the functional interpretation of single-cell RNA-seq data. It identifies gene signatures that describe coordinated variation between cells by computing signature scores and evaluating their local consistency on a cell-cell similarity map (KNN graph). It integrates with existing pipelines (Seurat, SingleCellExperiment) and produces dynamic, shareable HTML reports.

## Installation
Install the package from GitHub using devtools:

```R
# install.packages("devtools")
devtools::install_github("YosefLab/VISION")
```

## Core Workflow

### 1. Initialization
Create a VISION object by providing an expression matrix (log-normalized) and a list of signatures (.gmt files or Signature objects).

```R
library(VISION)

# Load signatures from a GMT file
signatures <- c("path/to/signatures.gmt")

# Create VISION object
vis <- Vision(data = exp_matrix, 
              signatures = signatures,
              meta = meta_data) # Optional: cell-level metadata
```

### 2. Analysis Pipeline
Run the standard analysis which includes micropooling (for large datasets), PCA, KNN graph construction, signature scoring, and consistency testing.

```R
vis <- analyze(vis)
```

### 3. Viewing Results
Launch the interactive web-based browser to explore signature scores, metadata, and projections.

```R
viewResults(vis)
```

## Advanced Usage

### Integrating Latent Spaces
If you have precomputed dimensionality reductions (e.g., from Seurat or Scanpy), provide them to bypass VISION's internal PCA.

```R
vis <- Vision(data = exp_matrix,
              signatures = signatures,
              latentSpace = my_pca_results)
```

### Trajectory Integration
VISION can visualize and analyze signatures along trajectories (e.g., Slingshot or Monocle).

```R
# Provide a trajectory object to the Vision constructor
vis <- Vision(data = exp_matrix,
              signatures = signatures,
              latentSpace = my_pca,
              trajectory = my_trajectory)
```

### Micropooling
For datasets >20,000 cells, VISION automatically uses micropooling to group similar cells. You can control this via `projection_genes` or by setting `pool = FALSE` in the constructor if you wish to analyze every cell individually (memory intensive).

## Key Functions
- `Vision()`: Constructor for the VISION object.
- `analyze()`: Runs the full pipeline (scores, consistency, projections).
- `viewResults()`: Launches the local web server for the interactive report.
- `Signature()`: Creates a custom Signature object from a gene list.
- `getSignatureScores()`: Extracts computed scores from the VISION object.

## Tips for Success
- **Gene IDs**: Ensure the gene identifiers in your expression matrix match those in your signature files (e.g., Symbols vs. Ensembl IDs).
- **Normalization**: Input data should be log-normalized. VISION handles scaling internally for signature scoring.
- **Signatures**: Use the MSigDB collections or cell-type specific signatures for the best biological insights.

## Reference documentation
- [API.md](./references/API.md)
- [NEWS.md](./references/NEWS.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)