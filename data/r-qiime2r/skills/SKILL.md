---
name: r-qiime2r
description: This tool imports and analyzes QIIME2 artifacts directly in R by converting them into native data structures like phyloseq or TreeSummarizedExperiment objects. Use when user asks to read .qza or .qzv files, parse taxonomy strings, or convert QIIME2 data for statistical analysis and visualization in R.
homepage: https://cran.r-project.org/web/packages/qiime2r/index.html
---


# r-qiime2r

name: r-qiime2r
description: Import and analyze QIIME2 artifacts (.qza and .qzv) in R. Use this skill when you need to read QIIME2 data into R data frames, phyloseq objects, or TreeSummarizedExperiment (TSE) objects for visualization and statistical analysis.

## Overview
The `qiime2R` package allows R users to directly import QIIME2 artifacts without needing a local QIIME2 installation or manual exportation to text files. It preserves data provenance and converts artifacts into native R objects like matrices, data frames, `phylo` objects, and `DNAStringSets`.

## Installation
```R
if (!requireNamespace("devtools", quietly = TRUE)){install.packages("devtools")}
devtools::install_github("jbisanz/qiime2R")
```

## Core Functions
- `read_qza(file)`: Primary function to read any .qza artifact. Returns a list containing `$data`, `$uuid`, `$type`, `$format`, and `$provenance`.
- `qza_to_phyloseq(...)`: Helper to create a `phyloseq` object by providing paths to features, tree, taxonomy, and metadata.
- `qza_to_tse(...)`: Helper to create a `TreeSummarizedExperiment` object.
- `read_q2metadata(file)`: Reads QIIME2-formatted metadata files (handling the #q2:types header).
- `parse_taxonomy(data)`: Converts the semicolon-delimited taxonomy strings from a taxonomy artifact into a structured data frame with columns for Kingdom, Phylum, etc.

## Common Workflows

### 1. Basic Data Import
```R
library(qiime2R)

# Read a feature table
SVs <- read_qza("table.qza")
feature_table <- SVs$data

# Read and parse taxonomy
tax_raw <- read_qza("taxonomy.qza")
taxonomy <- parse_taxonomy(tax_raw$data)

# Read metadata
metadata <- read_q2metadata("sample-metadata.tsv")
```

### 2. Integration with Phyloseq
```R
physeq <- qza_to_phyloseq(
    features="table.qza",
    tree="rooted-tree.qza",
    taxonomy="taxonomy.qza",
    metadata = "sample-metadata.tsv"
)
```

### 3. Visualization Helpers
- `taxa_barplot(taxasums, metadata, "category")`: Generates a ggplot2 stacked barplot.
- `taxa_heatmap(taxasums, metadata, "category")`: Generates a ggplot2 heatmap.
- `summarize_taxa(features, taxonomy)`: Aggregates feature counts to every taxonomic level (Kingdom through Species).
- `theme_q2r()`: A clean ggplot2 theme matching QIIME2 aesthetic styles.

## Data Transformation
- `make_clr(table)`: Centered log-ratio transformation.
- `make_proportion(table)`: Converts counts to relative abundance (0-1).
- `make_percent(table)`: Converts counts to percentages (0-100).

## Tips
- Access the raw matrix from a `read_qza` object using the `$data` slot.
- Use `print_provenance(artifact)` to inspect how a specific file was generated within the QIIME2 pipeline.
- When merging metadata with diversity vectors (like Shannon), use `rownames_to_column("SampleID")` on the artifact data to facilitate a `left_join`.

## Reference documentation
- [qiime2r Tutorial](./references/README.md)
- [GitHub Articles](./references/articles.md)
- [Project Home](./references/home_page.md)