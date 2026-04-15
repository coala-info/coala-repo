---
name: r-ampvis2
description: ampvis2 is an R package for the visualization and analysis of microbial community amplicon data. Use when user asks to load microbiome datasets, generate taxonomic heatmaps, perform ordination analysis, or calculate alpha diversity.
homepage: https://cran.r-project.org/web/packages/ampvis2/index.html
---

# r-ampvis2

## Overview
ampvis2 is an R package designed for the convenient visualization and analysis of microbial community amplicon data. It excels at handling large datasets and providing high-level functions for common microbiome analysis workflows, such as taxonomic heatmaps, ordination, and differential abundance.

## Installation
To install the package from GitHub (as it is primarily hosted there):
```R
install.packages("remotes")
remotes::install_github("kasperskytte/ampvis2")
```

## Core Workflow

### 1. Data Loading
The package uses a specific `ampvis2` object. You can create it from an OTU/ASV table, taxonomy table, and metadata.
```R
library(ampvis2)

# Load data using amp_load
d <- amp_load(
  otutable = "otu_table.csv", 
  metadata = "metadata.csv",
  taxonomy = "taxonomy.csv"
)
```

### 2. Visualizing Taxonomy (Heatmaps)
The `amp_heatmap` function is the primary tool for visualizing community composition.
```R
amp_heatmap(
  d,
  group_by = "SampleType",
  tax_aggregate = "Genus",
  tax_show = 20,
  plot_values = TRUE
)
```

### 3. Ordination (Beta Diversity)
Use `amp_ordination` for PCA, PCoA, or NMDS.
```R
amp_ordination(
  d,
  type = "pca",
  sample_color_by = "Treatment",
  sample_shape_by = "Location"
)
```

### 4. Alpha Diversity
Calculate and plot alpha diversity indices.
```R
amp_alphadiv(
  d,
  measure = c("observed", "shannon", "simpson"),
  group_by = "Treatment"
)
```

### 5. Subsetting and Filtering
Filter data based on taxonomy or metadata before plotting.
```R
# Subset to a specific Phylum
d_sub <- amp_subset_taxa(d, tax_vector = c("p__Proteobacteria"))

# Subset based on metadata
d_sub <- amp_subset_samples(d, Treatment %in% c("Control", "A"))
```

## Key Functions
- `amp_load()`: Creates the ampvis2 object.
- `amp_heatmap()`: Generates publication-quality heatmaps.
- `amp_ordination()`: Performs and plots ordination (PCA, PCoA, NMDS, etc.).
- `amp_boxplot()`: Visualizes abundance of specific taxa across groups.
- `amp_venn()`: Creates Venn diagrams for shared taxa.
- `amp_rarecurve()`: Generates rarefaction curves.

## Tips for Success
- **Taxonomy Format**: Ensure your taxonomy table has 7 columns (Kingdom to Species) or is formatted correctly for `amp_load` to parse.
- **Normalization**: By default, many functions (like `amp_heatmap`) convert raw counts to relative abundance (percentages). Check the `transform` argument.
- **Interactive Analysis**: For quick exploration, use the `amp_export_shiny()` function to launch a local interactive app.

## Reference documentation
- [ISSUE_TEMPLATE.md](./references/ISSUE_TEMPLATE.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)