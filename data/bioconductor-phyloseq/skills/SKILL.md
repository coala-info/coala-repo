---
name: bioconductor-phyloseq
description: The phyloseq package integrates and analyzes microbiome census data by bundling OTU tables, sample metadata, taxonomy, and phylogenetic trees into a single R object. Use when user asks to import microbiome data, filter or subset taxa and samples, calculate alpha and beta diversity, perform ordinations, or generate ecological visualizations like bar plots and heatmaps.
homepage: https://bioconductor.org/packages/release/bioc/html/phyloseq.html
---


# bioconductor-phyloseq

## Overview

The `phyloseq` package is the industry standard in R for handling high-throughput microbiome census data. It uses a specialized S4 class system to bundle OTU tables, sample metadata, taxonomic assignments, and phylogenetic trees into a single object. This integration ensures that any subsetting or filtering applied to one component (e.g., removing a sample) is automatically reflected across all others, maintaining data integrity throughout the analysis pipeline.

## Core Workflows

### 1. Data Import and Object Construction
Phyloseq objects are typically built from individual components or imported from standard bioinformatics pipelines.

```r
library(phyloseq)

# Manual construction
ps <- phyloseq(otu_table(otu_mat, taxa_are_rows = TRUE), 
               sample_data(sample_df), 
               tax_table(tax_mat),
               phy_tree(tree_obj))

# Importing from BIOM (supports HDF5 and JSON)
ps <- import_biom("study_data.biom")

# Importing from QIIME
ps <- import_qiime(otu_file, map_file, tree_file)
```

### 2. Data Manipulation and Filtering
Use the `subset_` and `prune_` family of functions to clean your data.

- **Subsetting**: `subset_samples(ps, Treatment == "Control")` or `subset_taxa(ps, Phylum == "Bacteroidetes")`.
- **Pruning**: Remove low-abundance taxa using `prune_taxa(taxa_sums(ps) > 10, ps)`.
- **Merging**: Agglomerate taxa at specific ranks using `tax_glom(ps, "Genus")`.
- **Transforming**: Convert counts to relative abundance with `transform_sample_counts(ps, function(x) x / sum(x))`.

### 3. Alpha and Beta Diversity
Phyloseq provides wrappers for common ecological metrics.

- **Alpha Diversity**: Use `plot_richness(ps, x="Group", measures=c("Shannon", "Chao1"))`. Note: Do not rarefy data before alpha diversity analysis; use raw counts.
- **Distances**: Calculate dissimilarity matrices using `distance(ps, method="unifrac")` or `distance(ps, method="bray")`.
- **Ordination**: Perform and plot ordinations in two steps:
  ```r
  ord <- ordinate(ps, method="NMDS", distance="bray")
  plot_ordination(ps, ord, color="SampleType", title="NMDS of Bray-Curtis")
  ```

### 4. Visualization
All `plot_` functions in phyloseq return `ggplot2` objects, allowing for easy customization.

- **Bar Plots**: `plot_bar(ps, fill="Phylum")`
- **Heatmaps**: `plot_heatmap(ps, method="NMDS", distance="bray")`
- **Trees**: `plot_tree(ps, color="SampleType", label.tips="Genus", size="Abundance")`
- **Networks**: `plot_net(ps, maxdist=0.4, color="SampleType")`

## Best Practices and Tips

- **Rarefying**: Avoid rarefying (subsampling to even depth) for differential abundance testing. It is statistically inefficient and increases the false positive rate.
- **Differential Abundance**: For testing differences between groups, use the `phyloseq_to_deseq2` wrapper to export data to the `DESeq2` package, which handles library size normalization more effectively.
- **Standardization**: If samples have different library sizes, use Variance Stabilizing Transformations (VST) or log-transformations for ordination, rather than simple proportions.
- **Negative Values**: If transformations (like VST) produce negative values, they are generally acceptable for PCA/PCoA but may need to be floored to zero for certain distance metrics.

## Reference documentation

- [phyloseq Frequently Asked Questions (FAQ)](./references/phyloseq-FAQ.md)
- [Vignette for phyloseq: Analysis of high-throughput microbiome census data](./references/phyloseq-analysis.md)
- [phyloseq Basics](./references/phyloseq-basics.md)
- [Differential Abundance and Mixture Models](./references/phyloseq-mixture-models.md)