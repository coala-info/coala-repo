---
name: r-metacoder
description: Metacoder is a bioinformatics toolset for parsing, manipulating, and visualizing large taxonomic datasets using hierarchical data structures. Use when user asks to parse taxonomic data, calculate taxon abundances, compare groups, or create heat tree visualizations.
homepage: https://cloud.r-project.org/web/packages/metacoder/index.html
---


# r-metacoder

## Overview
`metacoder` is a bioinformatics toolset designed for handling large taxonomic datasets. Its core data structure is the `taxmap` object, which links taxonomic hierarchies to user-defined data (like OTU tables or sample metadata). It is best known for "heat trees," which visualize statistics (e.g., abundance, differential expression) across a phylogenetic or taxonomic tree using node/edge color and size.

## Installation
```R
install.packages("metacoder")
# For the development version:
# devtools::install_github("grunwaldlab/metacoder")
```

## Core Workflows

### 1. Data Parsing and Conversion
`metacoder` can ingest various formats including FASTA, mothur, QIIME, and BIOM.
- **From Phyloseq**: `parse_phyloseq(phyloseq_obj)`
- **To Phyloseq**: `as_phyloseq(taxmap_obj)`
- **Generic Parsing**: `parse_tax_data()` is the primary function for converting data frames into `taxmap` objects.

### 2. Data Manipulation
The package uses a `dplyr`-like syntax that is "taxonomy-aware."
- `filter_taxa()`: Subset data based on taxonomic rank or name.
- `filter_obs()`: Subset observations (like OTU counts) associated with taxa.
- `mutate_obs()`: Add new columns to observation tables.
- `taxa_names()`: Get or set taxon names.

### 3. Taxonomic Statistics
- `calc_taxon_abund()`: Sums abundance data (e.g., read counts) for every taxon at every level of the hierarchy.
- `calc_obs_props()`: Converts counts to proportions.
- `rarefy_obs()`: Normalizes data via rarefaction (requires `vegan`).
- `compare_groups()`: Calculates differences between experimental treatments per taxon.

### 4. Heat Tree Visualization
The `heat_tree()` function is the flagship visualization tool.
```R
heat_tree(obj,
          node_label = taxon_names,
          node_size = n_obs,          # Size based on number of OTUs
          node_color = log_abundance, # Color based on stats
          node_color_axis_label = "Log Abundance",
          layout = "davidson-harel", 
          initial_layout = "reingold-tilford")
```

### 5. In Silico PCR
The `primersearch()` function simulates PCR to test primer specificity. 
*Note: Requires the EMBOSS `primersearch` tool installed on the system path.*

## Tips for Success
- **Taxmap Objects**: Remember that `taxmap` objects store data in multiple tables linked by a `taxon_id`. When you filter taxa, `metacoder` can automatically filter the associated data.
- **Hierarchical Summing**: Unlike standard data frames, `metacoder` understands that a "Genus" count should include all "Species" counts beneath it. Use `calc_taxon_abund` to leverage this.
- **Color Palettes**: Use the `node_color_range` argument in `heat_tree` to define custom color gradients (e.g., `c("blue", "gray", "red")` for differential abundance).

## Reference documentation
- [Metacoder Home Page](./references/home_page.md)