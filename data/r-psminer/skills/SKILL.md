---
name: r-psminer
description: This tool analyzes, visualizes, and manipulates data produced by the nf-core/pathogensurveillance pipeline. Use when user asks to read pipeline outputs, parse phylogenetic trees, generate ANI heatmaps, or plot taxonomic distributions.
homepage: https://cran.r-project.org/web/packages/psminer/index.html
---

# r-psminer

name: r-psminer
description: Analysis, visualization, and manipulation of data produced by the nf-core/pathogensurveillance pipeline. Use this skill when you need to read, summarize, or plot outputs from the pathogensurveillance workflow, including multigene phylogenies, ANI (Average Nucleotide Identity) estimates, and taxonomic distributions.

## Overview

The `psminer` (PathoSurveilR) package provides a suite of tools to interact with the output directories of the `pathogensurveillance` pipeline. It simplifies the process of parsing complex bioinformatics outputs into R-friendly formats (tibbles, vectors) and provides high-level plotting functions for genomic surveillance data.

## Installation

Install the package from CRAN:

```R
install.packages("psminer")
```

Note: If the CRAN version is unavailable, the development version can be installed via:
`devtools::install_github("grunwaldlab/PathoSurveilR")`

## Core Workflow

Most functions in `psminer` accept a directory path as their primary argument. The package automatically searches for relevant files within the `pathogensurveillance` output structure.

### 1. Locating Data
Functions ending in `_path` or `_path_data` return the file system locations of specific pipeline outputs.

```R
library(psminer)
path <- "path/to/ps_output"

# Get paths to specific files
ani_matrix_path <- estimated_ani_matrix_path(path)
tree_paths <- core_tree_path_data(path)
```

### 2. Parsing Data
Functions ending in `_parsed` read and convert raw files into R data structures.

```R
# Parse sendsketch (taxonomic) results
sketch_data <- sendsketch_parsed(path)

# Parse phylogenetic trees
trees <- core_tree_parsed(path)
```

### 3. Visualization
`psminer` provides high-level plotting functions for common surveillance tasks.

*   **Phylogeny**: `multigene_tree_plot(path)` creates core gene (prokaryote) or BUSCO (eukaryote) trees.
*   **ANI Heatmaps**: `estimated_ani_heatmap(path)` visualizes genomic similarity.
*   **Taxonomy**: `sendsketch_taxonomy_plot(path, interactive = TRUE)` creates interactive taxonomic distributions.

### 4. Summary Tables
Generate formatted tables for reports.

```R
# Get a table of the best ANI matches for each sample
match_table <- estimated_ani_match_table(path)
```

## Function Naming Convention
Functions are organized by the data type they handle. Use autocomplete (e.g., `psminer::estimated_ani_` + TAB) to discover related tools:
*   `*_path`: Returns a character vector of file paths.
*   `*_path_data`: Returns a tibble with paths and associated metadata (e.g., sample IDs).
*   `*_parsed`: Returns the data loaded into R.
*   `*_plot`: Returns a ggplot or plotly object.

## Reference documentation

- [NEWS.md](./references/NEWS.md)
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [figure-gfm.md](./references/figure-gfm.md)
- [home_page.md](./references/home_page.md)