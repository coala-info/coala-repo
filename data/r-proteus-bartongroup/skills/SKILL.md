---
name: r-proteus-bartongroup
description: Proteus is an R package for the downstream analysis of MaxQuant proteomics data, including data normalization, visualization, and differential expression analysis. Use when user asks to import protein groups, perform median normalization, visualize sample distributions with PCA or volcano plots, or conduct differential expression analysis using limma.
homepage: https://cran.r-project.org/web/packages/proteus-bartongroup/index.html
---

# r-proteus-bartongroup

## Overview
Proteus is an R package designed for the downstream analysis of MaxQuant output. It provides a framework for aggregating evidence-level data into peptides and proteins, performing normalization, and conducting differential expression analysis. While originally built for evidence file aggregation, current best practices recommend importing `proteinGroups` files directly for maxLFQ-normalized data.

## Installation
To install the package from GitHub:
```R
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("limma")

install.packages("devtools")
devtools::install_github("bartongroup/Proteus", build_vignettes=TRUE)
```

## Core Workflow

### 1. Data Import and Metadata
Proteus requires a metadata data frame mapping MaxQuant experiment names to sample groups.
```R
# Create metadata
metadata <- data.frame(
  sample = c("Exp1", "Exp2", "Exp3", "Exp4"),
  condition = c("Control", "Control", "Treat", "Treat")
)

# Read protein groups (Recommended approach)
# measure.cols should map to the intensity columns in your file
prot.data <- readProteinGroups(file="proteinGroups.txt", meta=metadata)
```

### 2. Data Processing
- **Normalization**: Use `normalizeData` to remove systematic bias.
- **Filtering**: Remove proteins with too many missing values.
- **Log Transformation**: Usually performed during the import or normalization step.

```R
# Log2 transformation and normalization
prot.normalized <- normalizeData(prot.data, method="median")

# Filter proteins based on occupancy
prot.filtered <- filterProteins(prot.normalized, min.count=2)
```

### 3. Visualization
Proteus provides several plotting functions to assess data quality:
- `plotSampleDist(prot.data)`: Check intensity distributions.
- `plotMeanSd(prot.data)`: Check mean-variance relationship.
- `plotPCA(prot.data)`: Principal Component Analysis.
- `plotClustering(prot.data)`: Hierarchical clustering of samples.

### 4. Differential Expression
Proteus wraps `limma` for robust differential expression analysis.
```R
# Define the contrast
res <- limmaDE(prot.filtered, conditions=c("Control", "Treat"))

# Visualize results
plotVolcano(res)
plotLiveVolcano(res) # Interactive version
```

## Workflow Variations
- **Label-Free**: Standard workflow using `readProteinGroups`.
- **TMT/SILAC**: Requires specific column mapping during import. Use `vignette("TMT", package="proteus")` or `vignette("SILAC", package="proteus")` for specific configurations.

## Best Practices
- **Aggregation Warning**: The package authors now advise against aggregating from the `evidence.txt` file within Proteus for most users. Instead, use MaxQuant's internal `maxLFQ` algorithm and import the resulting `proteinGroups.txt`.
- **Missing Values**: Proteus handles missing values by keeping them as `NA`. Ensure your filtering criteria (`min.count`) are appropriate for your experimental design before running `limmaDE`.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)