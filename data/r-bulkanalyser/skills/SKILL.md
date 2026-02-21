---
name: r-bulkanalyser
description: R package bulkanalyser (documentation from project home).
homepage: https://cran.r-project.org/web/packages/bulkanalyser/index.html
---

# r-bulkanalyser

## Overview
The `bulkAnalyseR` package provides an interactive pipeline for analyzing and sharing bulk sequencing results. It transforms static expression matrices into interactive Shiny applications containing panels for quality control, differential expression (DE), volcano/MA plots, functional enrichment, expression patterns, and GRN inference.

## Installation
```R
install.packages("bulkAnalyseR")
# Ensure Bioconductor dependencies are installed
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("preprocessCore", "edgeR", "DESeq2", "AnnotationDBI", "GENIE3", "ComplexHeatmap"))
```

## Core Workflow

### 1. Data Preparation
The package requires an expression matrix (genes in rows, samples in columns) and a metadata table where the first column matches the matrix column names.

```R
# Example metadata
metadata <- data.frame(
  srr = colnames(expression.matrix),
  timepoint = rep(c("0h", "12h", "36h"), each = 2)
)
```

### 2. Preprocessing (Denoising & Normalization)
Always preprocess raw counts to remove technical noise and normalize across samples.
```R
# Denoises using noisyR and normalizes (default: quantile)
expression.matrix.preproc <- preprocessExpressionMatrix(
  expression.matrix,
  normalisation.method = "quantile" # or "rpm"
)
```

### 3. Generating the Shiny App
The `generateShinyApp` function creates an `app.R` file and necessary `.rda` data objects in a specified directory.

```R
generateShinyApp(
  expression.matrix = expression.matrix.preproc,
  metadata = metadata,
  shiny.dir = "my_shiny_app",
  app.title = "Project Analysis",
  organism = "mmusculus",       # e.g., "hsapiens", "mmusculus"
  org.db = "org.Mm.eg.db"       # Bioconductor annotation package
)

# Launch the app
shiny::runApp("my_shiny_app")
```

## Key Functions and Panels
- **`preprocessExpressionMatrix()`**: Handles noise removal and normalization.
- **`generateShinyApp()`**: The main wrapper to build the interactive interface.
- **Default Panels**:
    - **QC**: PCA and sample distance heatmaps.
    - **DE**: Differential expression using DESeq2 or edgeR.
    - **Enrichment**: Functional analysis via g:Profiler.
    - **Patterns**: Clustering and line plots of expression trends.
    - **GRN**: Localized Gene Regulatory Network inference using GENIE3.

## Tips for Success
- **Organism Support**: Ensure the correct `org.db` (e.g., `org.Hs.eg.db` for human) is installed and passed to `generateShinyApp` for enrichment and gene naming to work.
- **Customization**: Use the `default.panels` argument in `generateShinyApp` to include or exclude specific analysis modules.
- **Sharing**: The generated directory is standalone. You can zip the folder and send it to collaborators or host it on shinyapps.io.

## Reference documentation
- [LICENSE.md](./references/LICENSE.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)