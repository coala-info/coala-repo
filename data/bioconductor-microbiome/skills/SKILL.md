---
name: bioconductor-microbiome
description: The microbiome package provides specialized tools for the exploration, transformation, and statistical analysis of microbial community data within the phyloseq framework. Use when user asks to transform abundance data, calculate alpha or beta diversity indices, identify core taxa, or visualize microbial composition.
homepage: https://bioconductor.org/packages/release/bioc/html/microbiome.html
---

# bioconductor-microbiome

## Overview

The `microbiome` package extends the `phyloseq` framework to provide specialized tools for the exploration and statistical analysis of microbial community data. It is designed for handling taxonomic profiling data (such as 16S rRNA or metagenomic OTU tables) and offers streamlined workflows for common tasks like normalization, alpha/beta diversity calculation, and identifying "core" taxa within a population.

## Core Workflows

### Data Loading and Preparation
The package works directly with `phyloseq` objects. You can load example data or convert your own data into the required format.

```r
library(microbiome)
library(phyloseq)

# Load example data (e.g., atlas1006)
data(atlas1006)
pseq <- atlas1006

# Check basic stats
print(pseq)
summarize_phyloseq(pseq)
```

### Data Transformation
Standardize or transform abundance data for downstream analysis.

```r
# Relative abundance (compositional)
pseq.rel <- microbiome::transform(pseq, "compositional")

# Log10 transformation
pseq.log <- microbiome::transform(pseq, "log10")

# Z-score transformation
pseq.z <- microbiome::transform(pseq, "zscore")
```

### Diversity Analysis
Calculate multiple alpha diversity indices or analyze community composition.

```r
# Calculate alpha diversity (shannon, inverse_simpson, etc.)
tab <- alpha(pseq, index = "all")

# Richness estimates
richness_tab <- richness(pseq)

# Dominance and Evenness
dom_tab <- dominance(pseq)
even_tab <- evenness(pseq)
```

### Core Microbiome Identification
Identify taxa that are prevalent and abundant across samples.

```r
# Get names of core taxa (prevalence > 50%, detection threshold > 0.1%)
core_taxa <- core_members(pseq, detection = 0.001, prevalence = 0.5)

# Filter phyloseq object to core members
pseq.core <- core(pseq, detection = 0.001, prevalence = 0.5)

# Visualize core microbiome
plot_core(pseq, plot.type = "heatmap", 
          prevalences = seq(.05, 1, .05), 
          detections = 10^(seq(log10(0.1), log10(20), length.out = 10)))
```

### Visualization
The package provides wrappers for common microbiome plots.

```r
# Plot composition at a specific taxonomic level
pseq.fam <- aggregate_taxa(pseq, "Family")
plot_composition(pseq.fam, average_by = "group_variable")

# Plot prevalence vs abundance
plot_abundance_stats(pseq, "TaxonName")
```

## Tips for Success
- **Phyloseq Integration**: Since `microbiome` is built on `phyloseq`, you can use standard `phyloseq` functions (like `subset_samples` or `tax_glom`) interchangeably with `microbiome` functions.
- **Compositional Data**: Always consider if your data should be transformed to "compositional" (relative abundance) before performing statistical comparisons or core analysis.
- **Aggregation**: Use `aggregate_taxa(pseq, "Rank")` to quickly collapse OTUs/ASVs into higher taxonomic levels for cleaner visualizations.

## Reference documentation
- [Introduction to the microbiome R package](./references/vignette.md)
- [Microbiome Package Source](./references/vignette.Rmd)