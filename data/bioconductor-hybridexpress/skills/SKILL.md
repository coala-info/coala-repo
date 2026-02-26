---
name: bioconductor-hybridexpress
description: HybridExpress is a Bioconductor package for analyzing RNA-Seq data from hybrid triplets to identify differentially expressed genes and classify expression patterns. Use when user asks to generate midparent expression values, perform spike-in normalization, categorize genes into expression classes like dominance or additivity, and visualize results using expression triangles.
homepage: https://bioconductor.org/packages/release/bioc/html/HybridExpress.html
---


# bioconductor-hybridexpress

## Overview
HybridExpress is a Bioconductor package designed for RNA-Seq analysis of "hybrid triplets"—a hybrid organism and its two parental species. It facilitates the identification of differentially expressed genes (DEGs), categorization of expression patterns (12 categories, 5 classes), and functional enrichment analysis. It specifically supports spike-in normalization to account for differences in transcriptome size across ploidy levels.

## Core Workflow

### 1. Data Preparation
The package requires a `SummarizedExperiment` object containing a count matrix (`assay`) and sample metadata (`colData`).

```r
library(HybridExpress)
library(SummarizedExperiment)

# Create SummarizedExperiment if starting from raw counts
se <- SummarizedExperiment(
    assays = list(counts = count_matrix),
    colData = coldata_df
)
```

### 2. Midparent Expression and Normalization
Before analysis, you must generate *in silico* midparent samples and calculate size factors.

```r
# Add midparent samples (mean, sum, or weightedmean)
# weights are typically used for different ploidy levels
se <- add_midparent_expression(se, method = "mean", 
                               generation_col = "Generation", 
                               p1 = "P1", p2 = "P2")

# Add size factors (use spikein = TRUE if ERCC controls are present)
se <- add_size_factors(se, spikein = TRUE, spikein_pattern = "ERCC")
```

### 3. Exploratory Data Analysis
Visualize sample grouping using PCA or correlation heatmaps.

```r
# PCA plot with mean coordinates for groups
pca_plot(se, color_by = "Generation", shape_by = "Ploidy", add_mean = TRUE)

# Sample correlation heatmap
plot_samplecor(se, coldata_cols = c("Generation", "Ploidy"))
```

### 4. Differential Expression Analysis
Identify DEGs across four standard contrasts: P2 vs P1, F1 vs P1, F1 vs P2, and F1 vs midparent.

```r
# Get list of DEGs
deg_list <- get_deg_list(se)

# Summarize DEG counts
deg_counts <- get_deg_counts(deg_list)

# Visualize results with the Expression Triangle
plot_expression_triangle(deg_counts)
```

### 5. Gene Classification
Classify genes into 5 major classes: UP (transgressive up), DOWN (transgressive down), ADD (additivity), ELD_P1 (dominance P1), and ELD_P2 (dominance P2).

```r
# Classify genes
exp_partitions <- expression_partitioning(deg_list)

# Visualize partitions
plot_expression_partitions(exp_partitions, group_by = "Class")
plot_partition_frequencies(exp_partitions, group_by = "Class")
```

### 6. Functional Analysis (ORA)
Perform overrepresentation analysis on specific gene sets (e.g., additive genes).

```r
# Define gene set and background
genes_add <- exp_partitions$Gene[exp_partitions$Class == "ADD"]
bg <- rownames(se)

# Run ORA (requires an annotation data frame: gene ID in col 1)
ora_results <- ora(genes_add, annotation_df, background = bg)
```

## Tips and Best Practices
- **Ploidy Weights**: When using `method = "weightedmean"` in `add_midparent_expression()`, ensure the `weights` vector matches the ploidy ratio of P1 and P2.
- **Genome Reference**: By default, `get_deg_counts()` calculates percentages based on genes in the count matrix. To reflect the whole genome, manually update `attributes(deg_list)$ngenes <- total_genome_count` before running the count function.
- **Spike-ins**: If using `spikein = TRUE` in `add_size_factors()`, the function automatically removes the spike-in rows from the object after calculating factors to prevent them from biasing downstream DE tests.

## Reference documentation
- [Comparative transcriptomic analysis of hybrids and their progenitors](./references/HybridExpress.md)