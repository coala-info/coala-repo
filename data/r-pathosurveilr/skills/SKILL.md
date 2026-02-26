---
name: r-pathosurveilr
description: This R package analyzes, summarizes, and visualizes outputs from the nf-core/pathogensurveillance pipeline. Use when user asks to generate multigene phylogeny plots, calculate estimated ANI match tables, or parse sendsketch taxonomic data.
homepage: https://cran.r-project.org/web/packages/pathosurveilr/index.html
---


# r-pathosurveilr

name: r-pathosurveilr
description: Specialized R package for analyzing, summarizing, and visualizing outputs from the nf-core/pathogensurveillance pipeline. Use this skill when you need to read pathogensurveillance results, generate multigene phylogeny plots, calculate estimated ANI (Average Nucleotide Identity) match tables, or parse sendsketch taxonomic data.

## Overview

`PathoSurveilR` provides a suite of tools to interact with the output directories of the `pathogensurveillance` pipeline. It simplifies the process of loading complex genomic surveillance data into R for downstream analysis, visualization, and reporting.

## Installation

```R
install.packages("devtools")
devtools::install_github("grunwaldlab/PathoSurveilR")
```

## Core Workflow

Most functions in `PathoSurveilR` accept a directory path as their primary input. The package automatically searches the provided path for relevant `pathogensurveillance` output files.

### 1. Phylogeny and Trees
Generate core gene phylogenies (prokaryotes) or BUSCO phylogenies (eukaryotes).
```R
# Returns a list of plots; [[2]] is typically the main tree
multigene_tree_plot(path)[[2]]

# Get paths to tree files
core_tree_path_data(path)

# Parse tree files into R objects
core_tree_parsed(path)
```

### 2. ANI (Average Nucleotide Identity) Analysis
Analyze genomic similarity between samples and references using sourmash-based estimates.
```R
# Create a table of best matches for each sample
estimated_ani_match_table(path)

# Generate a heatmap of genomic similarity
estimated_ani_heatmap(path)

# Parse the raw ANI matrix
estimated_ani_matrix_parsed(path)
```

### 3. Taxonomic Identification
Visualize and parse `sendsketch` results for taxonomic distribution.
```R
# Static or interactive taxonomic distribution plot
sendsketch_taxonomy_plot(path, interactive = TRUE)

# Parse raw sendsketch hits into a tibble
sendsketch_parsed(path)
```

## Function Naming Convention

Functions are organized by data type prefixes. Use autocomplete (e.g., `PathoSurveilR::estimated_ani_` + `<TAB>`) to discover related tools:
- `*_path`: Returns a vector of file paths.
- `*_path_data`: Returns a tibble of paths with associated metadata (sample/cluster IDs).
- `*_parsed`: Returns the data loaded and formatted into R objects (tibbles or lists).
- `*_plot` or `*_heatmap`: Returns ggplot2 or plotly visualization objects.

## Reference documentation

- [NEWS.md](./references/NEWS.md)
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [figure-gfm.md](./references/figure-gfm.md)
- [home_page.md](./references/home_page.md)