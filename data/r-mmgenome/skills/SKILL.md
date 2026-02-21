---
name: r-mmgenome
description: R package mmgenome (documentation from project home).
homepage: https://cran.r-project.org/web/packages/mmgenome/index.html
---

# r-mmgenome

name: r-mmgenome
description: Specialized R package for extracting individual genomes from metagenomes (metagenomic binning). Use this skill when performing multi-metagenome differential coverage analysis, visualizing scaffold data, and refining metagenome-assembled genomes (MAGs) using the mmgenome workflow.

## Overview

The `mmgenome` package provides a suite of tools for the analysis and extraction of individual genomes from metagenomes. It is designed for a workflow where scaffolds are binned based on differential coverage across multiple samples, sequence composition (GC content), and essential gene information. Note: The developer recommends `mmgenome2` for newer projects, but this skill supports the original `mmgenome` implementation.

## Installation

```R
install.packages("mmgenome")
# Or from GitHub if not on CRAN:
# remotes::install_github("MadsAlbertsen/mmgenome/mmgenome")
```

## Core Workflow

The standard `mmgenome` workflow involves loading scaffold data, visualizing it to identify clusters, and extracting specific bins.

### 1. Data Loading
Load your scaffold data, which typically includes scaffold IDs, length, GC content, and coverage values from different samples.

```R
library(mmgenome)
d <- mmload(
  scaffolds = "scaffolds.fasta",
  coverage = c("sample1.txt", "sample2.txt"),
  essential = "essential_genes.txt",
  taxonomy = "taxonomy.txt"
)
```

### 2. Visualization
Use differential coverage plots to identify genome clusters.

```R
# Basic differential coverage plot
mmplot(
  data = d,
  x = "sample1",
  y = "sample2",
  log10 = TRUE,
  color_by = "phylum"
)

# Plot with essential genes highlighted
mmplot(
  data = d,
  x = "sample1",
  y = "sample2",
  locator = TRUE # Allows interactive selection of bins
)
```

### 3. Genome Extraction
Define a subset of scaffolds based on plot coordinates or specific attributes.

```R
# Extract a specific bin based on coordinates
sub <- mmextract(
  data = d,
  selection = list(sample1 = c(10, 100), sample2 = c(5, 50))
)

# Check bin stats (completeness/contamination based on essential genes)
mmstats(sub)
```

### 4. Refinement
Refine bins by looking at GC content or other samples.

```R
mmplot(
  data = sub,
  x = "GC",
  y = "sample1"
)
```

## Key Functions

- `mmload()`: Loads and merges metagenomic data into a unified object.
- `mmplot()`: Generates ggplot2-based visualizations for binning.
- `mmextract()`: Subsets data based on manual or coordinate-based selections.
- `mmstats()`: Calculates assembly statistics and essential gene completeness.
- `mmexport()`: Exports the scaffolds of a bin to a fasta file.

## Tips for Success

- **Data Preparation**: Ensure scaffold IDs match across all input files (coverage, taxonomy, essential genes).
- **Interactive Binning**: When using `mmplot(..., locator = TRUE)`, you can click on the plot in an interactive R session to define the boundaries of your genome bin.
- **Essential Genes**: Use the `essential` parameter in `mmload` to import results from tools like HMMER (searching for 139 single-copy essential genes) to estimate bin completeness.

## Reference documentation

- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)